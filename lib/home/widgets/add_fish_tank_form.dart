import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_fishtank/home/cubit/home_cubit.dart';

class AddFishTankForm extends StatefulWidget {
  const AddFishTankForm({super.key});

  @override
  State<AddFishTankForm> createState() => _AddFishTankFormState();
}

class _AddFishTankFormState extends State<AddFishTankForm> {
  final fishTankIdCont =
      TextEditingController(text: 'c0a35a64-3181-42d4-b8c5-a7883f0cfcb6');
  final titleCont = TextEditingController(text: 'Akwarium');

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Dodaj Akwarium'),
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
                    .read<HomeCubit>()
                    .addFishTank(fishTankIdCont.text, titleCont.text);
              },
              child: Text('Dodaj'),
            )
          ],
        ),
      ),
    );
  }
}
