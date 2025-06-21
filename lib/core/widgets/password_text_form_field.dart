import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../core/widgets/app_text_form_field.dart';

class PasswordTextFormField extends StatefulWidget {
  final Function(String?)? onSaved;

  const PasswordTextFormField({super.key, this.onSaved});

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      onSaved: widget.onSaved,
      isObscureText: isObscure,
      hintText: 'signin.password'.tr(),
      suffixIcon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
          onPressed: () {
            setState(() {
              isObscure = !isObscure;
            });
          },
          icon: ImageIcon(
            AssetImage(
              isObscure ? 'assets/icons/eye.png' : 'assets/icons/close_eye.png',
            ),

            size: 26,
          ),
        ),
      ),
    );
  }
}
