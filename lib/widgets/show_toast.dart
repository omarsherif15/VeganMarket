
import 'package:flutter/cupertino.dart';
import 'package:toastification/toastification.dart';

ToastificationItem showToast (
    ToastificationType type,
    String title,
    ){
  return toastification.show(
    title: Text(title),
    borderRadius: BorderRadius.circular(10),
    autoCloseDuration: const Duration(seconds: 5),
    type: type,
    closeOnClick: true,
    dragToClose: true,
    style: ToastificationStyle.fillColored,
  );
}