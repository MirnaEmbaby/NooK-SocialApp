import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:noook/shared/styles/colors.dart';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (route) => false,
    );

Widget? defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChanged,
  Function? onTap,
  bool isPassword = false,
  required Function validate,
  required String label,
  required IconData prefix,
  required bool hasSuffix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit != null ? (s) => onSubmit(s) : null,
      onChanged: onChanged != null ? (s) => onChanged(s) : null,
      onTap: onTap != null ? () => onTap() : null,
      validator: (s) => validate(s),
      decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(
            prefix,
            color: myIndigo,
          ),
          suffixIcon: hasSuffix
              ? IconButton(
                  onPressed: () => suffixPressed!(),
                  icon: Icon(
                    suffix,
                    color: myIndigo,
                  ),
                )
              : null,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: myIndigo,
              width: 2.0,
            ),
          ),
          enabledBorder: const OutlineInputBorder()),
    );

Widget defaultButton({
  double width = double.infinity,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function? function,
  required String? text,
}) =>
    Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: myIndigo,
      ),
      child: MaterialButton(
        onPressed: () {
          function!();
        },
        child: Text(
          isUpperCase ? text!.toUpperCase() : text!,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultTextButton({
  required Function function,
  required String? text,
  Color? color,
}) =>
    TextButton(
      onPressed: () {
        function();
      },
      child: Text(
        text!.toUpperCase(),
        style: TextStyle(
          color: color,
        ),
      ),
    );

enum ToastStates { success, error, warning }

void showToast(String? text, ToastStates state) => Fluttertoast.showToast(
    msg: text!,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: toastColor(state),
    textColor: Colors.white,
    fontSize: 16.0);

Color toastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = Colors.green.withOpacity(0.7);
      break;
    case ToastStates.error:
      color = Colors.red.withOpacity(0.7);
      break;
    case ToastStates.warning:
      color = Colors.amber.withOpacity(0.7);
      break;
  }
  return color;
}

// void signOut(context) {
//   CacheHelper.removeData(key: 'token').then(
//     (value) => navigateAndFinish(
//       context,
//       LoginScreen(),
//     ),
//   );
// }

void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => debugPrint(match.group(0)));
}

String? uId = '';
