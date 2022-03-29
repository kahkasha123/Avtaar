import 'package:avtar/Utils/dimension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class ProfileTextField extends StatelessWidget {
  final IconData iconData;
  final TextEditingController textEditingController;
  final TextCapitalization? textCapitalization;
  final String labelText;
  final String initText;
  final bool isEditingEnabled;
  final TextInputType? type;
  final int? maxLength;
  final String? Function(String?)? validate;

  const ProfileTextField(
      {Key? key,
      required this.iconData,
      required this.textEditingController,
      required this.labelText,
      required this.initText,
      required this.isEditingEnabled,
      this.type,
      this.maxLength,
      this.validate,
      this.textCapitalization})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vpH = getViewportHeight(context);
    final vpW = getViewportWidth(context);
    return Container(
        margin:
            EdgeInsets.symmetric(horizontal: vpW * 0.1, vertical: vpH * 0.013),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                height: vpH * 0.06,
                width: vpH * 0.06,
                color: Colors.purple.withOpacity(0.2),
                child: Icon(iconData, color: Colors.purple, size: vpH * 0.035),
              ),
            ),
            SizedBox(width: vpW * 0.03),
            Expanded(
              child: TextFormField(
                keyboardType: type,
                textCapitalization: textCapitalization != null
                    ? textCapitalization!
                    : TextCapitalization.none,
                controller: textEditingController,
                textInputAction: TextInputAction.next,
                enableSuggestions: true,
                enableIMEPersonalizedLearning: true,
                enableInteractiveSelection: true,
                maxLength: maxLength,
                maxLengthEnforcement: maxLength == null
                    ? MaxLengthEnforcement.none
                    : MaxLengthEnforcement.enforced,
                enabled: isEditingEnabled,
                validator: validate,
                decoration: InputDecoration(
                  counterText: '',
                  contentPadding: EdgeInsets.only(
                    bottom: vpH * 0.00,
                    top: vpH * 0.005,
                  ),
                  labelText: labelText,
                  
                ),
              ),
            )
          ],
        ));
  }
}
