import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'booking_checkout_screen.dart';

class VaccinationScreen extends StatefulWidget {
  const VaccinationScreen({super.key});

  @override
  State<VaccinationScreen> createState() => _VaccinationScreenState();
}

class _VaccinationScreenState extends State<VaccinationScreen> {
  int _selectedDate = 19;
  String _selectedTime = '10:30 AM';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Vaccinations',
          style: TextStyle(
            color: Colors.green.shade800,
            fontWeight: FontWeight.w900,
            fontSize: 22,
          ),
        ),
        backgroundColor: colorScheme.surface,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.onSurface),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: const AssetImage('assets/images/hero_pet.jpg'),
              backgroundColor: Colors.grey.shade200,
            ),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        children: [
          // Timeline Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Vaccination Timeline',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: colorScheme.onSurface,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "OLIVER'S HEALTH",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Timeline Items
          _buildTimelineItem(
            isDark: isDark,
            icon: Icons.warning_amber_rounded,
            iconColor: Colors.red.shade700,
            iconBgColor: Colors.red.shade100,
            title: 'Rabies Booster',
            badgeText: 'OVERDUE',
            badgeColor: Colors.red.shade100,
            badgeTextColor: Colors.red.shade700,
            subtitle: 'Due 3 days ago • Aug 12, 2024',
            actionText: 'Book now >',
            lineColor: Colors.grey.shade300,
            borderColor: Colors.red.shade700,
          ),
          _buildTimelineItem(
            isDark: isDark,
            icon: Icons.event_available_rounded,
            iconColor: Colors.white,
            iconBgColor: Colors.green.shade600,
            title: 'Bordetella',
            badgeText: 'SCHEDULED',
            badgeColor: Colors.green.shade700,
            badgeTextColor: Colors.white,
            subtitle: 'Thursday, Aug 22 at 10:30 AM\nAt City Paws Veterinary',
            subtitleColor: Colors.green.shade700,
            lineColor: Colors.grey.shade300,
            borderColor: Colors.green.shade600,
          ),
          _buildTimelineItem(
            isDark: isDark,
            icon: Icons.calendar_today_rounded,
            iconColor: Colors.orange.shade800,
            iconBgColor: Colors.orange.shade200,
            title: 'DHPP Vaccine',
            badgeText: 'DUE SOON',
            badgeColor: Colors.orange.shade100,
            badgeTextColor: Colors.orange.shade800,
            subtitle: 'Due in 4 weeks • Sep 15, 2024',
            lineColor: Colors.transparent,
            borderColor: Colors.orange.shade400,
          ),

          const SizedBox(height: 24),

          // Banner
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green.shade800, Colors.green.shade600],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Keep Oliver Protected',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.vaccines, color: Colors.white.withOpacity(0.3), size: 36),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Quickly schedule overdue or\nupcoming vaccinations with your\nfavorite vet.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const BookingCheckoutScreen(
                            serviceName: 'Vaccination Appointment',
                            price: 'Rs 499',
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.medical_services_outlined, color: Colors.black87),
                    label: const Text(
                      'Schedule Vaccination',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Quick Booking
          Text(
            'Quick Booking',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),

          // Clinic Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF17231F) : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF22322D) : Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.storefront_rounded, color: Colors.green.shade800),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'City Paws\nVeterinary',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: colorScheme.onSurface,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '0.8 miles away • Highly\nRated',
                        style: TextStyle(
                          color: isDark ? Colors.white54 : Colors.black54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey.shade800 : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Change',
                    style: TextStyle(
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Dates
          SizedBox(
            height: 70,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildDateCard('MON', 19, isDark),
                _buildDateCard('TUE', 20, isDark),
                _buildDateCard('WED', 21, isDark),
                _buildDateCard('THU', 22, isDark),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Times
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildTimeCard('09:00 AM', isDark),
                _buildTimeCard('10:30 AM', isDark),
                _buildTimeCard('11:15 AM', isDark),
                _buildTimeCard('02:00 PM', isDark),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Vet's Corner
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1A1A1A) : const Color(0xFFFDFBF7),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isDark ? Colors.white12 : Colors.grey.shade200,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.lightbulb, color: Colors.orange.shade800, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      "VET'S CORNER",
                      style: TextStyle(
                        color: Colors.orange.shade800,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: isDark ? Colors.white70 : Colors.black87,
                      fontSize: 14,
                      height: 1.5,
                    ),
                    children: const [
                      TextSpan(text: 'Most vaccines take about '),
                      TextSpan(
                        text: '10-14 days to',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: '\nbecome '),
                      TextSpan(
                        text: 'fully',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: ' effective. Plan your boarding or\ndog park trips accordingly!'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildDateCard(String day, int date, bool isDark) {
    final isSelected = _selectedDate == date;
    return GestureDetector(
      onTap: () => setState(() => _selectedDate = date),
      child: Container(
        width: 65,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green.shade800 : (isDark ? const Color(0xFF17231F) : Colors.white),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? Colors.green.shade800 : (isDark ? Colors.white12 : Colors.grey.shade200),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              day,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white70 : (isDark ? Colors.white54 : Colors.black54),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              date.toString(),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : (isDark ? Colors.white : Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeCard(String time, bool isDark) {
    final isSelected = _selectedTime == time;
    return GestureDetector(
      onTap: () => setState(() => _selectedTime = time),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.only(right: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? (isDark ? Colors.grey.shade700 : Colors.grey.shade300) : (isDark ? const Color(0xFF17231F) : Colors.white),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDark ? Colors.white12 : Colors.grey.shade300,
          ),
        ),
        child: Text(
          time,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineItem({
    required bool isDark,
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String badgeText,
    required Color badgeColor,
    required Color badgeTextColor,
    required String subtitle,
    Color? subtitleColor,
    String? actionText,
    required Color lineColor,
    required Color borderColor,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline indicator
          SizedBox(
            width: 40,
            child: Column(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: iconColor, size: 20),
                ),
                Expanded(
                  child: Container(
                    width: 2,
                    color: lineColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Content Card
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF17231F) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border(
                  left: BorderSide(color: borderColor, width: 4),
                ),
                boxShadow: [
                  BoxShadow(
                    color: isDark ? Colors.black12 : Colors.grey.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: badgeColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          badgeText,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: badgeTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: subtitleColor ?? (isDark ? Colors.white60 : Colors.black54),
                      height: 1.4,
                    ),
                  ),
                  if (actionText != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      actionText,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
