import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app.effects.dart';
import '../theme/app.colors.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool isPassword;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool enableSuggestions;
  final TextInputAction? textInputAction;
  final TextInputFormatter? inputFormatter;
  final void Function(String)? onChanged;
  final IconData? prefixIcon;
  final Color? prefixIconColor;

  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    this.isPassword = false,
    this.validator,
    this.keyboardType,
    this.enableSuggestions = false,
    this.textInputAction,
    this.inputFormatter,
    this.onChanged,
    this.prefixIcon,
    this.prefixIconColor,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool _obscureText = true;

  void _toggleObscureText() => setState(() => _obscureText = !_obscureText);

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      initialValue: widget.controller.text,
      validator: (v) =>
          widget.validator?.call(widget.controller.text) ??
          (widget.controller.text.isEmpty ? 'Campo obrigatório' : null),
      builder: (fieldState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(100),
                boxShadow: AppEffects.shadowSoft,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: TextField(
                  controller: widget.controller,
                  obscureText: widget.isPassword && _obscureText,
                  keyboardType: widget.keyboardType,
                  keyboardAppearance:
                      Theme.of(context).brightness == Brightness.dark
                      ? Brightness.dark
                      : Brightness.light,
                  enableSuggestions: widget.enableSuggestions,
                  autocorrect: widget.enableSuggestions,
                  textInputAction: widget.textInputAction,
                  inputFormatters: widget.inputFormatter != null
                      ? [widget.inputFormatter!]
                      : null,
                  onChanged: (val) {
                    fieldState.didChange(val);
                    if (widget.onChanged != null) widget.onChanged!(val);
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.surface,
                    hintText: widget.label,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    prefixIcon: widget.prefixIcon != null
                        ? Padding(
                            padding: EdgeInsets.only(left: 14.r),
                            child: Icon(
                              widget.prefixIcon,
                              color:
                                  widget.prefixIconColor ??
                                  AppColors.textSubtitle,
                            ),
                          )
                        : null,
                    suffixIcon: widget.isPassword
                        ? Padding(
                            padding: EdgeInsets.only(right: 12.r),
                            child: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey[700],
                              ),
                              onPressed: _toggleObscureText,
                            ),
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.r,
                      vertical: 12.r,
                    ),
                  ),
                ),
              ),
            ),
            if (fieldState.errorText != null)
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 8),
                child: Text(
                  fieldState.errorText!,
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(color: AppColors.error),
                ),
              ),
          ],
        );
      },
    );
  }
}
