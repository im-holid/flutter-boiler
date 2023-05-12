import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// import 'package:get/get.dart';
import 'package:flag/flag.dart';

// import 'package:hiro_app/controllers/index.dart';
import 'package:hiro_app/helper/index.dart';
import 'package:hiro_app/model/check_number.dart';
import 'package:hiro_app/model/index.dart';
import 'package:hiro_app/screen/index.dart';
import 'package:hiro_app/services/post/check_phone.dart';
// import 'package:hiro_app/screen/index.dart';
import 'package:hiro_app/theme/index.dart';
import 'package:hiro_app/widget/index.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Map<String, dynamic> _formData = {'phoneNumber': null};
  final _formKey = GlobalKey<FormState>();
  final CountryCode _country = CountryCode(name: 'Indonesia', dialCode: '62', code: 'ID');

  double? _targetWidth;
  bool isLoading = false;

  // final checkPhoneNumberCont = Get.put(CheckPhoneNumberCont());

  void onSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    setState(() {
      isLoading = true;
    });

    postCheckPhone(
      context: context,
      phoneNumber: _formData['phoneNumber'],
      phoneCode: _country.dialCode ?? '',
    ).then((value) {
      if (value != null) {
        CheckNumber checkNumber = value;
        if (checkNumber.status == EnumNumberStatus.registered.value) {
          Navigator.pushNamed(
            context,
            '/loginpin',
            arguments: InputPinArgumets(
              phone: _formData['phoneNumber'],
              phoneCode: _country.dialCode ?? '',
            ),
          );
          // Navigator.pushNamed(context, '/home');
        }
        // if (checkNumber.status == EnumNumberStatus.registiredNoPin.value) {
        //   Navigator.pushNamed(context, '/home');
        // }
        // if (value == EnumNumberStatus.nonRegistered.value) {
        //   Navigator.pushNamed(context, '/home');
        // }
      }
    }).whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
  }

  Widget _buildTncPp() {
    return SizedBox(
      width: _targetWidth,
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: 'By clicking continue, you agree with our',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: primaryBlackLight,
                    height: 1.5,
                  ),
            ),
            TextSpan(
              text: '\nTerms & Conditions'.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: secondaryGold, fontWeight: FontWeight.w500, height: 1.5),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print('Terms & Conditions');
                },
            ),
            TextSpan(
              text: ' and ',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: primaryBlackLight, height: 1.5),
            ),
            TextSpan(
              text: 'Privacy Policy.'.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: secondaryGold, fontWeight: FontWeight.w500, height: 1.5),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print('Privacy Policy.');
                },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Container(
      width: _targetWidth!,
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTncPp(),
          const SizedBox(
            height: 12,
          ),
          AntiButton(
            loadingColor: Colors.white,
            loading: isLoading,
            onPressed: onSubmit,
            text: 'Continue'.toUpperCase(),
          )
        ],
      ),
    );
  }

  Widget _buildPhoneCode() {
    return GestureDetector(
      onTap: () {
        // Get.to(() => CountryPage(), fullscreenDialog: true, opaque: false)
        //     ?.then((value) {
        //   if (value != null) {
        //     setState(() {
        //       _country = value;
        //     });
        //   }
        // });
      },
      child: Container(
        width: _targetWidth! * 0.25,
        height: 60,
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(border: Border(right: BorderSide(color: borderGrey, width: 1.0))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flag.fromString(
              _country.code!,
              height: 16,
              width: 22,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              '+${_country.dialCode}',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneForm() {
    return Stack(
      children: [
        TextFormField(
          keyboardType: TextInputType.phone,
          autovalidateMode: AutovalidateMode.always,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                borderSide: BorderSide(
                  color: borderGrey,
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                borderSide: BorderSide(
                  color: borderGrey,
                  width: 1.0,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                borderSide: BorderSide(
                  color: borderGrey,
                  width: 1.0,
                ),
              ),
              prefixIcon: _buildPhoneCode(),
              hintText: "812xxxxxxxx",
              hintStyle: TextStyle(
                color: Colors.black.withOpacity(0.5),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              )),
          validator: (value) => FormValidate.validatePhone(value),
          onSaved: (value) => _formData['phoneNumber'] = value,
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Container(
      margin: const EdgeInsets.only(top: 38),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Text(
            'LOGIN OR REGISTER'.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.w500, color: hiroSwatch),
          ),
          const SizedBox(height: 8),
          Text(
            'Enter your mobile phone number to login or register.',
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontWeight: FontWeight.w400, color: primaryBlackLight),
          ),
          const SizedBox(
            height: 32,
          ),
          _buildPhoneForm()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    _targetWidth = width - 32;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            width: _targetWidth!,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(child: _buildForm()),
                  _buildLoginButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
