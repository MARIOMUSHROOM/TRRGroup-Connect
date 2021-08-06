import 'package:ai_flutter/home/activity/widget/custom_text_form_field_style.dart';
import 'package:flutter/material.dart';

class InputFormWidget extends StatelessWidget {
  const InputFormWidget({
    Key key,
    TextEditingController textEditingController,
    @required this.requireText,
    @required this.validator,
    @required this.keyboardType,
    this.leader,
    this.title,
    this.bit,
  })  : _textEditingController = textEditingController,
        super(key: key);

  final TextEditingController _textEditingController;
  final String requireText;
  final Function(String) validator;
  final TextInputType keyboardType;
  final String leader;
  final String title;
  final String bit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title == null ? SizedBox() : Text(title),
          Row(
            children: [
              leader == null
                  ? SizedBox()
                  : Expanded(
                      flex: 3,
                      child: Text(
                        leader,
                        textAlign: TextAlign.start,
                      ),
                    ),
              Expanded(
                flex: 10,
                child: TextFormField(
                  controller: _textEditingController,
                  keyboardType: keyboardType,
                  decoration: CustomTextFormFieldStyle.textFieldStyle(
                    labelTextStr: "",
                    hintTextStr: requireText,
                    suffixText: bit == null ? "" : bit,
                  ),
                  validator: validator,
                ),
              ),
              // bit == null
              //     ? SizedBox()
              //     : Expanded(
              //         flex: 2,
              //         child: Text(
              //           bit,
              //           textAlign: TextAlign.center,
              //         ),
              //       ),
            ],
          ),
        ],
      ),
    );
  }
}
