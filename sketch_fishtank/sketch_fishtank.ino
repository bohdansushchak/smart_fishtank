#include <Arduino.h>
#include "credentials.h"
#include <WiFi.h>
#include "time.h"
#include <Firebase_ESP_Client.h>

// Provide the token generation process info.
#include "addons/TokenHelper.h"
// Provide the RTDB payload printing info and other helper functions.
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

public:
  Socket(int pin) {
    SOCKET_PIN = pin;
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
    hourFrom = hFrom;
    minFrom = mFrom;
    hourTo = hTo;
    minTo = mTo;
  }

  void updateState(struct tm *info) {
    if (hourFrom == -1 | minFrom == -1 | hourTo == -1 | minTo == -1) {
      // Serial.print("Socket ");
      // Serial.print(SOCKET_PIN);
      // Serial.println(" time periods non set");
      return;
    }

    int currentHour = info->tm_hour;
    int currenMin = info->tm_min;
    int currentSec = info->tm_sec;

    long timeInSec = currentSec + (currenMin * 60) + currentHour * (3600);
    long fromInSec = (hourFrom * 3600) + (minFrom * 60);
    long toInSec = (hourTo * 3600) + (minTo * 60);

    if (timeInSec >= fromInSec & timeInSec <= toInSec) {
      digitalWrite(SOCKET_PIN, LOW);
    } else {
      digitalWrite(SOCKET_PIN, HIGH);
    }
  }
} sockets[4] = {
  { 1 },
  { 2 },
  { 3 },
  { 4 },
};

void setup() {
  Serial.begin(115200);

  setupPins();

  sockets[0].setTimePeriods(7, 0, 15, 0);
  sockets[1].setTimePeriods(9, 0, 13, 0);
  // sockets[2].setTimePeriods(10, 18, 10, 20);
  // sockets[3].setTimePeriods(10, 19, 10, 22);

  setupWifi();
  setupCurrentTime();
  // initFirebase();
}

void loop() {
  timeLoop();
  // firebaseLoop();
}

//------ start WIFI setup
void setupWifi() {
  WiFi.disconnect(true);
  delay(1000);

  WiFi.onEvent(wifiStationConnected, WiFiEvent_t::ARDUINO_EVENT_WIFI_STA_CONNECTED);
  // WiFi.onEvent(wifiStationDisconnected, WiFiEvent_t::ARDUINO_EVENT_WIFI_STA_DISCONNECTED);

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
  Serial.println(info.wifi_sta_disconnected.reason);
  Serial.println("Trying to Reconnect");
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
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
}

void initFirebase() {
  config.api_key = FB_API_KEY;
  config.database_url = FB_DATABASE_URL;

  auth.user.email = FB_USER_EMAIL;
  auth.user.password = FB_USER_PASSWORD;

  Firebase.reconnectWiFi(true);
  fbdo.setBSSLBufferSize(4096, 4096);
  fbdo.setResponseSize(4096);

  // Assign the callback function for the long running token generation task
  config.token_status_callback = tokenStatusCallback;
  Firebase.setDoubleDigits(5);
  config.timeout.serverResponse = 10 * 1000;
  config.max_token_generation_retry = 5;

  Firebase.begin(&config, &auth);
  // #if defined(ESP32)
  //   stream.keepAlive(5, 5, 1);
  // #endif

  // Getting the user UID might take a few seconds
  Serial.println("Getting User UID");
  while ((auth.token.uid) == "") {
    Serial.print('.');
    delay(1000);
  }
  // Print user UID
  Serial.print("User UID: ");
  Serial.println(auth.token.uid.c_str());

  // set stream callbacks
  // if (!Firebase.RTDB.beginStream(&fbdo, smartFishTankPath)) {
  //   Serial.printf("stream begin error, %s\n\n", fbdo.errorReason().c_str());
  // } else {
  //   Serial.println("stream begin");
  // }

  // Firebase.RTDB.setStreamCallback(&fbdo, streamCallback, streamTimeoutCallback);
}

