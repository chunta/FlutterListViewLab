import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 160,
      height: 160,
      child: SizedBox(
        height: 50.0,
        width: 50.0,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
