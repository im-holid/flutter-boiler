import 'package:flutter/material.dart';

import 'package:pinput/pinput.dart';
import 'package:hiro_app/theme/colors.dart';

class AntiPin extends StatefulWidget {
  final TextEditingController pinController;

  // Validator before hit API
  final String? Function(String?)? onValidator;

  // Function triggered when pin completed
  final void Function()? onFullfil;

  // Error text after get result from hit API
  final String? errorText;

  // If errorText not null, onResetError must be not null
  final void Function()? onResetError;

  const AntiPin(
      {super.key,
      required this.pinController,
      this.onValidator,
      this.onFullfil,
      this.onResetError,
      this.errorText});

  @override
  State<AntiPin> createState() => _AntiPinState();
}

class _AntiPinState extends State<AntiPin> {
  final _pinputFocusNode = FocusNode();
  String _errorText = '';

  @override
  void initState() {
    super.initState();
    if (widget.errorText != null && widget.onResetError == null) {
      throw ArgumentError(
          'onResetError must be provided when errorText is not null, example : setState(() => errorText = '
          ');');
    }
    _pinputFocusNode.requestFocus();
  }

  Widget _preFilledWidget() {
    bool isError = false;
    if (_errorText.isNotEmpty || (widget.errorText != null && widget.errorText!.isNotEmpty)) {
      isError = true;
    }
    return Container(
      height: 14,
      width: 14,
      decoration: BoxDecoration(
        color: isError ? error : primaryBlackLight,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }

  Widget _obscuringWidget() {
    return Container(
      height: 14,
      width: 14,
      decoration: BoxDecoration(
        color: primaryBlack,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }

  Widget _cursorWidget() {
    return Container(
      height: 14,
      width: 14,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: primaryBlack,
          width: 1,
        ),
      ),
    );
  }

  Widget _buildErrorText() {
    String errorText = '';
    if (_errorText.isNotEmpty) {
      errorText = _errorText;
    }
    if (widget.errorText != null && widget.errorText!.isNotEmpty) {
      errorText = widget.errorText!;
    }
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 16),
      child: Text(
        errorText,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: error, fontWeight: FontWeight.w300),
      ),
    );
  }

  Widget _buildInputPin() {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 24),
          child: Pinput(
            length: 6,
            controller: widget.pinController,
            focusNode: _pinputFocusNode,
            defaultPinTheme: PinTheme(decoration: BoxDecoration(color: Colors.transparent)),
            preFilledWidget: _preFilledWidget(),
            obscureText: true,
            obscuringWidget: _obscuringWidget(),
            cursor: _cursorWidget(),
            separator: SizedBox(width: 37.0),
            androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
            listenForMultipleSmsOnAndroid: true,
            hapticFeedbackType: HapticFeedbackType.selectionClick,
            onCompleted: (value) {
              if (widget.onValidator != null) {
                if (widget.onValidator!(value) != null && widget.onValidator!(value)!.isNotEmpty) {
                  setState(() {
                    _errorText = widget.onValidator!(value)!;
                  });
                  widget.pinController.text = '';
                  _pinputFocusNode.requestFocus();
                  return;
                }
              }
              if (widget.onFullfil != null) {
                widget.onFullfil!();
              }
            },
            onTap: () {
              if (widget.onResetError != null) {
                widget.onResetError!();
              }
              setState(() {
                if (_errorText.isNotEmpty) {
                  setState(() {
                    _errorText = '';
                  });
                }
              });
              _pinputFocusNode.requestFocus();
            },
            onChanged: (value) {},
          ),
        ),
        _buildErrorText()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildInputPin();
  }
}
