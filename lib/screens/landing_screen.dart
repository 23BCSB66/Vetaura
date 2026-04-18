import 'dart:async';

import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'signup_screen.dart';

class _LandingImage {
  final ImageProvider provider;
  final String key;

  const _LandingImage({
    required this.provider,
    required this.key,
  });
}

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with WidgetsBindingObserver {
  final List<_LandingImage> _images = const [
    _LandingImage(
      provider: AssetImage('assets/images/pexels-adityasanjay97-2579504.jpg'),
      key: 'dog_asset_1',
    ),
    _LandingImage(
      provider: AssetImage('assets/images/pexels-delot-31440990.jpg'),
      key: 'cat_asset_1',
    ),
    _LandingImage(
      provider:
          AssetImage('assets/images/pexels-mohammed-asaad-896403946-28543974.jpg'),
      key: 'dog_asset_2',
    ),
    _LandingImage(
      provider: AssetImage('assets/images/pexels-tamhasipkhan-6601811.jpg'),
      key: 'street_pet_asset',
    ),
    _LandingImage(
      provider: NetworkImage(
        'https://images.unsplash.com/photo-1444464666168-49d633b86797?w=1200&h=1800&fit=crop',
      ),
      key: 'bird_network',
    ),
    _LandingImage(
      provider: NetworkImage(
        'https://images.unsplash.com/photo-1548767797-d8c844163c4c?w=1200&h=1800&fit=crop',
      ),
      key: 'guinea_pig_network',
    ),
    _LandingImage(
      provider: NetworkImage(
        'https://images.unsplash.com/photo-1425082661705-1834bfd09dca?w=1200&h=1800&fit=crop',
      ),
      key: 'hamster_network',
    ),
    _LandingImage(
      provider: NetworkImage(
        'https://images.unsplash.com/photo-1585110396000-c9ffd4e4b308?w=1200&h=1800&fit=crop',
      ),
      key: 'rabbit_network',
    ),
  ];

  Timer? _timer;
  int _activeImageIndex = 0;
  bool _didPrecache = false;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _pageController = PageController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didPrecache) return;

    _didPrecache = true;
    for (final image in _images) {
      precacheImage(image.provider, context);
    }
    _startCarousel();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _startCarousel();
      return;
    }

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.hidden) {
      _timer?.cancel();
    }
  }

  void _startCarousel() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted || !_pageController.hasClients) return;
      _animateToIndex((_activeImageIndex + 1) % _images.length);
    });
  }

  void _animateToIndex(int index) {
    if (!_pageController.hasClients) return;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeOutCubic,
    );
  }

  void _handleManualSwipe(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    if (velocity.abs() < 120) return;

    if (velocity < 0) {
      _animateToIndex((_activeImageIndex + 1) % _images.length);
    } else {
      _animateToIndex(
        (_activeImageIndex - 1 + _images.length) % _images.length,
      );
    }
    _startCarousel();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: isDark
                      ? const [Color(0xFF0B1311), Color(0xFF15211D)]
                      : const [Color(0xFF0F6158), Color(0xFF081B19)],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: PageView.builder(
              controller: _pageController,
              physics: const BouncingScrollPhysics(),
              onPageChanged: (index) {
                setState(() => _activeImageIndex = index);
                _startCarousel();
              },
              itemCount: _images.length,
              itemBuilder: (context, index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: _images[index].provider,
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(isDark ? 0.48 : 0.34),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                  child: const SizedBox.expand(),
                );
              },
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.10),
                    Colors.black.withOpacity(0.18),
                    Colors.black.withOpacity(0.52),
                  ],
                  stops: const [0.0, 0.45, 1.0],
                ),
              ),
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onHorizontalDragEnd: _handleManualSwipe,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  children: [
                    const SizedBox(height: 42),
                    Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.14),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.18),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.18),
                            blurRadius: 30,
                            offset: const Offset(0, 16),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.pets_rounded,
                        size: 46,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'Vetaura',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 3,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: Text(
                        'Care, rescue, and safe homes for animals when they need us most.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: Colors.white.withOpacity(0.86),
                          height: 1.45,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _images.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeOut,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          height: 8,
                          width: _activeImageIndex == index ? 24 : 8,
                          decoration: BoxDecoration(
                            color: _activeImageIndex == index
                                ? Colors.white
                                : Colors.white54,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _PrimaryButton(
                          label: 'LOG IN',
                          bgColor: Colors.transparent,
                          textColor: Colors.white,
                          comfy: true,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        _PrimaryButton(
                          label: 'SIGN UP',
                          bgColor: Colors.white.withOpacity(0.12),
                          textColor: Colors.white,
                          border: true,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SignUpScreen(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String label;
  final Color bgColor;
  final Color textColor;
  final VoidCallback onTap;
  final bool border;
  final bool comfy;

  const _PrimaryButton({
    required this.label,
    required this.bgColor,
    required this.textColor,
    required this.onTap,
    this.border = false,
    this.comfy = false,
  });

  @override
  Widget build(BuildContext context) {
    final buttonChild = SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: comfy ? Colors.transparent : bgColor,
          side: border
              ? const BorderSide(color: Colors.white, width: 1.5)
              : BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          padding: EdgeInsets.zero,
          elevation: 0,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w700,
            fontSize: 15,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );

    if (!comfy) return buttonChild;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF19B5A2), Color(0xFF0B7F73)],
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0B7F73).withOpacity(0.36),
            blurRadius: 22,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: buttonChild,
    );
  }
}
