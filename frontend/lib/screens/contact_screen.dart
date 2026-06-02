import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  // CHANGE THIS TO YOUR BACKEND URL AFTER DEPLOYMENT
  final String apiUrl = 'http://localhost:5000/api/contact';

  Future<void> submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() {
      _isLoading = true;
      _successMessage = null;
      _errorMessage = null;
    });
    
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': _nameController.text,
          'email': _emailController.text,
          'phone': _phoneController.text,
          'subject': _subjectController.text.isEmpty ? 'General Inquiry' : _subjectController.text,
          'message': _messageController.text,
        }),
      );
      
      if (response.statusCode == 200) {
        setState(() {
          _successMessage = 'Thank you! We will contact you soon.';
          _nameController.clear();
          _emailController.clear();
          _phoneController.clear();
          _subjectController.clear();
          _messageController.clear();
        });
      } else {
        setState(() {
          _errorMessage = 'Something went wrong. Please try again.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Connection error. Please try again later.';
      });
    }
    
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side - Contact Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Get in Touch',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A)),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Let's discuss your next project",
                  style: TextStyle(fontSize: 18, color: Color(0xFF666666)),
                ),
                const SizedBox(height: 40),
                _buildContactInfo(
                  Icons.location_on,
                  'Address',
                  'Itahari, Sunsari, Nepal',
                ),
                const SizedBox(height: 24),
                _buildContactInfo(
                  Icons.email,
                  'Email',
                  'hello@vertexbit.com',
                ),
                const SizedBox(height: 24),
                _buildContactInfo(
                  Icons.phone,
                  'Phone',
                  '+977 98XXXXXXXX',
                ),
              ],
            ),
          ),
          
          const SizedBox(width: 40),
          
          // Right side - Contact Form
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    if (_successMessage != null)
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.green),
                        ),
                        child: Text(_successMessage!, style: const TextStyle(color: Colors.green)),
                      ),
                    if (_errorMessage != null)
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.red),
                        ),
                        child: Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
                      ),
                    const SizedBox(height: 16),
                    _buildTextField(_nameController, 'Your Name *', Icons.person),
                    const SizedBox(height: 16),
                    _buildTextField(_emailController, 'Your Email *', Icons.email),
                    const SizedBox(height: 16),
                    _buildTextField(_phoneController, 'Phone *', Icons.phone),
                    const SizedBox(height: 16),
                    _buildTextField(_subjectController, 'Subject', Icons.subject),
                    const SizedBox(height: 16),
                    _buildMessageField(_messageController, 'Message *'),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0F2B5B),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : const Text('Send Message', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildContactInfo(IconData icon, String title, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFF0F2B5B).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF0F2B5B), size: 24),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Color(0xFF999999), fontSize: 12)),
            Text(value, style: const TextStyle(fontSize: 16, color: Color(0xFF1A1A1A))),
          ],
        ),
      ],
    );
  }
  
  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF0F2B5B)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF0F2B5B), width: 2),
        ),
      ),
      validator: (value) {
        if (label.contains('*') && (value == null || value.isEmpty)) {
          return 'This field is required';
        }
        return null;
      },
    );
  }
  
  Widget _buildMessageField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      maxLines: 4,
      decoration: InputDecoration(
        labelText: label,
        alignLabelWithHint: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF0F2B5B), width: 2),
        ),
      ),
      validator: (value) {
        if (label.contains('*') && (value == null || value.isEmpty)) {
          return 'This field is required';
        }
        return null;
      },
    );
  }
}