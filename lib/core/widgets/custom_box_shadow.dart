import 'package:flutter/material.dart';

class CustomBoxShadow extends BoxShadow {
  const CustomBoxShadow({
    super.color = Colors.transparent,
    super.offset,
    super.blurRadius,
    this.blurStyle = BlurStyle.normal,
  });

  // ignore: annotate_overrides, overridden_fields
  final BlurStyle blurStyle;

  @override
  Paint toPaint() {
    final Paint result = super.toPaint()..maskFilter = _getMaskFilter();
    return _applyDebugMode(result);
  }

  MaskFilter _getMaskFilter() {
    return MaskFilter.blur(blurStyle, blurSigma);
  }

  Paint _applyDebugMode(Paint paint) {
    assert(() {
      if (debugDisableShadows) {
        paint.maskFilter = null;
      }
      return true;
    }());
    return paint;
  }
}
