import 'package:flutter/material.dart';
import '../models/animal_profile.dart';
import '../utils/app_colors.dart';
import 'adoption_request_screen.dart';

class AnimalDetailScreen extends StatelessWidget {
  final AnimalProfile animal;

  const AnimalDetailScreen({super.key, required this.animal});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = Theme.of(context).colorScheme;
    final surface = colors.surface;
    final cardColor = isDark ? const Color(0xFF17231F) : Colors.white;
    final mutedText = colors.onSurface.withOpacity(0.68);

    return Scaffold(
      backgroundColor: surface,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 360,
            floating: false,
            pinned: true,
            backgroundColor: surface,
            elevation: 0,
            iconTheme: IconThemeData(color: colors.onSurface),
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite_border_rounded),
                onPressed: () {},
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'animal_image_${animal.id}',
                child: Image.network(
                  animal.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.grey.shade200,
                    child: Icon(
                      Icons.pets,
                      size: 80,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              transform: Matrix4.translationValues(0, -20, 0),
              decoration: BoxDecoration(
                color: surface,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                animal.name,
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: colors.onSurface,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 16,
                                    color: mutedText,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      animal.shelterName,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: mutedText,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: animal.gender == 'Male'
                                ? (isDark
                                    ? Colors.blue.shade900.withOpacity(0.3)
                                    : Colors.blue.shade50)
                                : (isDark
                                    ? Colors.pink.shade900.withOpacity(0.3)
                                    : Colors.pink.shade50),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            animal.gender == 'Male'
                                ? Icons.male_rounded
                                : Icons.female_rounded,
                            size: 28,
                            color: animal.gender == 'Male'
                                ? Colors.blue.shade400
                                : Colors.pink.shade400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        _infoCard(context, 'Age', animal.age, Colors.orange),
                        _infoCard(context, 'Breed', animal.breed, Colors.purple),
                        _infoCard(context, 'Type', animal.type, Colors.green),
                        _infoCard(
                          context,
                          'Vaccination',
                          animal.vaccinated ? 'Up to date' : 'Pending',
                          Colors.teal,
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    _detailPanel(
                      context,
                      title: 'About',
                      child: Text(
                        animal.description,
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.6,
                          color: mutedText,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    _detailPanel(
                      context,
                      title: 'Nature',
                      child: Text(
                        animal.nature,
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.5,
                          color: mutedText,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    _detailPanel(
                      context,
                      title: 'Vaccination History',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: animal.vaccinationHistory.map((item) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.check_circle_rounded,
                                  size: 18,
                                  color: animal.vaccinated
                                      ? Colors.green.shade500
                                      : Colors.orange.shade500,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: mutedText,
                                      height: 1.35,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 18),
                    _detailPanel(
                      context,
                      title: 'Special Care Needed',
                      child: Text(
                        animal.specialCare,
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.5,
                          color: mutedText,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    _detailPanel(
                      context,
                      title: 'Medical Conditions',
                      child: Text(
                        animal.medicalConditions,
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.5,
                          color: mutedText,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    _detailPanel(
                      context,
                      title: 'Personality',
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: animal.personalityTags.map((tag) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? Colors.pink.shade900.withOpacity(0.25)
                                  : Colors.pink.shade50,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.pink.shade100),
                            ),
                            child: Text(
                              tag,
                              style: TextStyle(
                                color: Colors.pink.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, -5),
              blurRadius: 10,
            ),
          ],
        ),
        child: SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AdoptionRequestScreen(animal: animal),
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 4,
            ),
            child: const Text(
              'ADOPT ME',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _detailPanel(
    BuildContext context, {
    required String title,
    required Widget child,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF17231F) : Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: colors.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _infoCard(
    BuildContext context,
    String title,
    String value,
    MaterialColor color,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? color.shade900.withOpacity(0.28) : color.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: color.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value.length > 12 ? '${value.substring(0, 10)}..' : value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isDark ? color.shade100 : color.shade900,
            ),
          ),
        ],
      ),
    );
  }
}
