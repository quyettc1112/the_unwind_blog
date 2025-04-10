import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class CircleTabIndicator extends Decoration {
  final double radius;
  final Color color;

  CircleTabIndicator({
    required this.radius,
    required this.color,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(radius: radius, color: color);
  }
}

class _CirclePainter extends BoxPainter {
  final double radius;
  final Color color;

  _CirclePainter({required this.radius, required this.color});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Paint _paint = Paint()
      ..color = color
      ..isAntiAlias = true;

    final Offset circleOffset = offset + Offset(
      cfg.size!.width / 2,
      cfg.size!.height - radius,
    );

    canvas.drawCircle(circleOffset, radius, _paint);
  }
}