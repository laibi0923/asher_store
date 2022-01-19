import 'package:flutter/material.dart';
import 'package:asher_store/constants.dart';

class CustomizeTextField extends StatelessWidget {
  final String? title;
  final bool? isPassword;
  final TextEditingController? textEditingController;
  final bool? isenabled;
  final int? minLine;
  final int? maxLine;

  const CustomizeTextField({Key? key, this.title, this.isPassword, this.textEditingController, this.isenabled, this.minLine, this.maxLine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
        decoration: const BoxDecoration(
          color: Color(cGrey),
          borderRadius: BorderRadius.all(Radius.circular(7))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title!),
            TextFormField(
              minLines: minLine,
              maxLines: maxLine,
              enabled: isenabled,
              controller: textEditingController,
              obscureText: isPassword == true ? true : false,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(0),
                isDense: true,
                border: InputBorder.none
              ),
            ),
          ],
        ),
      ),
    );
  }
}

