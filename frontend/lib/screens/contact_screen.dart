import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  bool _isLoading = false;
  String? _successMessage;
  String? _errorMessage;

  Uri get _contactUri => Uri.parse('${AppStrings.apiBaseUrl}/contact');

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _successMessage = null;
      _errorMessage = null;
    });

    try {
      final response = await http.post(
        _contactUri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': _nameController.text.trim(),
          'email': _emailController.text.trim(),
          'phone': _phoneController.text.trim(),
          'subject': _subjectController.text.trim().isEmpty
              ? 'General Inquiry'
              : _subjectController.text.trim(),
          'message': _messageController.text.trim(),
        }),
      );

      if (!mounted) return;

      if (response.statusCode >= 200 && response.statusCode < 300) {
        setState(() {
          _successMessage = 'Thank you. We will contact you soon.';
          _nameController.clear();
          _emailController.clear();
          _phoneController.clear();
          _subjectController.clear();
          _messageController.clear();
        });
      } else {
        setState(() {
          _errorMessage = 'Your message could not be sent. Please try again.';
        });
      }
    } catch (e, stackTrace) {
      print("ERROR: $e");
      print("STACK: $stackTrace");

      if (!mounted) return;

      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < 720;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Get in Touch'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : 40,
            vertical: isMobile ? 28 : 40,
          ),
          color: Colors.white,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1080),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Let's discuss your next project",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 28),
                  // ⭐ Updated: Wrap with hoverable contact cards
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: const [
                      _ContactCard(Icons.location_on, 'Address', 'Mahabir Chowk,Siraha,Nepal'),
                      _ContactCard(Icons.email, 'Email', 'abhiishek57@gmail.com'),
                      _ContactCard(Icons.phone, 'Phone', '+977 9766359540'),
                    ],
                  ),
                  const SizedBox(height: 36),
                  Container(
                    padding: EdgeInsets.all(isMobile ? 18 : 24),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          if (_successMessage != null)
                            _StatusMessage(
                              message: _successMessage!,
                              color: Colors.green,
                            ),
                          if (_errorMessage != null)
                            _StatusMessage(
                              message: _errorMessage!,
                              color: Colors.red,
                            ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            _nameController,
                            'Your Name *',
                            Icons.person,
                            _requiredText,
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            _emailController,
                            'Your Email *',
                            Icons.email,
                            _validateEmail,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            _phoneController,
                            'Phone *',
                            Icons.phone,
                            _validatePhone,
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            _subjectController,
                            'Subject',
                            Icons.subject,
                            (_) => null,
                          ),
                          const SizedBox(height: 16),
                          _buildMessageField(),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: _isLoading ? null : submitForm,
                              icon: _isLoading
                                  ? const SizedBox(
                                      height: 18,
                                      width: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    )
                                  : const Icon(Icons.send_outlined),
                              label: Text(
                                  _isLoading ? 'Sending...' : 'Send Message'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
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
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon,
    String? Function(String?) validator, {
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      decoration: _inputDecoration(label, icon),
      validator: validator,
    );
  }

  Widget _buildMessageField() {
    return TextFormField(
      controller: _messageController,
      maxLines: 5,
      minLines: 4,
      textInputAction: TextInputAction.newline,
      decoration:
          _inputDecoration('Message *', Icons.chat_bubble_outline).copyWith(
        alignLabelWithHint: true,
      ),
      validator: (value) {
        final text = value?.trim() ?? '';
        if (text.isEmpty) return 'Message is required';
        if (text.length < 10) return 'Please add a little more detail';
        return null;
      },
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: AppColors.primary),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }

  String? _requiredText(String? value) {
    if ((value ?? '').trim().isEmpty) return 'This field is required';
    return null;
  }

  String? _validateEmail(String? value) {
    final email = (value ?? '').trim();
    if (email.isEmpty) return 'Email is required';
    final emailPattern = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (!emailPattern.hasMatch(email)) return 'Enter a valid email address';
    return null;
  }

  String? _validatePhone(String? value) {
    final phone = (value ?? '').trim();
    if (phone.isEmpty) return 'Phone is required';
    if (phone.length < 7) return 'Enter a valid phone number';
    return null;
  }
}

// ⭐ UPDATED: Contact Card with hover effect (like Products section)
class _ContactCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String value;

  const _ContactCard(this.icon, this.title, this.value);

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < 720;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        // ⭐ Lift up on hover (exactly like Products section)
        transform: _isHovered && !isMobile
            ? Matrix4.translationValues(0, -8, 0)
            : Matrix4.identity(),
        width: isMobile ? double.infinity : 320,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: _isHovered && !isMobile
              ? [
                  // ⭐ Enhanced shadow on hover (like Products section)
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.2),
                    blurRadius: 20,
                    spreadRadius: 5,
                    offset: const Offset(0, 10),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
          border: Border.all(
            color: _isHovered && !isMobile
                ? AppColors.primary
                : Colors.black.withOpacity(0.08),
            width: _isHovered && !isMobile ? 2 : 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(widget.icon, color: AppColors.primary, size: 24),
              ),
              const SizedBox(height: 12),
              Text(
                widget.title,
                style: const TextStyle(color: AppColors.textLight, fontSize: 12),
              ),
              const SizedBox(height: 4),
              Text(
                widget.value,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: AppColors.textDark),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusMessage extends StatelessWidget {
  final String message;
  final Color color;

  const _StatusMessage({
    required this.message,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
      ),
      child: Text(message, style: TextStyle(color: color)),
    );
  }
}