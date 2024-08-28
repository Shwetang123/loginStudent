
import 'dart:math';
import 'dart:ui';

Path drawStar( size) {
  const numberOfPoints = 5;
  final path = Path();
  final double width = size.width;
  final double halfWidth = width / 2;
  final double externalRadius = halfWidth;
  final double internalRadius = halfWidth / 2.5;
  final double degreesPerStep = 360 / numberOfPoints;
  final double halfDegreesPerStep = degreesPerStep / 2;
  path.moveTo(width, halfWidth);
  for (double step = 0; step < 360; step += degreesPerStep) {
    path.lineTo(
        halfWidth +
            externalRadius * cos((step + halfDegreesPerStep) * pi / 180),
        halfWidth +
            externalRadius * sin((step + halfDegreesPerStep) * pi / 180));
    path.lineTo(
        halfWidth + internalRadius * cos((step + degreesPerStep) * pi / 180),
        halfWidth + internalRadius * sin((step + degreesPerStep) * pi / 180));
  }
  path.close();
  return path;
}



