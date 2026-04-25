import 'package:flutter/material.dart';

class AppBranding {
  static const String lightLogoAsset =
      'assets/images/vetaura_logo_light.jpeg';
  static const String darkLogoAsset =
      'assets/images/vetaura_logo_dark.jpeg';
  static const String transparentLogoAsset =
      'assets/images/vetaura_logo_transparent.png';

  static String logoForTheme(bool isDark) {
    return isDark ? darkLogoAsset : lightLogoAsset;
  }
}

class AppBrandLogo extends StatelessWidget {
  final bool isDark;
  final bool useTransparent;
  final double width;
  final double? height;

  const AppBrandLogo({
    super.key,
    required this.isDark,
    this.useTransparent = false,
    this.width = 220,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final asset = useTransparent
        ? AppBranding.transparentLogoAsset
        : AppBranding.logoForTheme(isDark);

    return Image.asset(
      asset,
      width: width,
      height: height,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => _FallbackBrandLogo(
        isDark: isDark,
        width: width,
      ),
    );
  }
}

class _FallbackBrandLogo extends StatelessWidget {
  final bool isDark;
  final double width;

  const _FallbackBrandLogo({
    required this.isDark,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final blue = const Color(0xFF1C74FF);
    final cyan = const Color(0xFF38D6FF);

    return SizedBox(
      width: width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [cyan, blue],
            ).createShader(bounds),
            child: const Icon(
              Icons.pets_rounded,
              size: 82,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'VETAURA',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 34,
              letterSpacing: 8,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : const Color(0xFF0F49B5),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'CARE. CONNECT. COMPANION.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              letterSpacing: 3.2,
              fontWeight: FontWeight.w600,
              color: isDark ? cyan : blue,
            ),
          ),
        ],
      ),
    );
  }
}
