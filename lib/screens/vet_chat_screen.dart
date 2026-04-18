import 'package:flutter/material.dart';

class VetChatScreen extends StatelessWidget {
  const VetChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F4),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_rounded),
                  ),
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=160&h=160&fit=crop',
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Dr. Sarah Chen',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(width: 6),
                            Icon(Icons.verified_rounded,
                                color: Colors.green, size: 18),
                          ],
                        ),
                        Text(
                          'Online - Ready to help',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search_rounded),
                  ),
                  Container(
                    padding: const EdgeInsets.all(13),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFB22E),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.videocam_rounded),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 22, 24, 12),
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: const Text(
                        'TODAY',
                        style: TextStyle(
                          letterSpacing: 2,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  _doctorBubble(
                    "Hello! I'm Dr. Sarah. I've just reviewed Luna's recent health records. How is she feeling after her vaccination yesterday?",
                    '10:42 AM',
                  ),
                  _userBubble(
                    "Hi Dr. Sarah! She seems a bit lethargic today and isn't showing much interest in her favorite treats. Is this normal?",
                    '10:45 AM',
                  ),
                  _imageBubble(),
                  _doctorBubble(
                    'Mild lethargy is quite common for the first 24-48 hours. However, her eyes look clear in the photo. Has she had any water?',
                    '10:48 AM',
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(18, 8, 18, 18),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 18,
                    backgroundColor: Color(0xFF0B7D24),
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Type a message...',
                      style: TextStyle(color: Colors.black45, fontSize: 16),
                    ),
                  ),
                  Icon(Icons.image_rounded, color: Colors.green.shade700),
                  const SizedBox(width: 12),
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.green.shade700,
                    child: const Icon(Icons.send_rounded, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _doctorBubble(String text, String time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 54),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Text(text, style: const TextStyle(fontSize: 17, height: 1.45)),
        ),
        const SizedBox(height: 6),
        Text(time, style: const TextStyle(fontSize: 12)),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _userBubble(String text, String time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 74),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.green.shade800,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Text(
            text,
            style:
                const TextStyle(fontSize: 17, height: 1.45, color: Colors.white),
          ),
        ),
        const SizedBox(height: 6),
        Text(time, style: const TextStyle(fontSize: 12)),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _imageBubble() {
    return Container(
      margin: const EdgeInsets.only(left: 74, bottom: 24),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green.shade800,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.network(
              'https://images.unsplash.com/photo-1574158622682-e40e69881006?w=600&h=420&fit=crop',
              height: 190,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            "She's just been resting like this for most of the morning.",
            style: TextStyle(color: Colors.white, fontSize: 17, height: 1.4),
          ),
        ],
      ),
    );
  }
}
