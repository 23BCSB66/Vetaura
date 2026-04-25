import 'package:flutter/material.dart';

class CareMapScreen extends StatelessWidget {
  const CareMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mapColor = isDark ? const Color(0xFF1F2F28) : const Color(0xFF9FB489);
    final surfaceColor = isDark ? const Color(0xFF1A2621) : Colors.white;
    
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: mapColor,
            ),
            child: CustomPaint(painter: _MapGridPainter()),
          ),
        ),
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 10),
                child: Row(
                  children: [
                    const SizedBox(width: 48),
                    const Expanded(
                      child: Text(
                        'Explore',
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF0D6B28),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: surfaceColor.withOpacity(0.85),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.tune_rounded, color: isDark ? Colors.white : Colors.black87),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: surfaceColor.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search_rounded, size: 30),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          'Search clinics, groomers',
                          style: TextStyle(fontSize: 17, color: isDark ? Colors.white70 : Colors.black54),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.list_rounded, color: Colors.green.shade800),
                            const SizedBox(width: 6),
                            Text('List', style: TextStyle(color: Colors.green.shade800, fontWeight: FontWeight.w900)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Positioned(
                      top: 96,
                      left: 175,
                      child: _pin(context, Icons.local_hospital_rounded, 'Paw Clinic', Colors.green),
                    ),
                    Positioned(
                      top: 250,
                      right: 50,
                      child: _pin(context, Icons.content_cut_rounded, 'Shiny Paws', Colors.orange),
                    ),
                    Positioned(
                      top: 70,
                      right: 24,
                      child: FloatingActionButton.small(
                        heroTag: 'locate',
                        backgroundColor: surfaceColor,
                        foregroundColor: Colors.green.shade800,
                        onPressed: () {},
                        child: const Icon(Icons.my_location_rounded),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      right: 20,
                      bottom: 190,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Top Rated Nearby',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: isDark ? Colors.white : Colors.black87),
                          ),
                          Text('See All', style: TextStyle(color: Colors.green.shade800, fontWeight: FontWeight.w900)),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 36,
                      height: 150,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        children: [
                          _nearbyCard(context, 'Central Pet Hospital', '0.8 miles away', Icons.local_hospital_rounded, Colors.blue, '4.9'),
                          const SizedBox(width: 14),
                          _nearbyCard(context, 'Paws & Bubbles', '1.2 miles away', Icons.content_cut_rounded, Colors.orange, '4.8'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _pin(BuildContext context, IconData icon, String label, MaterialColor color) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: color.shade700,
            shape: BoxShape.circle,
            border: Border.all(color: isDark ? const Color(0xFF1F2F28) : Colors.white, width: 3),
          ),
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1A2621).withOpacity(0.9) : Colors.white.withOpacity(0.82),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(label, style: TextStyle(color: isDark ? color.shade400 : color.shade800, fontWeight: FontWeight.w900)),
        ),
      ],
    );
  }

  Widget _nearbyCard(BuildContext context, String title, String distance, IconData icon, MaterialColor color, String rating) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final double ratingVal = double.tryParse(rating) ?? 0.0;
    Color ratingColor;
    if (ratingVal >= 4.0) {
      ratingColor = Colors.green;
    } else if (ratingVal >= 3.0) {
      ratingColor = Colors.orange;
    } else {
      ratingColor = Colors.red;
    }

    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A2621) : Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 120,
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? color.withOpacity(0.15) : color.shade100,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(icon, color: isDark ? color.shade400 : color.shade700, size: 54),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.black26 : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            rating,
                            style: TextStyle(
                              color: ratingColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on_rounded, color: Colors.green.shade800, size: 17),
                      Expanded(child: Text(distance)),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.22)
      ..strokeWidth = 1;

    for (double x = 0; x < size.width; x += 38) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += 38) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    final roadPaint = Paint()
      ..color = Colors.white.withOpacity(0.20)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    final path = Path()
      ..moveTo(-30, size.height * 0.2)
      ..quadraticBezierTo(size.width * 0.4, size.height * 0.25,
          size.width * 0.2, size.height * 0.9);
    canvas.drawPath(path, roadPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
