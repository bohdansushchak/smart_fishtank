import 'package:flutter/material.dart';

class SelectBtn extends StatelessWidget {
  const SelectBtn({
    super.key,
    this.selected = false,
    required this.onPressed,
    required this.child,
  });

  final bool selected;
  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      fillColor: selected ? Colors.purple : Colors.transparent,
      elevation: 0,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      constraints: const BoxConstraints(minWidth: 88, minHeight: 40),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          child,
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 100),
            child: selected ? const Icon(Icons.check) : const SizedBox(),
          )
        ],
      ),
    );
  }
}
