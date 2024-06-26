import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'cubit/my_fish_tanks_cubit.dart';

class MyFishTanksPage extends StatelessWidget {
  const MyFishTanksPage({super.key});

  static const String path = '/my-fish-tanks';
  static const String name = 'my-fish-tanks';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<MyFishTanksCubit>(),
      lazy: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Moje akwaria'),
        ),
        body: SafeArea(
          child: MyFishTanksContent(),
        ),
      ),
    );
  }
}

class MyFishTanksContent extends StatefulWidget {
  const MyFishTanksContent({super.key});

  @override
  State<MyFishTanksContent> createState() => _MyFishTanksContentState();
}

class _MyFishTanksContentState extends State<MyFishTanksContent> {
  final fishTankIdCont =
      TextEditingController(text: 'c0a35a64-3181-42d4-b8c5-a7883f0cfcb6');
  final titleCont = TextEditingController(text: 'Akwarium');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextFormField(
            controller: fishTankIdCont,
            decoration: InputDecoration(hintText: 'Id'),
          ),
          TextFormField(
            controller: titleCont,
            decoration: InputDecoration(hintText: 'Title'),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              context
                  .read<MyFishTanksCubit>()
                  .addFishTank(fishTankIdCont.text, titleCont.text);
            },
            child: Text('Dodaj'),
          )
        ],
      ),
    );
  }
}
