import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: [
            Text(
              'No Transactions Added Yet!',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: isLandscape ? 5 : 35,
            ),
            Container(
                height: constraints.maxHeight * 0.6,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                )),
          ],
        );
      },
    );
  }
}
