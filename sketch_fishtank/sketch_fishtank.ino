#include <Arduino.h>
#include "credentials.h"
#include <WiFi.h>
#include "time.h"
#include <Firebase_ESP_Client.h>

#include "addons/TokenHelper.h"
#include "addons/RTDBHelper.h"

// Define Firebase objects
FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;
String smartFishTankPath = String("fishTanks/") + String(DEVICE_UUID);

// Variable to save USER UID
String uid;

bool initSettinsHasFetched = false;
unsigned long initSettinsPrevMilis = 0;
// Time fields
const char *timeNtpServer1 = "pool.ntp.org";
const char *timeNtpServer2 = "time.nist.gov";
const long gmtOffset_sec = 0;
const int daylightOffset_sec = 3600;

// Pin fields
class Socket {
  int SOCKET_PIN;
  int hourFrom;
  int minFrom;
  int hourTo;
  int minTo;

  bool stateOn;

  bool isHourValid(int hour) {
    return hour >= 0 && hour < 24;
  }

  bool isMinValid(int min) {
    return min >= 0 && min < 60;
  }

public:
  char *SOCKET_NAME;

  Socket(int pin, char *name) {
    SOCKET_PIN = pin;
    SOCKET_NAME = name;
    hourFrom = -1;
    minFrom = -1;
    hourTo = -1;
    minTo = -1;
    stateOn = false;
  };

  void setup() {
    pinMode(SOCKET_PIN, OUTPUT);
    digitalWrite(SOCKET_PIN, HIGH);
  }

  void setTimePeriods(int hFrom, int mFrom, int hTo, int mTo) {
    if (isHourValid(hFrom) && isMinValid(mFrom) && isHourValid(hTo) && isMinValid(mTo)) {
      hourFrom = hFrom;
      minFrom = mFrom;
      hourTo = hTo;
      minTo = mTo;
      Serial.print("setTimePeriods ");
      Serial.print(SOCKET_NAME);
      Serial.println("success :)");
    } else {
      Serial.print("setTimePeriods");
      Serial.print(SOCKET_NAME);
      Serial.println("not valid");
    }
  }

  void updateState(struct tm *time) {
    if (hourFrom == -1 | minFrom == -1 | hourTo == -1 | minTo == -1) {
      Serial.print("Socket ");
      Serial.print(SOCKET_NAME);
      Serial.println(" time periods non set");
      return;
    }

    int currentHour = time->tm_hour;
    int currenMin = time->tm_min;
    int currSec = time->tm_sec;

    long timeInSec = (currentHour * 3600) + (currenMin * 60) + currSec;
    long fromInSec = (hourFrom * 3600) + (minFrom * 60);
    long toInSec = (hourTo * 3600) + (minTo * 60);

    if (timeInSec >= fromInSec & timeInSec <= toInSec) {
      digitalWrite(SOCKET_PIN, LOW);
    } else {
      digitalWrite(SOCKET_PIN, HIGH);
    }
  }
} sockets[4] = {
  { 12, "socket1" },
  { 13, "socket2" },
  { 14, "socket3" },
  { 15, "socket4" },
};

void setup() {
  Serial.begin(115200);
  setupPins();

  setupWifi();
  setupCurrentTime();
  initFirebase();
}

void loop() {
  timeLoop();
  firebaseLoop();
}

//------ start WIFI setup
void setupWifi() {
  WiFi.disconnect(true);
  delay(1000);

  WiFi.onEvent(wifiStationConnected, WiFiEvent_t::ARDUINO_EVENT_WIFI_STA_CONNECTED);
  WiFi.onEvent(wifiStationDisconnected, WiFiEvent_t::ARDUINO_EVENT_WIFI_STA_DISCONNECTED);

  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.println("Wait for WiFi... ");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print('.');
    delay(300);
  }
}

void wifiStationConnected(WiFiEvent_t event, WiFiEventInfo_t info) {
  Serial.println("Connected to WIFI successfully!");
}

void wifiStationDisconnected(WiFiEvent_t event, WiFiEventInfo_t info) {
  Serial.println("Disconnected from WiFi access point");
  Serial.print("WiFi lost connection. Reason: ");
  // Serial.println(info.wifi_sta_disconnected.reason);
  // Serial.println("Trying to Reconnect");
  // WiFi.disconnect();
  // WiFi.reconnect();
  // WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
}

//------ end WIFI setup


//------ Firebase
void streamTimeoutCallback(bool timeout) {
  if (timeout) {
    // Stream timeout occurred
    Serial.println("Stream timeout, resume streaming...");
  }
}

void streamCallback(FirebaseStream data) {
  Serial.printf("sream path, %s\nevent path, %s\ndata type, %s\nevent type, %s\n\n",
                data.streamPath().c_str(),
                data.dataPath().c_str(),
                data.dataType().c_str(),
                data.eventType().c_str());
  printResult(data);  // see addons/RTDBHelper.h
  Serial.println();

  FirebaseJson *json = data.to<FirebaseJson *>();

  if (data.eventType().equals("/settings")) {
    FirebaseJsonData settingsRes;
    json->get(settingsRes, "settings");

    if (settingsRes.success) {
      FirebaseJson settingsJson;
      settingsRes.getJSON(settingsJson);
      updateSocketsSettings(settingsJson);
    }
  }

  if (data.eventType().equals("/state")) {
    FirebaseJsonData stateRes;
    json->get(stateRes, "state");

    if (stateRes.success) {
      FirebaseJson stateJson;
      stateRes.getJSON(stateJson);
      updateSocketsState(stateJson);
    }
  }
}

