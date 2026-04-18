import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'donation_screen.dart';
import 'sos_routing_screen.dart';
import 'adoption_feed_screen.dart';
import 'animal_detail_screen.dart';
import 'booking_checkout_screen.dart';
import 'care_map_screen.dart';
import 'premium_services_screen.dart';
import 'premium_plans_screen.dart';
import 'profile_screen.dart';
import '../models/animal_profile.dart';
import '../models/user_profile.dart';
import '../widgets/app_menu_drawer.dart';
import '../widgets/profile_avatar.dart';
import '../widgets/profile_popup.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _fabAnimationController;
  late Animation<double> _fabAnimation;
  late final PageController _tabPageController;
  bool _showMoreOptions = false;
  bool _showMenuButton = true;
  double? _horizontalDragStartX;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static const List<String> _featuredAnimalDistances = [
    '2.1 km away',
    '1.4 km away',
    '3.0 km away',
    '2.8 km away',
  ];

  @override
  void initState() {
    super.initState();
    _tabPageController = PageController();
    _fabAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fabAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fabAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _tabPageController.dispose();
    _fabAnimationController.dispose();
    super.dispose();
  }

  void _toggleMoreOptions() {
    HapticFeedback.lightImpact();
    setState(() {
      _showMoreOptions = !_showMoreOptions;
      if (_showMoreOptions) {
        _fabAnimationController.forward();
      } else {
        _fabAnimationController.reverse();
      }
    });
  }

  void _changeTab(int index) {
    HapticFeedback.selectionClick();
    if (_showMoreOptions) {
      _toggleMoreOptions();
    }
    setState(() {
      _selectedIndex = index;
    });
    if (_tabPageController.hasClients) {
      _tabPageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
      );
    }
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth != 0 || notification.metrics.axis != Axis.vertical) {
      return false;
    }

    if (notification is ScrollUpdateNotification &&
        notification.scrollDelta != null) {
      final shouldShow = notification.scrollDelta! < 0;
      if (shouldShow != _showMenuButton) {
        setState(() => _showMenuButton = shouldShow);
      }
    }

    return false;
  }

  void _handleHorizontalDragStart(DragStartDetails details) {
    _horizontalDragStartX = details.globalPosition.dx;
  }

  void _handleHorizontalDragEnd(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    final startedNearLeftEdge = (_horizontalDragStartX ?? 999) < 36;
    _horizontalDragStartX = null;

    if (_selectedIndex == 0 && startedNearLeftEdge && velocity > 350) {
      _scaffoldKey.currentState?.openDrawer();
    }
  }

  void _handlePageChanged(int index) {
    if (_selectedIndex != index) {
      HapticFeedback.selectionClick();
    }
    setState(() {
      _selectedIndex = index;
      _showMenuButton = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      backgroundColor: Colors.transparent,
      drawer: const AppMenuDrawer(),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isDark
                    ? const [
                        Color(0xFF10221D),
                        Color(0xFF0E1513),
                        Color(0xFF122019),
                      ]
                    : [
                        Colors.teal.shade50,
                        Colors.white,
                        Colors.green.shade50,
                      ],
              ),
            ),
          ),

          Positioned.fill(
            child: IgnorePointer(
              child: Opacity(
                opacity: isDark ? 0.025 : 0.04,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                  ),
                  itemBuilder: (_, __) => const Icon(Icons.pets, size: 30),
                ),
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onHorizontalDragStart: _handleHorizontalDragStart,
              onHorizontalDragEnd: _handleHorizontalDragEnd,
              child: PageView(
                controller: _tabPageController,
                onPageChanged: _handlePageChanged,
                children: [
                  _buildPageShell(_buildHomePage()),
                  _buildPageShell(const CareMapScreen()),
                  _buildPageShell(const AdoptionFeedScreen()),
                  _buildPageShell(const PremiumServicesScreen()),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 6,
            left: 8,
            child: AnimatedSlide(
              duration: const Duration(milliseconds: 220),
              offset: _showMenuButton ? Offset.zero : const Offset(-0.8, 0),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 180),
                opacity: _showMenuButton ? 1 : 0,
                child: Builder(
                  builder: (context) => IconButton(
                    onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                    icon: Icon(
                      Icons.menu_rounded,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: MediaQuery.of(context).padding.bottom + 64,
            child: IgnorePointer(
              ignoring: !_showMoreOptions,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 220),
                opacity: _showMoreOptions ? 1 : 0,
                child: ScaleTransition(
                  scale: _fabAnimation,
                  alignment: Alignment.bottomCenter,
                  child: Center(child: _buildPremiumFan()),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildGlassmorphicBottomBar(),
    );
  }

  Widget _buildHeader() {
    final user = context.watch<UserProfile>();
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, ${user.username}! 👋',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.055,
                      fontWeight: FontWeight.bold,
                      color: colors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Let\'s make a difference today',
                    style: TextStyle(
                      fontSize: 13,
                      color: colors.onSurface.withOpacity(0.68),
                    ),
                  ),
                ],
              ),

              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => const ProfilePopup(),
                  );
                },
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Colors.teal.shade400, Colors.green.shade400],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.teal.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: ProfileAvatar(
                      avatar: user.selectedAvatar,
                      radius: 23,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _buildStatCard("1.2K", "Animals Helped"),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard("350", "Volunteers"),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard("87", "Rescues"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: _homeCardColor(),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: _softShadowColor(),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: colors.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: colors.onSurface.withOpacity(0.68),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassmorphicBottomBar() {
    final bottomInset = MediaQuery.of(context).padding.bottom;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseButtonSize = _showMoreOptions ? 72.0 : 56.0;
    final buttonLift = _showMoreOptions ? 16.0 : 5.0;

    return SizedBox(
      height: 78 + bottomInset + buttonLift,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 0, 16, bottomInset > 0 ? 8 : 10),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Container(
                    height: 66,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          (isDark ? const Color(0xFF1A2823) : Colors.white)
                              .withOpacity(isDark ? 0.88 : 0.88),
                          (isDark ? const Color(0xFF13201C) : Colors.white)
                              .withOpacity(isDark ? 0.76 : 0.72),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        color: Colors.white.withOpacity(isDark ? 0.12 : 0.35),
                        width: 1.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(isDark ? 0.28 : 0.08),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildNavItem(Icons.home_rounded, 'Home', 0),
                        ),
                        Expanded(
                          child:
                              _buildNavItem(Icons.map_rounded, 'Care Map', 1),
                        ),
                        SizedBox(width: baseButtonSize + 20),
                        Expanded(
                          child:
                              _buildNavItem(Icons.pets_rounded, 'Adoption', 2),
                        ),
                        Expanded(
                          child: _buildNavItem(
                            null,
                            'Services',
                            3,
                            customIcon: _servicesNavIcon(_selectedIndex == 3),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: buttonLift,
              child: GestureDetector(
                  onTap: _toggleMoreOptions,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic,
                    width: baseButtonSize,
                    height: baseButtonSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: _showMoreOptions
                            ? [Colors.orange.shade300, Colors.pink.shade300]
                            : [Colors.teal.shade300, Colors.green.shade400],
                      ),
                      border: Border.all(
                        color: Colors.white.withOpacity(isDark ? 0.16 : 0.44),
                        width: 1.4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color:
                              (_showMoreOptions ? Colors.pink : Colors.teal)
                                  .withOpacity(0.30),
                          blurRadius: _showMoreOptions ? 24 : 16,
                          offset: Offset(0, _showMoreOptions ? 10 : 6),
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AnimatedBuilder(
                          animation: _fabAnimationController,
                          builder: (context, child) => Container(
                            width: baseButtonSize + (_fabAnimation.value * 18),
                            height:
                                baseButtonSize + (_fabAnimation.value * 18),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: (_showMoreOptions
                                        ? Colors.white
                                        : Colors.teal.shade50)
                                    .withOpacity(
                                  0.30 * (1 - _fabAnimation.value),
                                ),
                                width: 2.2,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: baseButtonSize - 8,
                          height: baseButtonSize - 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(isDark ? 0.06 : 0.10),
                          ),
                        ),
                        AnimatedRotation(
                          turns: _showMoreOptions ? 0.125 : 0,
                          duration: const Duration(milliseconds: 300),
                          child: Icon(
                            _showMoreOptions
                                ? Icons.close_rounded
                                : Icons.add_rounded,
                            size: _showMoreOptions ? 32 : 28,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    IconData? icon,
    String label,
    int index, {
    Widget? customIcon,
  }) {
    final isSelected = _selectedIndex == index;
    final colors = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () => _changeTab(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: isSelected
              ? colors.primary.withOpacity(0.16)
              : Colors.transparent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            customIcon ??
                Icon(
                  icon,
                  color: isSelected
                      ? colors.primary
                      : colors.onSurface.withOpacity(0.52),
                  size: 24,
                ),
            const SizedBox(height: 3),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 9.5,
                height: 1,
                fontWeight:
                isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected
                    ? colors.primary
                    : colors.onSurface.withOpacity(0.56),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _servicesNavIcon(bool isSelected) {
    final colors = Theme.of(context).colorScheme;
    final iconColor =
        isSelected ? colors.primary : colors.onSurface.withOpacity(0.52);

    return SizedBox(
      width: 24,
      height: 24,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Icon(
              Icons.work_outline_rounded,
              color: iconColor,
              size: 22,
            ),
          ),
          Positioned(
            right: -1,
            bottom: -1,
            child: Container(
              width: 11,
              height: 11,
              decoration: BoxDecoration(
                color: isSelected ? colors.primary : Colors.teal.shade400,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add_rounded,
                size: 9,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumFan() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 300,
      height: 166,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? [
                  Colors.white.withOpacity(0.03),
                  Colors.white.withOpacity(0.01),
                ]
              : [
                  Colors.white.withOpacity(0.20),
                  Colors.white.withOpacity(0.08),
                ],
        ),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.08)
              : Colors.white.withOpacity(0.35),
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            left: 18,
            bottom: 18,
            child: _buildFanAction(
              icon: Icons.vaccines_rounded,
              label: 'Vaccination',
              color: Colors.blue,
              onTap: () => _openPremiumAction(
                BookingCheckoutScreen(
                  serviceName: 'At-Home Vaccination',
                  price: 'Rs 499',
                ),
              ),
            ),
          ),
          Positioned(
            left: 74,
            top: 8,
            child: _buildFanAction(
              icon: Icons.health_and_safety_rounded,
              label: 'Vet Help',
              color: Colors.green,
              onTap: () => _openPremiumAction(
                BookingCheckoutScreen(
                  serviceName: 'Premium Vet Help',
                  price: 'Rs 299',
                ),
              ),
            ),
          ),
          Positioned(
            right: 74,
            top: 8,
            child: _buildFanAction(
              icon: Icons.volunteer_activism_rounded,
              label: 'Donate',
              color: Colors.pink,
              onTap: () => _openPremiumAction(const DonationScreen()),
            ),
          ),
          Positioned(
            right: 18,
            bottom: 18,
            child: _buildFanAction(
              icon: Icons.star_rounded,
              label: 'Plans',
              color: Colors.amber,
              onTap: () => _openPremiumAction(const PremiumPlansScreen()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFanAction({
    required IconData icon,
    required String label,
    required MaterialColor color,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [
                        color.shade900.withOpacity(0.70),
                        color.shade700.withOpacity(0.54),
                      ]
                    : [
                        Colors.white.withOpacity(0.88),
                        color.shade50.withOpacity(0.80),
                      ],
              ),
              border: Border.all(
                color: isDark
                    ? Colors.white.withOpacity(0.10)
                    : color.shade100,
                width: 1.4,
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(isDark ? 0.18 : 0.22),
                  blurRadius: isDark ? 18 : 14,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: isDark ? Colors.white : color.shade600,
              size: 29,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withOpacity(0.08)
                  : Colors.white.withOpacity(0.68),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: isDark
                    ? Colors.white.withOpacity(0.08)
                    : Colors.white.withOpacity(0.32),
              ),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: isDark ? Colors.white : color.shade800,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openPremiumAction(Widget screen) {
    HapticFeedback.selectionClick();
    _toggleMoreOptions();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  Widget _buildPageShell(Widget child) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: child,
    );
  }

  Widget _buildHomePage() {
    final featuredAnimals = MockAnimalDatabase.animals.take(4).toList();
    if (_selectedIndex >= 0) {
      return _buildHomePageContent(featuredAnimals);
    }

    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 900));
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(
          20,
          20,
          20,
          MediaQuery.of(context).padding.bottom + 110,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: -30, end: 0),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, value),
                  child: child,
                );
              },
              child: _buildHeader(),
            ),
            const SizedBox(height: 10),
            _animatedSection(
              delay: 0,
              child: _buildPetHealthCard(),
            ),
            const SizedBox(height: 18),
            _animatedSection(
              delay: 40,
              child: _buildHomeShortcutGrid(),
            ),
            const SizedBox(height: 24),
            _animatedSection(
              delay: 80,
              child: _buildUpcomingReminders(),
            ),
            const SizedBox(height: 24),
            _animatedSection(
              delay: 120,
              child: _buildPremiumUpgradeCard(),
            ),
            const SizedBox(height: 22),
            _animatedSection(
              delay: 0,
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SosRoutingScreen(),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.red.shade400, Colors.orange.shade400],
                    ),
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.25),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.28),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.emergency_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Emergency Alert',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Report an animal in distress immediately',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            _animatedSection(
              delay: 80,
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DonationScreen(),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.teal.shade400, Colors.green.shade400],
                    ),
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.teal.withOpacity(0.25),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.28),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.volunteer_activism_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Save a Life Today 🐾',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Your support feeds and heals stray animals',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: LinearProgressIndicator(
                          value: 0.65,
                          minHeight: 8,
                          backgroundColor: Colors.white.withOpacity(0.25),
                          valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Goal: Feed 50 animals this week',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 28),

            _animatedSection(
              delay: 200,
              child: const Text(
                'Featured Animals',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3748),
                ),
              ),
            ),

            const SizedBox(height: 16),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.68,
              children: List.generate(
                featuredAnimals.length,
                (index) => _buildAnimalCard(
                  featuredAnimals[index],
                  _featuredAnimalDistances[index],
                  260 + (index * 60),
                ),
              ),
            ),

            const SizedBox(height: 28),

            _animatedSection(
              delay: 500,
              child: const Text(
                'Nearby Rescue Cases',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3748),
                ),
              ),
            ),

            const SizedBox(height: 14),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.19,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  SizedBox(width: 2),
                  _RescueCaseCard(
                    title: 'Injured Puppy',
                    subtitle: 'Near Market Street',
                    icon: Icons.pets,
                  ),
                  SizedBox(width: 12),
                  _RescueCaseCard(
                    title: 'Cat in Drain',
                    subtitle: 'Near Temple Road',
                    icon: Icons.warning_amber_rounded,
                  ),
                  SizedBox(width: 12),
                  _RescueCaseCard(
                    title: 'Bird Rescue',
                    subtitle: 'Near Park Lane',
                    icon: Icons.flutter_dash,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildHomePageContent(List<AnimalProfile> featuredAnimals) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 900));
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(
          20,
          20,
          20,
          MediaQuery.of(context).padding.bottom + 110,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: -30, end: 0),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, value),
                  child: child,
                );
              },
              child: _buildHeader(),
            ),
            const SizedBox(height: 10),
            _animatedSection(
              delay: 0,
              child: _buildPetHealthCard(),
            ),
            const SizedBox(height: 18),
            _animatedSection(
              delay: 40,
              child: _buildHomeShortcutGrid(),
            ),
            const SizedBox(height: 24),
            _animatedSection(
              delay: 80,
              child: _buildUpcomingReminders(),
            ),
            const SizedBox(height: 24),
            _animatedSection(
              delay: 120,
              child: _buildPremiumUpgradeCard(),
            ),
            const SizedBox(height: 28),
            _animatedSection(
              delay: 200,
              child: Text(
                'Featured Animals',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.68,
              children: List.generate(
                featuredAnimals.length,
                (index) => _buildAnimalCard(
                  featuredAnimals[index],
                  _featuredAnimalDistances[index],
                  260 + (index * 60),
                ),
              ),
            ),
            const SizedBox(height: 28),
            _animatedSection(
              delay: 500,
              child: Text(
                'Nearby Rescue Cases',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.19,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  SizedBox(width: 2),
                  _RescueCaseCard(
                    title: 'Injured Puppy',
                    subtitle: 'Near Market Street',
                    icon: Icons.pets,
                  ),
                  SizedBox(width: 12),
                  _RescueCaseCard(
                    title: 'Cat in Drain',
                    subtitle: 'Near Temple Road',
                    icon: Icons.warning_amber_rounded,
                  ),
                  SizedBox(width: 12),
                  _RescueCaseCard(
                    title: 'Bird Rescue',
                    subtitle: 'Near Park Lane',
                    icon: Icons.flutter_dash,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _animatedSection({required int delay, required Widget child}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 30, end: 0),
      duration: Duration(milliseconds: 500 + delay),
      curve: Curves.easeOut,
      builder: (context, value, widgetChild) {
        return Transform.translate(
          offset: Offset(0, value),
          child: Opacity(
            opacity: 1 - (value / 30).clamp(0, 1),
            child: widgetChild,
          ),
        );
      },
      child: child,
    );
  }

  bool get _isDarkHome => Theme.of(context).brightness == Brightness.dark;

  Color _homeCardColor({double lightOpacity = 0.94}) {
    return _isDarkHome
        ? const Color(0xFF17231F).withOpacity(0.94)
        : Colors.white.withOpacity(lightOpacity);
  }

  Color _softShadowColor() {
    return _isDarkHome
        ? Colors.black.withOpacity(0.28)
        : Colors.teal.withOpacity(0.08);
  }

  Color _mutedTextColor() {
    return Theme.of(context).colorScheme.onSurface.withOpacity(0.68);
  }

  Color _softTint(MaterialColor color) {
    return _isDarkHome ? color.shade900.withOpacity(0.32) : color.shade50;
  }

  Widget _buildPetHealthCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _homeCardColor(),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: _softShadowColor(),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Image.network(
                  'https://images.unsplash.com/photo-1543466835-00a7907e9de1?w=180&h=180&fit=crop',
                  width: 86,
                  height: 86,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 18),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Luna',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w900)),
                    SizedBox(height: 4),
                    Text('Golden Retriever • 2 yrs',
                        style: TextStyle(fontSize: 15)),
                  ],
                ),
              ),
              CircleAvatar(
                backgroundColor: _isDarkHome
                    ? Colors.white.withOpacity(0.08)
                    : Colors.grey.shade100,
                child: Icon(
                  Icons.swap_horiz_rounded,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _isDarkHome
                  ? Colors.red.shade900.withOpacity(0.24)
                  : Colors.red.shade50,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _isDarkHome
                    ? Colors.red.shade300.withOpacity(0.24)
                    : Colors.red.shade100,
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.medical_services_rounded,
                    color: Colors.red.shade700),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Vaccination due in 3 days',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w800)),
                      SizedBox(height: 4),
                      Text('Annual Rabies & DHPP Booster'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeShortcutGrid() {
    final shortcuts = <_HomeShortcut>[
      _HomeShortcut(
        'Book Vet',
        Icons.calendar_month_rounded,
        Colors.green,
        () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BookingCheckoutScreen(
                serviceName: 'Vet Visit',
                price: 'Rs 699',
              ),
            ),
          );
        },
      ),
      _HomeShortcut(
        'Grooming',
        Icons.content_cut_rounded,
        Colors.orange,
        () => _changeTab(3),
      ),
      _HomeShortcut(
        'Walking',
        Icons.pets_rounded,
        Colors.green,
        () => _changeTab(3),
      ),
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.18,
      children: shortcuts.map((item) {
        return GestureDetector(
          onTap: item.onTap,
          child: Container(
            decoration: BoxDecoration(
              color: _homeCardColor(lightOpacity: 0.9),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: _softShadowColor(),
                  blurRadius: 14,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: item.color.shade100,
                  child: Icon(item.icon, color: item.color.shade700),
                ),
                const SizedBox(height: 14),
                Text(
                  item.label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildUpcomingReminders() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Upcoming Reminders',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            Text('SEE ALL',
                style: TextStyle(
                    color: Colors.green.shade800, fontWeight: FontWeight.w800)),
          ],
        ),
        const SizedBox(height: 14),
        _reminderTile('Vaccination', 'Aug 15 • 10:30 AM',
            Icons.vaccines_rounded, Colors.green),
        const SizedBox(height: 12),
        _reminderTile('Grooming', 'Aug 22 • 02:00 PM',
            Icons.content_cut_rounded, Colors.orange),
      ],
    );
  }

  Widget _reminderTile(
      String title, String time, IconData icon, MaterialColor color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _homeCardColor(),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _softTint(color),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color.shade700),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(time, style: TextStyle(color: _mutedTextColor())),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
            color: _mutedTextColor(),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumUpgradeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.amber.shade700, Colors.orange.shade800],
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(999),
            ),
            child: const Text('PLUS+ FEATURE',
                style: TextStyle(color: Colors.white, letterSpacing: 2)),
          ),
          const SizedBox(height: 22),
          const Text('Upgrade to Premium',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w900)),
          const SizedBox(height: 14),
          const Text('Get 24/7 unlimited vet chat and health insurance perks.',
              style: TextStyle(color: Colors.white, fontSize: 16, height: 1.4)),
          const SizedBox(height: 22),
          FilledButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PremiumPlansScreen()),
              );
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.brown.shade700,
            ),
            child: const Text('Get Started'),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimalCard(
      AnimalProfile animal,
      String distance,
      int delay,
      ) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.92, end: 1.0),
      duration: Duration(milliseconds: delay),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.scale(scale: value, child: child);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: _homeCardColor(lightOpacity: 1),
          boxShadow: [
            BoxShadow(
              color: _softShadowColor(),
              blurRadius: 14,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: () {
            HapticFeedback.lightImpact();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AnimalDetailScreen(animal: animal),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(22),
                  ),
                  child: Image.network(
                    animal.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.grey.shade200,
                      child: Icon(
                        Icons.pets,
                        size: 50,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      animal.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      animal.breed,
                      style: TextStyle(
                        fontSize: 12,
                        color: _mutedTextColor(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          size: 14,
                          color: Colors.teal.shade500,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          distance,
                          style: TextStyle(
                            fontSize: 11,
                            color: _mutedTextColor(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.teal.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'View Details',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.teal.shade700,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RescueCaseCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _RescueCaseCard({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: 190,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF17231F).withOpacity(0.94)
            : Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.26)
                : Colors.grey.withOpacity(0.14),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.teal.withOpacity(0.12),
            child: Icon(icon, color: Colors.teal.shade700),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: colors.onSurface,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: colors.onSurface.withOpacity(0.65),
            ),
          ),
          const Spacer(),
          Text(
            'Track case',
            style: TextStyle(
              color: Colors.teal.shade700,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeShortcut {
  final String label;
  final IconData icon;
  final MaterialColor color;
  final VoidCallback onTap;

  const _HomeShortcut(this.label, this.icon, this.color, this.onTap);
}
