import 'package:flutter/material.dart';

class descriptionfield extends StatelessWidget {
  final TextEditingController inputController;
  final String hinttext;
  final String labeltext;
  descriptionfield(
      {Key? key,
      required this.inputController,
      required this.hinttext,
      required this.labeltext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const primaryColor = Colors.black;
    const secondaryColor = Colors.black;
    final accentColor = Colors.grey.shade200;

    const backgroundColor = Color(0xffffffff);
    const errorColor = Color(0xffEF4444);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            labeltext,
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Card(
          elevation: 0,
          child: TextFormField(
            minLines: 8,
            maxLines: 10,
            controller: inputController,
            onChanged: (value) {
              //Do something wi
            },
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(fontSize: 14, color: Colors.black),
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: accentColor,
              hintText: hinttext,
              hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            ),
          ),
        ),
      ],
    );
  }
}