void initFirebase() {
  config.api_key = FB_API_KEY;
  config.database_url = FB_DATABASE_URL;
  config.token_status_callback = tokenStatusCallback;
  config.timeout.serverResponse = 10 * 1000;
  config.max_token_generation_retry = 5;

  fbdo.setBSSLBufferSize(2048, 1024);
  fbdo.setResponseSize(2048);
  fbdo.keepAlive(5, 5, 1);

  auth.user.email = FB_USER_EMAIL;
  auth.user.password = FB_USER_PASSWORD;

  Firebase.reconnectWiFi(true);
  Firebase.begin(&config, &auth);

  // Getting the user UID might take a few seconds
  Serial.println("Getting User UID");
  while ((auth.token.uid) == "") {
    Serial.print('.');
    delay(1000);
  }
  // Print user UID
  Serial.print("User UID: ");
  Serial.println(auth.token.uid.c_str());

  Firebase.RTDB.setStreamCallback(&fbdo, streamCallback, streamTimeoutCallback);

  // set stream callbacks
  if (!Firebase.RTDB.beginStream(&fbdo, smartFishTankPath)) {
    Serial.printf("stream begin error, %s\n\n", fbdo.errorReason().c_str());
  } else {
    Serial.println("stream begin");
  }
}

void firebaseLoop() {
  if (!Firebase.ready()) {
    return;
  }

  chekcAndFetchInitialSettings();
}

void chekcAndFetchInitialSettings() {
  if (initSettinsHasFetched) {
    return;
  }
  unsigned long currentMillis = millis();
  if (initSettinsPrevMilis == 0 || (currentMillis - initSettinsPrevMilis) >= 10000) {
    initSettinsPrevMilis = currentMillis;

    FirebaseJson settingsJson;
    Firebase.RTDB.getJSON(&fbdo, smartFishTankPath + String("/settings"), &settingsJson);
    Serial.println("Fetch initial settings");
    updateSocketsSettings(settingsJson);
    initSettinsHasFetched = true;
  }
}

void updateSocketsSettings(FirebaseJson settingsJson) {
  Serial.println("updateSocketsSettings called");

  for (Socket socket : sockets) {
    FirebaseJsonData socketRes;
    settingsJson.get(socketRes, socket.SOCKET_NAME);
    if (socketRes.type != "object") {
      continue;
    }

    if (socketRes.success) {
      FirebaseJson socketJson;
      socketRes.getJSON(socketJson);

      FirebaseJsonData fromHourUtcRes, fromMinUtcRes, toHourUtcRes, toMinUtcRes;
      int fromHourUtc, fromMinUtc, toHourUtc, toMinUtc;
      socketJson.get(fromHourUtcRes, "fromHourUtc");
      socketJson.get(fromMinUtcRes, "fromMinUtc");
      socketJson.get(toHourUtcRes, "toHourUtc");
      socketJson.get(toMinUtcRes, "toMinUtc");

      if (fromHourUtcRes.success && fromMinUtcRes.success && toHourUtcRes.success && toMinUtcRes.success) {
        fromHourUtc = fromHourUtcRes.to<int>();
        fromMinUtc = fromMinUtcRes.to<int>();
        toHourUtc = toHourUtcRes.to<int>();
        toMinUtc = toMinUtcRes.to<int>();

        socket.setTimePeriods(fromHourUtc, fromMinUtc, toHourUtc, toMinUtc);
      }
    }
  }
}

void updateSocketsState(FirebaseJson stateJson) {
  Serial.println("updateSocketsState called");
}
//------ end firebase


//------ start setup current time
void setupCurrentTime() {
  configTime(0, 3600, timeNtpServer1, timeNtpServer2);
  printCurrentTime();
}

void printCurrentTime() {
  struct tm timeinfo;
  if (!getLocalTime(&timeinfo, 500)) {
    Serial.println("Failed to obtain time");
    return;
  }

  Serial.println(&timeinfo, "%A, %B %d %Y %H:%M:%S");
}

unsigned long previousTimeMillis = 0;

void timeLoop() {
  unsigned long currentMillis = millis();
  if (previousTimeMillis == 0 || currentMillis - previousTimeMillis >= 10000) {
    previousTimeMillis = currentMillis;
    struct tm timeinfo;
    Serial.println("timeLoop");
    if (!getLocalTime(&timeinfo, 500)) {
      return;
    }
    printCurrentTime();

    for (Socket socket : sockets) {
      socket.updateState(&timeinfo);
    }
  }
}
//------ end current time setup

void setupPins() {
  for (Socket socket : sockets) {
    socket.setup();
  }
}
