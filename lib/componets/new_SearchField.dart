// ignore_for_file: curly_braces_in_flow_control_structures, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewSearchfield extends StatefulWidget {
  final String title;

  final bool isPadding;
  final String hintText;
  final String? errorText;
  final bool readOnly;
  final bool isOptional;
  final int maxLine;
  final VoidCallback? callback;
  final String sufixIcon;
  final Function(String value) onChange;
  final Function(String value)? onFieldSubmitted;

  final Function? onEditingComplete;
  final TextEditingController controller;
  final TextInputType keyBoardType;
  final int? maxLength;
  const NewSearchfield(
      {super.key,
      this.maxLength,
      required this.onChange,
      this.onEditingComplete,
      this.isPadding = true,
      this.keyBoardType = TextInputType.text,
      this.readOnly = false,
      this.isOptional = false,
      this.title = '',
      this.sufixIcon = "",
      this.onFieldSubmitted,
      required this.hintText,
      this.errorText,
      required this.controller,
      this.callback,
      this.maxLine = 1});

  @override
  _NewSearchTextFieldState createState() => _NewSearchTextFieldState();
}

class _NewSearchTextFieldState extends State<NewSearchfield> {
  FocusNode focusNode = FocusNode();
  Color borderColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title.isNotEmpty)
          Text(
            widget.title,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        if (widget.title.isNotEmpty) const SizedBox(height: 7),
        Container(
          clipBehavior: Clip.antiAlias,
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(50)),
          child: TextFormField(
            maxLength: widget.maxLength,
            maxLengthEnforcement: widget.maxLength == null
                ? MaxLengthEnforcement.none
                : MaxLengthEnforcement.enforced,
            readOnly: widget.readOnly,
            controller: widget.controller,
            obscuringCharacter: '*',
            keyboardType: widget.keyBoardType,
            focusNode: widget.readOnly ? AlwaysDisabledFocusNode() : focusNode,
            cursorColor: Colors.blueAccent,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontFamily: "Montserrat",
            ),
            maxLines: widget.maxLine,
            onChanged: (value) {
              widget.onChange(value);
            },
            onEditingComplete: () {
              if (widget.onEditingComplete != null) {
                widget.onEditingComplete!();
              }
            },
            onSaved: (v) {
              print("onSaved");
            },
            onFieldSubmitted: (v) {
              if (widget.onFieldSubmitted != null) {
                widget.onFieldSubmitted!(v);
              }
              FocusScope.of(context).unfocus();
            },
            onTap: widget.callback,
            decoration: InputDecoration(
              counter: const Offstage(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(bottom: 15, top: 15, left: 10),
                child: Image(
                  height: 20,
                  width: 20,
                  image: AssetImage("assets/images/iconsearch.jpeg"),
                ),
              ),
              hintStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 121, 120, 120),
                fontSize: 14,
                fontFamily: "Montserrat",
              ),
              hintText: widget.hintText,
              filled: true,
              fillColor: Colors.white,
              errorStyle: const TextStyle(
                height: 0.07,
                color: Colors.red,
              ),
            ),
            validator: (value) {
              if (widget.isOptional && (value!.isEmpty)) {
                setState(() {
                  borderColor = Colors.green;
                });
                return null;
              } else if (value == null || value.isEmpty) {
                setState(() {
                  borderColor = Colors.black;
                });
                return widget.errorText;
              }
              setState(() {
                borderColor = Colors.red;
              });
              return null;
            },
          ),
        ),
      ],
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}




