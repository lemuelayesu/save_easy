import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SmsOtpAuthenticationPage extends StatefulWidget {
  final Future<String> Function(String phoneNumber)
      sendOtp; // Function to send OTP
  final Future<bool> Function(String phoneNumber, String otp)
      verifyOtp; // Function to verify OTP

  const SmsOtpAuthenticationPage({
    Key? key,
    required this.sendOtp,
    required this.verifyOtp,
  }) : super(key: key);

  @override
  _SmsOtpAuthenticationPageState createState() =>
      _SmsOtpAuthenticationPageState();
}

class _SmsOtpAuthenticationPageState extends State<SmsOtpAuthenticationPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  bool _isOtpSent = false;
  bool _isLoading = false;
  Timer? _timer;
  int _start = 60;

  @override
  void dispose() {
    _timer?.cancel();
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _start = 60; // Reset timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start > 0) {
        setState(() {
          _start--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  Future<void> _sendOtp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        await widget.sendOtp(_phoneController.text.trim());
        setState(() {
          _isOtpSent = true;
          _isLoading = false;
        });
        _startTimer();
      } catch (e) {
        //sending error - Snackbar
        print("Error sending OTP: $e");
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _verifyOtp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        bool isVerified = await widget.verifyOtp(
          _phoneController.text.trim(),
          _otpController.text.trim(),
        );
        setState(() {
          _isLoading = false;
        });
        if (isVerified) {
          // OTP verification successful, navigate to the next screen
          Navigator.pushReplacementNamed(
              context, '/home'); // Replace '/home' with your route
        } else {
          // Handle OTP verification failed (e.g., show a Snackbar)
          print("OTP verification failed");
        }
      } catch (e) {
        // Handle OTP verification error (e.g., show a Snackbar)
        print("Error verifying OTP: $e");
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Authentication'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  // Add more validation logic if needed
                  return null;
                },
              ),
              const SizedBox(height: 20),
              if (_isOtpSent) ...[
                TextFormField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'OTP',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter OTP';
                    }
                    // Add more validation logic if needed
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                _start > 0
                    ? Text('Resend OTP in $_start seconds')
                    : TextButton(
                        onPressed: _startTimer,
                        child: const Text('Resend OTP'),
                      ),
              ],
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : _isOtpSent
                        ? _verifyOtp
                        : _sendOtp,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : Text(_isOtpSent ? 'Verify OTP' : 'Send OTP'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
