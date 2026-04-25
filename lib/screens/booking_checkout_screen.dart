import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class BookingCheckoutScreen extends StatefulWidget {
  final String serviceName;
  final String price;

  const BookingCheckoutScreen({
    super.key,
    required this.serviceName,
    required this.price,
  });

  @override
  State<BookingCheckoutScreen> createState() => _BookingCheckoutScreenState();
}

class _BookingCheckoutScreenState extends State<BookingCheckoutScreen> {
  bool _isLoading = false;
  String _selectedPaymentMethod = 'super.money';
  String _selectedSchedule = 'Monday, 20 Apr';

  void _processMockPayment() async {
    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 2));
    
    if (!mounted) return;
    setState(() => _isLoading = false);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Column(
          children: [
            Icon(Icons.check_circle_outline, color: Colors.green, size: 60),
            SizedBox(height: 16),
            Text('Booking Confirmed!'),
          ],
        ),
        content: Text(
          'Your appointment for ${widget.serviceName} has been confirmed. Payment via $_selectedPaymentMethod was successful.',
          textAlign: TextAlign.center,
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                Navigator.pop(context); // close dialog
                Navigator.pop(context); // back to premium screen
              },
              child: const Text('Return to Premium'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: colors.surface,
        elevation: 0,
        iconTheme: IconThemeData(color: colors.onSurface),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Summary
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF17231F) : Colors.blue.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF22322D) : Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.receipt_long, color: Colors.blue),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.serviceName,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        const Text('Vetaura Premium Service', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  ),
                  Text(
                    widget.price,
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Colors.blue.shade700),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            Text('Schedule Options', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: colors.onSurface)),
            const SizedBox(height: 8),
            Text('Choose when you want the service', style: TextStyle(fontSize: 14, color: isDark ? Colors.white70 : Colors.black87)),
            const SizedBox(height: 16),
            _buildScheduleOption('Monday, 20 Apr', 'Free standard scheduling.'),
            _buildScheduleOption('Tomorrow, 19 Apr', '₹79.00 Priority scheduling.'),
            _buildScheduleOption('Tomorrow 7 am - 12 pm', '₹99.00 Emergency scheduling. More time slots available.'),
            const SizedBox(height: 16),
            _buildTextField('Address for service', Icons.location_on, maxLines: 2),

            const SizedBox(height: 32),

            Text('Payments', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: colors.onSurface)),
            const SizedBox(height: 16),

            // Payment Options - Flipkart Style
            Container(
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF17231F) : Colors.white,
                border: Border.all(color: isDark ? Colors.white12 : Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  // UPI Header
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(Icons.qr_code_scanner_rounded, color: isDark ? Colors.white70 : Colors.black87),
                        const SizedBox(width: 12),
                        Text('UPI', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
                        const Spacer(),
                        Icon(Icons.keyboard_arrow_up, color: isDark ? Colors.white70 : Colors.black87),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  _buildFlipkartPaymentOption('super.money', Icons.money),
                  const Divider(height: 1),
                  _buildFlipkartPaymentOption('Paytm', Icons.account_balance_wallet_outlined),
                  const Divider(height: 1),
                  _buildFlipkartPaymentOption('Google Pay', Icons.payment_rounded),
                  const Divider(height: 1),
                  _buildFlipkartPaymentOption('Amazon Pay', Icons.shopping_cart_checkout_rounded),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildCollapsedPaymentGroup('Credit / Debit / ATM Card', Icons.credit_card),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, IconData icon, {int maxLines = 1}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: maxLines == 1 ? Icon(icon, color: AppColors.primary) : null,
        filled: true,
        fillColor: isDark ? const Color(0xFF1F2D28) : Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
    );
  }

  Widget _buildScheduleOption(String title, String subtitle) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isSelected = _selectedSchedule == title;
    
    return InkWell(
      onTap: () => setState(() => _selectedSchedule = title),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Radio<String>(
                value: title,
                groupValue: _selectedSchedule,
                onChanged: (val) => setState(() => _selectedSchedule = val!),
                activeColor: Colors.blue.shade700,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark ? Colors.white70 : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlipkartPaymentOption(String title, IconData icon) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isSelected = _selectedPaymentMethod == title;
    
    return Container(
      color: isSelected ? (isDark ? Colors.blue.withOpacity(0.05) : Colors.blue.shade50.withOpacity(0.3)) : Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Radio<String>(
                  value: title,
                  groupValue: _selectedPaymentMethod,
                  onChanged: (val) => setState(() => _selectedPaymentMethod = val!),
                  activeColor: Colors.blue.shade700,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ),
              Icon(icon, color: isDark ? Colors.white54 : Colors.black54, size: 24),
            ],
          ),
          if (isSelected) ...[
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _processMockPayment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    elevation: 0,
                  ),
                  child: _isLoading
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : Text(
                          'Pay ${widget.price}',
                          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCollapsedPaymentGroup(String title, IconData icon) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isSelected = _selectedPaymentMethod == title;

    return GestureDetector(
      onTap: () => setState(() => _selectedPaymentMethod = title),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF17231F) : Colors.white,
          border: Border.all(color: isDark ? Colors.white12 : Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(icon, color: isDark ? Colors.white70 : Colors.black87),
                  const SizedBox(width: 12),
                  Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
                  const Spacer(),
                  Icon(isSelected ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: isDark ? Colors.white70 : Colors.black87),
                ],
              ),
            ),
            if (isSelected) ...[
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _processMockPayment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      elevation: 0,
                    ),
                    child: _isLoading
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        : Text(
                            'Pay ${widget.price}',
                            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
