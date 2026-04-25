import 'package:flutter/material.dart';
import '../models/animal_profile.dart';
import 'animal_detail_screen.dart';

class AdoptionFeedScreen extends StatefulWidget {
  const AdoptionFeedScreen({super.key});

  @override
  State<AdoptionFeedScreen> createState() => _AdoptionFeedScreenState();
}

class _AdoptionFeedScreenState extends State<AdoptionFeedScreen> {
  final Set<String> _selectedFilters = {};

  @override
  Widget build(BuildContext context) {
    final allAnimals = MockAnimalDatabase.animals;
    final screenWidth = MediaQuery.of(context).size.width;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = Theme.of(context).colorScheme;
    final cardColor = isDark ? const Color(0xFF17231F) : Colors.white;
    final mutedText = colors.onSurface.withOpacity(0.66);

    final filteredAnimals = allAnimals.where(_matchesFilters).toList();
    final crossAxisCount = screenWidth > 900 ? 4 : screenWidth > 600 ? 3 : 2;

    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(58, 20, 20, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Find Your Best Friend',
                      style: TextStyle(
                        fontSize: screenWidth < 360 ? 21 : 24,
                        fontWeight: FontWeight.w900,
                        color: colors.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: _showFilterSheet,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.pink.shade900.withOpacity(0.24)
                            : Colors.pink.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Icon(
                            Icons.tune_rounded,
                            color: Colors.pink.shade400,
                          ),
                          if (_selectedFilters.isNotEmpty)
                            Positioned(
                              top: -6,
                              right: -6,
                              child: CircleAvatar(
                                radius: 9,
                                backgroundColor: colors.primary,
                                child: Text(
                                  '${_selectedFilters.length}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_selectedFilters.isNotEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _selectedFilters.map((filter) {
                    return Chip(
                      label: Text(filter),
                      onDeleted: () {
                        setState(() => _selectedFilters.remove(filter));
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 110),
            sliver: filteredAnimals.isEmpty
                ? SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.search_off_rounded,
                              size: 48, color: colors.primary),
                          const SizedBox(height: 12),
                          Text(
                            'No pets match those filters yet',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: colors.onSurface,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Try removing one or two filters to see more animals.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: mutedText),
                          ),
                        ],
                      ),
                    ),
                  )
                : SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.72,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final animal = filteredAnimals[index];

                        return InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AnimalDetailScreen(animal: animal),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: cardColor,
                              boxShadow: [
                                BoxShadow(
                                  color: isDark
                                      ? Colors.black.withOpacity(0.26)
                                      : Colors.grey.withOpacity(0.15),
                                  blurRadius: 12,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Image.network(
                                        animal.imageUrl,
                                        fit: BoxFit.cover,
                                        alignment: Alignment.center,
                                        loadingBuilder:
                                            (context, child, progress) {
                                          if (progress == null) return child;
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                        errorBuilder: (_, __, ___) {
                                          return Container(
                                            color: isDark ? Colors.white10 : Colors.grey.shade200,
                                            child: Icon(
                                              Icons.pets,
                                              size: 50,
                                              color: isDark ? Colors.white24 : Colors.grey.shade400,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              animal.name,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: colors.onSurface,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          Icon(
                                            animal.gender == 'Male'
                                                ? Icons.male_rounded
                                                : Icons.female_rounded,
                                            size: 16,
                                            color: animal.gender == 'Male'
                                                ? Colors.blue.shade400
                                                : Colors.pink.shade400,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        animal.breed,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: mutedText,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 8),
                                      Wrap(
                                        spacing: 6,
                                        runSpacing: 6,
                                        children: [
                                          _miniTag(animal.age, Colors.pink, isDark),
                                          if (animal.vaccinated)
                                            _miniTag('Vaccinated', Colors.green, isDark),
                                          _miniTag(animal.type, Colors.orange, isDark),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: filteredAnimals.length,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  bool _matchesFilters(AnimalProfile animal) {
    if (_selectedFilters.isEmpty) return true;
    if (_selectedFilters.contains('Cats') && animal.type != 'Cat') return false;
    if (_selectedFilters.contains('Dogs') && animal.type != 'Dog') return false;
    if (_selectedFilters.contains('Birds') && animal.type != 'Bird') {
      return false;
    }
    if (_selectedFilters.contains('Smalls') &&
        !{'Hamster', 'Guinea Pig', 'Rabbit'}.contains(animal.type)) {
      return false;
    }
    if (_selectedFilters.contains('<=3m') && animal.ageInMonths > 3) {
      return false;
    }
    if (_selectedFilters.contains('<=6m') && animal.ageInMonths > 6) {
      return false;
    }
    if (_selectedFilters.contains('Vaccinated') && !animal.vaccinated) {
      return false;
    }
    return true;
  }

  Widget _miniTag(String label, MaterialColor color, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isDark ? color.shade900.withOpacity(0.24) : color.shade50,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          color: isDark ? color.shade100 : color.shade700,
        ),
      ),
    );
  }

  Future<void> _showFilterSheet() async {
    final options = [
      'Cats',
      'Dogs',
      'Birds',
      'Smalls',
      '<=3m',
      '<=6m',
      'Vaccinated',
    ];

    await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Filter Pets',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: options.map((option) {
                      final selected = _selectedFilters.contains(option);
                      return FilterChip(
                        label: Text(option),
                        selected: selected,
                        onSelected: (value) {
                          setModalState(() {
                            setState(() {
                              if (value) {
                                _selectedFilters.add(option);
                              } else {
                                _selectedFilters.remove(option);
                              }
                            });
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            setModalState(() {
                              setState(() => _selectedFilters.clear());
                            });
                          },
                          child: const Text('Clear All'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Done'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
