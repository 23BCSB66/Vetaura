import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/app_colors.dart';
import '../widgets/donation_amount_card.dart';
import '../widgets/impact_card.dart';
import '../widgets/cause_chip.dart';

class DonationScreen extends StatefulWidget {
  const DonationScreen({super.key});

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen>
    with SingleTickerProviderStateMixin {

  String selectedAmount = '₹250';
  String selectedCause = 'Food';
  bool isMonthly = false;

  final TextEditingController customAmountController = TextEditingController();

  double weeklyGoalProgress = 0.65;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    customAmountController.dispose();
    super.dispose();
  }

  String getImpactMessage() {
    if (selectedAmount == '₹100') {
      return "Feeds a stray for a day";
    } else if (selectedAmount == '₹250') {
      return "Helps with vaccination";
    } else if (selectedAmount == '₹500') {
      return "Supports shelter care";
    } else if (customAmountController.text.isNotEmpty) {
      return "Your donation helps rescue animals";
    }
    return "";
  }

  void donateAction() {
    HapticFeedback.mediumImpact();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Thank you for your generous contribution."),
      ),
    );
  }

  Widget sectionCard({required Widget child}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF17231F) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.white12 : Colors.grey.shade200,
        ),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              blurRadius: 10,
              color: Colors.grey.withOpacity(0.05),
              offset: const Offset(0, 4),
            )
        ],
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,

        body: Stack(
            children: [
              /// Main Page
              CustomScrollView(
                slivers: [

                  /// HERO APP BAR
                  SliverAppBar(
                    expandedHeight: 260,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    flexibleSpace: FlexibleSpaceBar(
                      title: const Text(
                        "",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      background: Stack(
                        fit: StackFit.expand,
                        children: [

                          Image.asset(
                            "assets/images/hero_pet.jpg",
                            fit: BoxFit.cover,
                          ),

                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.55),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),

                          const Positioned(
                            bottom: 24,
                            left: 20,
                            child: Text(
                              "Support\nAnimal Rescue",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        children: [

                          /// DONATION AMOUNT
                          sectionCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                const Text(
                                  "Select Donation Amount",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),

                                const SizedBox(height: 16),

                                Row(
                                  children: [
                                    Expanded(
                                      child: AmountCard(
                                        amount: "₹100",
                                        isSelected: selectedAmount == "₹100",
                                        onTap: () {
                                          setState(() {
                                            selectedAmount = "₹100";
                                            customAmountController.clear();
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: AmountCard(
                                        amount: "₹250",
                                        isSelected: selectedAmount == "₹250",
                                        onTap: () {
                                          setState(() {
                                            selectedAmount = "₹250";
                                            customAmountController.clear();
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: AmountCard(
                                        amount: "₹500",
                                        isSelected: selectedAmount == "₹500",
                                        onTap: () {
                                          setState(() {
                                            selectedAmount = "₹500";
                                            customAmountController.clear();
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 16),

                                TextField(
                                  controller: customAmountController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: "Custom amount",
                                    prefixText: "₹ ",
                                    filled: true,
                                    fillColor: isDark ? const Color(0xFF1F2D28) : Colors.grey.shade100,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedAmount = value;
                                    });
                                  },
                                ),

                                const SizedBox(height: 12),

                                  Text(
                                    getImpactMessage(),
                                    style: TextStyle(
                                      color: isDark ? Colors.white70 : Colors.black54,
                                    ),
                                  ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),

                          /// IMPACT CARDS
                          sectionCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [

                                Text(
                                  "Your Impact",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),

                                SizedBox(height: 14),

                                Row(
                                  children: const [
                                    Expanded(
                                      child: ImpactCard(
                                        icon: Icons.restaurant,
                                        title: "Meals",
                                        subtitle: "Feeds a stray",
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: ImpactCard(
                                        icon: Icons.medical_services,
                                        title: "Treatment",
                                        subtitle: "Basic care",
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: ImpactCard(
                                        icon: Icons.home,
                                        title: "Shelter",
                                        subtitle: "Safe place",
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),

                          /// CAUSE SELECTION
                          sectionCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                const Text(
                                  "Select Cause",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),

                                const SizedBox(height: 12),

                                Wrap(
                                  spacing: 12,
                                  children: [
                                    CauseChip(
                                      label: "Food",
                                      isSelected: selectedCause == "Food",
                                      onTap: () {
                                        setState(() {
                                          selectedCause = "Food";
                                        });
                                      },
                                    ),
                                    CauseChip(
                                      label: "Treatment",
                                      isSelected:
                                      selectedCause == "Treatment",
                                      onTap: () {
                                        setState(() {
                                          selectedCause = "Treatment";
                                        });
                                      },
                                    ),
                                    CauseChip(
                                      label: "Shelter",
                                      isSelected: selectedCause == "Shelter",
                                      onTap: () {
                                        setState(() {
                                          selectedCause = "Shelter";
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),

                          /// GOAL PROGRESS
                          sectionCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                const Text(
                                  "Help us feed 50 animals this week",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),

                                const SizedBox(height: 10),

                                TweenAnimationBuilder(
                                  tween:
                                  Tween(begin: 0.0, end: weeklyGoalProgress),
                                  duration: const Duration(seconds: 1),
                                  builder: (_, value, __) =>
                                      LinearProgressIndicator(
                                        value: value,
                                        minHeight: 8,
                                        borderRadius:
                                        BorderRadius.circular(20),
                                      ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),

                          /// MONTHLY DONATION
                          Container(
                            decoration: BoxDecoration(
                              color: isDark ? const Color(0xFF1F2D28) : Colors.green.shade50,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: SwitchListTile(
                              value: isMonthly,
                              title: const Text("Make this a monthly donation"),
                              activeColor: AppColors.primary,
                              onChanged: (value) {
                                setState(() {
                                  isMonthly = value;
                                });
                              },
                            ),
                          ),

                          const SizedBox(height: 24),

                          /// DONATE BUTTON
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: donateAction,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: const Text(
                                "Proceed to Donate",
                                style: TextStyle(
                                  fontSize: 16, 
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),

                          /// RECENTLY HELPED
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Recently Helped 🐾",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),

                          const SizedBox(height: 12),

                          SizedBox(
                            height: 110,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: const [

                                SizedBox(width: 12),

                                _AnimalCard("Bruno", "Medical treatment"),

                                SizedBox(width: 12),

                                _AnimalCard("Luna", "Rescued"),

                                SizedBox(width: 12),

                                _AnimalCard("Max", "Adopted"),
                              ],
                            ),
                          ),

                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ]
        )
    );
  }
}




class _AnimalCard extends StatelessWidget {

  final String name;
  final String subtitle;

  const _AnimalCard(this.name, this.subtitle);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF17231F) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: isDark ? Colors.black26 : Colors.black12,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          const Icon(Icons.pets, size: 32),

          const SizedBox(height: 8),

          Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),

          const SizedBox(height: 4),

          Text(subtitle,
              style: TextStyle(fontSize: 12, color: isDark ? Colors.white70 : Colors.black54)),
        ],
      ),
    );
  }
}