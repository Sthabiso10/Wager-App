import 'dart:ui';
import 'package:flutter/material.dart';

class BackgroundBlobs extends StatelessWidget {
  final Color primary;
  final Color secondary;

  const BackgroundBlobs({
    super.key,
    this.primary = const Color(0xFF02C697), // your primary color
    this.secondary = const Color(0xFF00FF00), // your secondary color
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        // Top-left blob
        Positioned(
          top: -50,
          left: size.width * 0.2,
          child: _blurBlob(
            width: 400,
            height: 400,
            color: const Color.fromRGBO(2, 198, 151, 0.1),
            blur: 150,
          ),
        ),

        // Bottom-right blob
        Positioned(
          bottom: -50,
          right: size.width * 0.15,
          child: _blurBlob(
            width: 400,
            height: 400,
            color: const Color.fromRGBO(0, 255, 0, 0.1),
            blur: 150,
          ),
        ),

        // Center blob with subtle gradient
        Positioned(
          top: size.height * 0.4,
          left: size.width * 0.5 - 300,
          child: _gradientBlob(
            width: 600,
            height: 600,
            colors: [
              const Color.fromRGBO(128, 0, 128, 0.05),
              const Color.fromRGBO(255, 0, 255, 0.03),
            ],
            blur: 200,
          ),
        ),
      ],
    );
  }

  /// Simple blurred circle
  Widget _blurBlob({
    required double width,
    required double height,
    required Color color,
    required double blur,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(color: Colors.transparent),
      ),
    );
  }

  /// Gradient blurred circle for center
  Widget _gradientBlob({
    required double width,
    required double height,
    required List<Color> colors,
    required double blur,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: colors,
          stops: const [0.0, 1.0],
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(color: Colors.transparent),
      ),
    );
  }
}
