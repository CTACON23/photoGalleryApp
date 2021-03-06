import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';

showToast(String msg, BuildContext context, {int duration, int gravity}) {
  Toast.show(msg, context, duration: duration, gravity: gravity);
}
