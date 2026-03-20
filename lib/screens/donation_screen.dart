import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/app_colors.dart';
import '../widgets/donation_amount_card.dart';
import '../widgets/impact_card.dart';
import '../widgets/cause_chip.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';

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

  late AnimationController heartController;
  late Animation<double> heartAnimation;
  late ConfettiController leftConfettiController;
  late ConfettiController rightConfettiController;
  late ConfettiController bottomConfettiController;
  late Animation<double> heartScale;
  late Animation<double> heartOpacity;

  @override
  void initState() {
    super.initState();

    heartController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    heartScale = Tween<double>(begin: 0.3, end: 1.8).animate(
      CurvedAnimation(parent: heartController, curve: Curves.easeOutBack),
    );

    heartOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: heartController, curve: Curves.easeOut),
    );
    leftConfettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );
    rightConfettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );

    bottomConfettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    heartController.dispose();
    super.dispose();
    leftConfettiController.dispose();
    rightConfettiController.dispose();
    bottomConfettiController.dispose();
  }

  String getImpactMessage() {
    if (selectedAmount == '₹100') {
      return "Feeds a stray for a day 🐶";
    } else if (selectedAmount == '₹250') {
      return "Helps with vaccination 💉";
    } else if (selectedAmount == '₹500') {
      return "Supports shelter care 🏠";
    } else if (customAmountController.text.isNotEmpty) {
      return "Your donation helps rescue animals 🐾";
    }
    return "";
  }

  void donateAction() {
    HapticFeedback.mediumImpact();

    heartController.forward(from: 0);
    leftConfettiController.play();
    rightConfettiController.play();
    bottomConfettiController.play();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Thank you for helping stray animals 🐾"),
      ),
    );
  }

  Widget sectionCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            blurRadius: 14,
            color: Colors.black12,
          )
        ],
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,

        body: Stack(
            children: [

              /// 1️⃣ Background
              Positioned.fill(
                child: Opacity(
                  opacity: 0.04,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5),
                    itemBuilder: (_, __) => const Icon(Icons.pets, size: 34),
                  ),
                ),
              ),

              /// 2️⃣ Main Page
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
                              "A small help\ncan save a life 🐾",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.w600,
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
                                  "Choose amount",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
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
                                    fillColor: Colors.grey.shade100,
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
                                  style: const TextStyle(
                                    color: Colors.black54,
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
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
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
                                  "Choose cause",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
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
                          CheckboxListTile(
                            value: isMonthly,
                            title: const Text("Make this monthly ❤️"),
                            onChanged: (value) {
                              setState(() {
                                isMonthly = value!;
                              });
                            },
                          ),

                          const SizedBox(height: 24),

                          /// DONATE BUTTON
                          Stack(
                            alignment: Alignment.center,
                            children: [

                              SizedBox(
                                width: double.infinity,
                                height: 56,
                                child: ElevatedButton.icon(
                                  icon: const Icon(Icons.favorite),
                                  label: const Text(
                                    "Donate Now",
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                  ),
                                  onPressed: donateAction,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ),

                              AnimatedBuilder(
                                animation: heartController,
                                builder: (context, child) {
                                  return IgnorePointer(
                                    child: Opacity(
                                      opacity: heartOpacity.value,
                                      child: Transform.scale(
                                        scale: heartScale.value,
                                        child: const Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                          size: 120,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),

                            ],
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
              Align(
                alignment: Alignment.bottomLeft,
                child: ConfettiWidget(
                  confettiController: leftConfettiController,
                  blastDirection: -pi / 4,
                  emissionFrequency: 0.02,
                  numberOfParticles: 70,
                  maxBlastForce: 120,
                  minBlastForce: 80,
                  gravity: 0.08,
                  shouldLoop: false,
                  colors: const [
                    Colors.orange,
                    Colors.yellow,
                    Colors.green,
                    Colors.teal,
                    Colors.blue,
                    Colors.pink,
                    Colors.red,
                    Colors.purple,
                  ],
                  createParticlePath: drawPaw,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ConfettiWidget(
                  confettiController: rightConfettiController,
                  blastDirection: -3 * pi / 4,
                  emissionFrequency: 0.02,
                  numberOfParticles: 70,
                  maxBlastForce: 120,
                  minBlastForce: 80,
                  gravity: 0.08,
                  shouldLoop: false,
                  colors: const [
                    Colors.orange,
                    Colors.yellow,
                    Colors.green,
                    Colors.teal,
                    Colors.blue,
                    Colors.pink,
                    Colors.red,
                    Colors.purple,
                  ],
                  createParticlePath: drawPaw,
                ),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: ConfettiWidget(
                  confettiController: bottomConfettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  maxBlastForce: 20,
                  minBlastForce: 8,
                  emissionFrequency: 0.03,
                  numberOfParticles: 10,
                  gravity: 0.1,
                  colors: const [
                    Colors.teal,
                    Colors.green,
                    Colors.orange,
                  ],
                ),
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
    return Container(
      width: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black12,
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
              style: const TextStyle(fontSize: 12, color: Colors.black54)),
        ],
      ),
    );
  }
}
Path drawPaw(Size size) {
  final path = Path();

  path.addOval(Rect.fromCircle(center: const Offset(0, 0), radius: 4));
  path.addOval(Rect.fromCircle(center: const Offset(-6, -6), radius: 2));
  path.addOval(Rect.fromCircle(center: const Offset(6, -6), radius: 2));
  path.addOval(Rect.fromCircle(center: const Offset(-3, -10), radius: 2));
  path.addOval(Rect.fromCircle(center: const Offset(3, -10), radius: 2));

  return path;
}