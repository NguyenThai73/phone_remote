import 'package:flutter/material.dart';
import '../models/product.dart';

class PhoneArt extends StatelessWidget {
  const PhoneArt({
    super.key,
    required this.product,
    this.colorIndex = 0,
    this.size = 138,
  });
  final Product product;
  final int colorIndex;
  final double size;

  @override
  Widget build(BuildContext context) {
    final color = product.colors[colorIndex];
    return SizedBox(
      width: size * .72,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.translate(
            offset: Offset(size * .10, -size * .045),
            child: Transform.rotate(
              angle: .12,
              child: _device(size, color, false),
            ),
          ),
          Transform.translate(
            offset: Offset(-size * .10, size * .045),
            child: Transform.rotate(
              angle: -.10,
              child: _device(size, color, true),
            ),
          ),
        ],
      ),
    );
  }

  Widget _device(double height, Color color, bool front) {
    return Container(
      width: height * .49,
      height: height * .90,
      padding: EdgeInsets.all(height * .022),
      decoration: BoxDecoration(
        color: front ? const Color(0xFF242A32) : color,
        borderRadius: BorderRadius.circular(height * .095),
        border: Border.all(
          color: Colors.white.withValues(alpha: .75),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .18),
            blurRadius: 16,
            offset: const Offset(5, 10),
          ),
        ],
      ),
      child: front
          ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(height * .075),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [product.accent, color, const Color(0xFF202C43)],
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: height * .15,
                    height: height * .028,
                    decoration: const BoxDecoration(
                      color: Color(0xFF12191E),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(12),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.blur_on_rounded,
                    size: height * .30,
                    color: Colors.white.withValues(alpha: .23),
                  ),
                  const Spacer(),
                ],
              ),
            )
          : Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: height * .19,
                height: height * .22,
                padding: EdgeInsets.all(height * .018),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: .85),
                  borderRadius: BorderRadius.circular(height * .045),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: .45),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    3,
                    (_) => Container(
                      width: height * .05,
                      height: height * .05,
                      decoration: BoxDecoration(
                        color: const Color(0xFF27313B),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white54, width: 2),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
