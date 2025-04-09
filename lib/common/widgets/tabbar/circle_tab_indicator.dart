import 'package:flutter/cupertino.dart';

class CircleTabIndicator extends Decoration {
  final Color color;
  final double radius;

  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final double radius;
  final Color color;

  _CirclePainter({required this.color, required this.radius});

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