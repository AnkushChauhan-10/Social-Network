import 'package:flutter/material.dart';

class LoadingDialog {
  static bool _isShow = false;

  static void show(BuildContext context, {String text = "Loading..."}) {
    if (_isShow) return;
    _isShow = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (context) {
        return Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  text,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        );
      },
    ).whenComplete(() {
      _isShow = false;
    });
  }

  static void hide(BuildContext context) {
    if (_isShow) {
      Navigator.of(context, rootNavigator: true).pop();
      _isShow = false;
    }
  }
}

class TransparentLoadingDialog {
  static bool _isShow = false;

  static void show(BuildContext context) {
    if (_isShow) return;
    _isShow = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      fullscreenDialog: true,
      builder: (context) => PopScope(canPop: false, child: SizedBox.expand()),
    ).whenComplete(() {
      _isShow = false;
    });
  }

  static void hide(BuildContext context) {
    if (_isShow) {
      Navigator.of(context, rootNavigator: true).pop();
      _isShow = false;
    }
  }
}
