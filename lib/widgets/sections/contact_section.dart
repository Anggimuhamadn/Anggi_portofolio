import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ContactChatSection extends StatefulWidget {
  const ContactChatSection({super.key});

  @override
  State<ContactChatSection> createState() => _ContactChatSectionState();
}

class _ContactChatSectionState extends State<ContactChatSection> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  bool _isSubmitHovered = false;
  bool _isLoading = false;


  Future<void> _sendMessage() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);


    const String serviceId = 'service_bluktty';
    const String templateId = 'template_w6up00x';
    const String publicKey = '8KX3kBYiC-PbMN_f5';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    try {
      final response = await http.post(
        url,
        headers: {
          'Origin': 'http://localhost',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': publicKey,
          'template_params': {
            'from_name': _nameController.text,
            'from_email': _emailController.text,
            'message': _messageController.text,
          },
        }),
      );

      setState(() => _isLoading = false);

      if (response.statusCode == 200) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Pesan berhasil terkirim',
                style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.bold, color: Colors.white),
              ),
              backgroundColor: const Color(0xff00D2FF),
            ),
          );
        }
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
      } else {
        throw Exception('Failed to send email');
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('❌ Gagal ngirim email. Cek koneksi / ID EmailJS lu bre!'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isDesktop = constraints.maxWidth > 800;

        return Container(
          width: double.infinity,
          color: const Color(0xff090D16),
          padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 60 : 24,
              vertical: 120
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xff00D2FF).withOpacity(0.06),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xff00D2FF).withOpacity(0.3),
                        width: 1.2,
                      ),
                    ),
                    child: const Text(
                      "✉️ GET IN TOUCH",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: Color(0xff00D2FF),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),


                  const SizedBox(height: 12),
                  const Text(
                    "Punya ide project atau sekadar mau ngobrol santai? Drop bensin lu di sini bre!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      color: Color(0xff94A3B8),
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 56),


                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff111827).withOpacity(0.3),
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.05),
                        width: 1.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff00D2FF).withOpacity(0.02),
                          blurRadius: 40,
                          offset: const Offset(0, 15),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [

                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                          decoration: BoxDecoration(
                            color: const Color(0xff111827).withOpacity(0.8),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(26),
                              topRight: Radius.circular(26),
                            ),
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.white.withOpacity(0.05),
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundColor: const Color(0xff00D2FF).withOpacity(0.1),
                                    child: const Icon(Icons.person_outline, color: Color(0xff00D2FF), size: 20),
                                  ),
                                  Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        color: const Color(0xff10B981),
                                        shape: BoxShape.circle,
                                        border: Border.all(color: const Color(0xff111827), width: 1.5),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(width: 14),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Anggi Muhamad Nawawi",
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "Active now",
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: Color(0xff10B981),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.all(28),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 15,
                                    backgroundColor: const Color(0xff00D2FF).withOpacity(0.12),
                                    child: const Text("<>", style: TextStyle(color: Color(0xff00D2FF), fontSize: 11, fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(width: 12),
                                  Flexible(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                                      decoration: BoxDecoration(
                                        color: const Color(0xff1E293B).withOpacity(0.5),
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(18),
                                          bottomLeft: Radius.circular(4),
                                          bottomRight: Radius.circular(18),
                                        ),
                                        border: Border.all(color: Colors.white.withOpacity(0.04)),
                                      ),
                                      child: const Text(
                                        "Yoo! Senang lu mampir. Silakan isi nama, email, sama detail project atau pesan lu di bawah ya. Let's make something awesome together!",
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          color: Colors.white,
                                          fontSize: 14,
                                          height: 1.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 36),


                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    if (isDesktop)
                                      Row(
                                        children: [
                                          Expanded(child: _buildChatTextField(controller: _nameController, hint: "Nama lu siapa bre?", label: "Nama", icon: Icons.badge_outlined)),
                                          const SizedBox(width: 16),
                                          Expanded(child: _buildChatTextField(controller: _emailController, hint: "Biar gua bisa reply balik...", label: "Email", icon: Icons.alternate_email, isEmail: true)),
                                        ],
                                      )
                                    else ...[
                                      _buildChatTextField(controller: _nameController, hint: "Nama lu siapa bre?", label: "Nama", icon: Icons.badge_outlined),
                                      const SizedBox(height: 16),
                                      _buildChatTextField(controller: _emailController, hint: "Biar gua bisa reply balik...", label: "Email", icon: Icons.alternate_email, isEmail: true),
                                    ],
                                    const SizedBox(height: 16),

                                    _buildChatTextField(
                                      controller: _messageController,
                                      hint: "Ketik pesan atau detail project lu di sini...",
                                      label: "Pesan",
                                      icon: Icons.chat_bubble_outline_rounded,
                                      maxLines: 4,
                                    ),
                                    const SizedBox(height: 28),


                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: MouseRegion(
                                        onEnter: (_) => setState(() => _isSubmitHovered = true),
                                        onExit: (_) => setState(() => _isSubmitHovered = false),
                                        child: AnimatedContainer(
                                          duration: const Duration(milliseconds: 200),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(14),
                                            gradient: LinearGradient(
                                              colors: _isSubmitHovered
                                                  ? [const Color(0xff00F5D4), const Color(0xff00D2FF)]
                                                  : [const Color(0xff0066FF), const Color(0xff00D2FF)],
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(0xff00D2FF).withOpacity(_isSubmitHovered ? 0.4 : 0.1),
                                                blurRadius: _isSubmitHovered ? 20 : 8,
                                                offset: const Offset(0, 4),
                                              )
                                            ],
                                          ),
                                          child: ElevatedButton.icon(
                                            onPressed: _isLoading ? null : _sendMessage,
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.transparent,
                                              shadowColor: Colors.transparent,
                                              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(14),
                                              ),
                                            ),
                                            icon: _isLoading
                                                ? const SizedBox(
                                              width: 18,
                                              height: 18,
                                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                            )
                                                : const Icon(Icons.send_rounded, color: Colors.white, size: 18),
                                            label: Text(
                                              _isLoading ? "Mengirim..." : "Kirim Pesan",
                                              style: const TextStyle(
                                                fontFamily: 'Inter',
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
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
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildChatTextField({
    required TextEditingController controller,
    required String hint,
    required String label,
    required IconData icon,
    int maxLines = 1,
    bool isEmail = false,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(fontFamily: 'Inter', color: Colors.white, fontSize: 14),
      cursorColor: const Color(0xff00D2FF),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return '$label ga boleh kosong bre!';
        }
        if (isEmail && !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
          return 'Format email salah tuh, cek lagi bre';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontFamily: 'Inter', color: Colors.white.withOpacity(0.4), fontSize: 13),
        hintText: hint,
        hintStyle: TextStyle(fontFamily: 'Inter', color: Colors.white.withOpacity(0.25), fontSize: 13),
        prefixIcon: Icon(icon, color: Colors.white.withOpacity(0.3), size: 18),
        floatingLabelStyle: const TextStyle(color: Color(0xff00D2FF), fontWeight: FontWeight.bold),
        filled: true,
        fillColor: const Color(0xff111827).withOpacity(0.6),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.05), width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xff00D2FF), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
        ),
      ),
    );
  }
}