void firebaseLoop() {
  if (!Firebase.ready()) {
    Serial.println("Firebase not ready");
    return;
  }

  fetchInitialSettings();

  // if (!Firebase.RTDB.readStream(&fbdo))
  //   Serial.printf("sream read error, %s\n\n", fbdo.errorReason().c_str());

  // if (fbdo.streamTimeout()) {
  //   Serial.println("stream timed out, resuming...\n");

  //   if (!fbdo.httpConnected())
  //     Serial.printf("error code: %d, reason: %s\n\n", fbdo.httpCode(), fbdo.errorReason().c_str());
  // }

  // if (fbdo.streamAvailable()) {
  //   Serial.printf("sream path, %s\nevent path, %s\ndata type, %s\nevent type, %s\n\n",
  //                 fbdo.streamPath().c_str(),
  //                 fbdo.dataPath().c_str(),
  //                 fbdo.dataType().c_str(),
  //                 fbdo.eventType().c_str());
  //   printResult(fbdo);  // see addons/RTDBHelper.h
  //   Serial.println();

  // This is the size of stream payload received (current and max value)
  // Max payload size is the payload size under the stream path since the stream connected
  // and read once and will not update until stream reconnection takes place.
  // This max value will be zero as no payload received in case of ESP8266 which
  // BearSSL reserved Rx buffer size is less than the actual stream payload.
  // Serial.printf("Received stream payload size: %d (Max. %d)\n\n", fbdo.payloadLength(), fbdo.maxPayloadLength());
  // }
  // if (!Firebase.RTDB.readStream(&stream)) {
  //   Serial.printf("sream read error, %s\n\n", stream.errorReason().c_str());
  // }

  // if (stream.streamTimeout()) {
  //   Serial.println("stream timeout, resuming...\n");
  // }

  // if (stream.streamAvailable()) {
  //   Serial.printf("sream path, %s\nevent path, %s\ndata type, %s\nevent type, %s\nvalue, %d\n\n",
  //                 stream.streamPath().c_str(),
  //                 stream.dataPath().c_str(),
  //                 stream.dataType().c_str(),
  //                 stream.eventType().c_str(),
  //                 stream.intData());

  //   if (stream.dataTypeEnum() == firebase_rtdb_data_type_json) {
  //     FirebaseJson *json = stream.to<FirebaseJson *>();
  //     Serial.println(json->raw());
  //   }
  // }
}

void fetchInitialSettings() {
  if (initSettinsHasFetched) {
    return;
  }
  unsigned long currentMillis = millis();
  if (initSettinsPrevMilis == 0 || currentMillis - initSettinsPrevMilis >= 10000) {
    initSettinsPrevMilis = currentMillis;

    FirebaseJson settingsJson;
    Firebase.RTDB.getJSON(&fbdo, smartFishTankPath + String("/settings"), &settingsJson);
    Serial.println("Fetch initial settings");
    Serial.println(settingsJson.raw());
    updateSocketsSettings(settingsJson);
  }
}

void updateSocketsSettings(FirebaseJson settingsJson) {
  char *socketsNames[4] = { "socket1", "socket2", "socket3", "socket4" };
  FirebaseJsonData socketRes;
  for (int i = 0; i < 4; i++) {
    settingsJson.get(socketRes, socketsNames[i]);
    if (socketRes.success) {
    }
  }
}
//------ end firebase


//------ start setup current time
void setupCurrentTime() {
  configTime(0, 3600, timeNtpServer1, timeNtpServer2);
  printCurrentTime();
}

void printCurrentTime() {
  struct tm timeinfo;
  if (!getLocalTime(&timeinfo, 1000)) {
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
    if (!getLocalTime(&timeinfo)) {
      return;
    }
    // printCurrentTime();

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
