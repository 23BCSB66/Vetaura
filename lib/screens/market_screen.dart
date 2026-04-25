import 'package:flutter/material.dart';
import 'booking_checkout_screen.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  bool isTopRated = true;

  Color _surfaceColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF17231F)
        : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 42),
                    Expanded(
                      child: Text(
                        'Market',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: onSurface,
                        ),
                      ),
                    ),
                    const Icon(Icons.shopping_cart_outlined),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  "Top rated pet products for your companion.",
                  style: TextStyle(fontSize: 16, height: 1.45),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF22322D) : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(
                    children: [
                      _toggle('Top Rated', isTopRated, () => setState(() => isTopRated = true)),
                      _toggle('All Products', !isTopRated, () => setState(() => isTopRated = false)),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                _sectionHeader('Featured Foods', 'SEE ALL'),
                const SizedBox(height: 14),
                _productCard(
                  title: 'Premium Dog Food',
                  subtitle: 'High-protein diet for active dogs by Royal Canin.',
                  price: 'Rs 1,299',
                  rating: 4.8,
                  photoUrl: 'https://picsum.photos/seed/dogfood/200/200',
                  button: 'Buy Now',
                ),
                const SizedBox(height: 16),
                _productCard(
                  title: 'Organic Cat Food',
                  subtitle: 'Grain-free organic salmon recipe by Purina.',
                  price: 'Rs 999',
                  rating: 4.5,
                  photoUrl: 'https://picsum.photos/seed/catfood/200/200',
                  button: 'Buy Now',
                ),
                const SizedBox(height: 30),
                const Text(
                  'Toys & Accessories',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 14),
                _compactProductCard('Chew Toy Bone', 'Durable rubber chew toy', 'Rs 299', 4.2, 'https://picsum.photos/seed/toybone/200/200'),
                _compactProductCard('Catnip Mouse', 'Interactive mouse toy', 'Rs 149', 3.8, 'https://picsum.photos/seed/catnip/200/200'),
                _compactProductCard('Feather Wand', 'Cat wand toy with bell', 'Rs 199', 4.7, 'https://picsum.photos/seed/wand/200/200'),
                const SizedBox(height: 30),
                const Text(
                  'Cages & Carriers',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 14),
                _productCard(
                  title: 'Large Dog Crate',
                  subtitle: 'Sturdy metal cage for large dog breeds.',
                  price: 'Rs 3,499',
                  rating: 4.6,
                  photoUrl: 'https://picsum.photos/seed/dogcrate/200/200',
                  button: 'Buy Now',
                ),
                const SizedBox(height: 16),
                _productCard(
                  title: 'Cat Carrier Backpack',
                  subtitle: 'Breathable travel bag for cats and small pets.',
                  price: 'Rs 1,899',
                  rating: 4.3,
                  photoUrl: 'https://picsum.photos/seed/catcarrier/200/200',
                  button: 'Buy Now',
                ),
                const SizedBox(height: 16),
                _productCard(
                  title: 'Basic Pet Cage',
                  subtitle: 'Compact cage for small animals.',
                  price: 'Rs 899',
                  rating: 2.5,
                  photoUrl: 'https://picsum.photos/seed/smallcage/200/200',
                  button: 'Buy Now',
                ),
                SizedBox(height: MediaQuery.of(context).padding.bottom + 120),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _toggle(String label, bool selected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.symmetric(vertical: 13),
          decoration: BoxDecoration(
            color: selected ? _surfaceColor(context) : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }

  Widget _sectionHeader(String title, String action) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
        Text(action, style: TextStyle(color: Colors.green.shade800, fontWeight: FontWeight.w800)),
      ],
    );
  }

  Widget _productCard({
    required String title,
    required String subtitle,
    required String price,
    required double rating,
    required String photoUrl,
    required String button,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    Color ratingColor;
    if (rating >= 4.0) {
      ratingColor = Colors.green;
    } else if (rating >= 3.0) {
      ratingColor = Colors.orange;
    } else {
      ratingColor = Colors.red;
    }

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _surfaceColor(context),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.04),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  border: isDark ? Border.all(color: Colors.white.withOpacity(0.1), width: 1) : null,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(isDark ? 21 : 22),
                  child: Image.network(
                    photoUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 80,
                      height: 80,
                      color: isDark ? Colors.white10 : Colors.grey.shade300,
                      child: Icon(Icons.image, color: isDark ? Colors.white38 : Colors.grey),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Container(
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
                      rating.toStringAsFixed(1),
                      style: TextStyle(
                        color: ratingColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
          ),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(subtitle, style: const TextStyle(height: 1.45)),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Text(price, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.green.shade800)),
              const Spacer(),
              FilledButton(
                onPressed: () => _buy(title, price),
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.green.shade800,
                  foregroundColor: Colors.white,
                ),
                child: Text(button),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _compactProductCard(String title, String subtitle, String price, double rating, String photoUrl) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    Color ratingColor;
    if (rating >= 4.0) {
      ratingColor = Colors.green;
    } else if (rating >= 3.0) {
      ratingColor = Colors.orange;
    } else {
      ratingColor = Colors.red;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _surfaceColor(context),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.1 : 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _buy(title, price),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: isDark ? Border.all(color: Colors.white.withOpacity(0.1), width: 1) : null,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(isDark ? 11 : 12),
                child: Image.network(
                  photoUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 60,
                    height: 60,
                    color: isDark ? Colors.white10 : Colors.grey.shade300,
                    child: Icon(Icons.image, color: isDark ? Colors.white38 : Colors.grey),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 3),
                  Text(subtitle, style: const TextStyle(fontSize: 12, height: 1.25)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, color: Colors.amber, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        rating.toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: 12,
                          color: ratingColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text(price, style: TextStyle(fontWeight: FontWeight.w900, color: Colors.green.shade800)),
          ],
        ),
      ),
    );
  }

  void _buy(String title, String price) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BookingCheckoutScreen(serviceName: title, price: price),
      ),
    );
  }
}
