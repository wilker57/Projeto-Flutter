import 'package:flutter/material.dart';

class EstudanteAddPage extends StatelessWidget {
  const EstudanteAddPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Dialog(
      child: Container(
        padding: EdgeInsets.all(10),

        height: 300,

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),

          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 6 , 22, 6),
              offset: Offset(0.5, 0.5),
              spreadRadius: 1.5,
            ),
          ]
        ),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            TextFormField(),
          ],
        ),
      ),
    );
  }
}