import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Design tokens
// ---------------------------------------------------------------------------
const Color _pine = Color(0xFF0E5C4F); // Customization 1: new theme color
const Color _ink = Color(0xFF16231F);
const Color _mist = Color(0xFFF2F5F3);
const Color _line = Color(0xFFD3DDD8);
const Color _marigold = Color(0xFFF2B134);

// Customization 4: minimum password length is now 8.
const int minPasswordLength = 8;

void main() {
  runApp(const LoginRegisterApp());
}

class LoginRegisterApp extends StatelessWidget {
  const LoginRegisterApp({super.key});

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: _line),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab Activity 3',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _pine,
          primary: _pine,
          surface: _mist,
        ),
        scaffoldBackgroundColor: _mist,
        textTheme: Typography.blackMountainView.apply(
          bodyColor: _ink,
          displayColor: _ink,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          border: inputBorder,
          enabledBorder: inputBorder,
          focusedBorder: inputBorder.copyWith(
            borderSide: const BorderSide(color: _pine, width: 2),
          ),
          errorBorder: inputBorder.copyWith(
            borderSide: BorderSide(color: Colors.red.shade700),
          ),
          focusedErrorBorder: inputBorder.copyWith(
            borderSide: BorderSide(color: Colors.red.shade700, width: 2),
          ),
          prefixIconColor: Colors.black54,
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(54),
            backgroundColor: _pine,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(54),
            foregroundColor: _pine,
            side: const BorderSide(color: _pine),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          backgroundColor: _ink,
          contentTextStyle: const TextStyle(color: Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      home: const AuthPage(),
    );
  }
}

// ---------------------------------------------------------------------------
// Validators
// ---------------------------------------------------------------------------
String? validateFullName(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Please enter your full name.';
  }
  return null;
}

String? validateEmail(String? value) {
  final email = value?.trim() ?? '';

  if (email.isEmpty) {
    return 'Please enter your email.';
  }

  // Basic format check for this activity.
  final emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  if (!emailPattern.hasMatch(email)) {
    return 'Please enter a valid email.';
  }

  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your password.';
  }

  if (value.length < minPasswordLength) {
    return 'Use at least $minPasswordLength characters.';
  }

  return null;
}

String? validateConfirmPassword(String? value, String password) {
  if (value == null || value.isEmpty) {
    return 'Please confirm your password.';
  }

  if (value != password) {
    return 'Passwords do not match.';
  }

  return null;
}

// ---------------------------------------------------------------------------
// Brand mark
// ---------------------------------------------------------------------------
class BrandHeader extends StatelessWidget {
  const BrandHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 52,
          height: 52,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: _pine,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.school_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              Positioned(
                right: -4,
                top: -4,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: _marigold,
                    shape: BoxShape.circle,
                    border: Border.all(color: _mist, width: 2),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 14),
        // Customization 2: application name above the form.
        const Text(
          'CampusConnect',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
            color: _ink,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Welcome screen
// ---------------------------------------------------------------------------
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({
    super.key,
    required this.name,
    required this.email,
    required this.onLogout,
  });

  final String name;
  final String email;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 112,
                    height: 112,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          radius: 56,
                          backgroundColor: _pine,
                          child: Text(
                            initial,
                            style: const TextStyle(
                              fontSize: 44,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: _mist,
                              shape: BoxShape.circle,
                            ),
                            child: const CircleAvatar(
                              radius: 14,
                              backgroundColor: _marigold,
                              child: Icon(
                                Icons.check_rounded,
                                size: 18,
                                color: _ink,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'Welcome, $name!',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'You are logged in.',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: _line),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.email_outlined,
                          size: 18,
                          color: Colors.black54,
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(email, overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 36),
                  OutlinedButton.icon(
                    onPressed: onLogout,
                    icon: const Icon(Icons.logout_rounded),
                    label: const Text('Logout'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Auth page (login + register)
// ---------------------------------------------------------------------------
class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLogin = true;
  bool _hidePassword = true;
  bool _isLoggedIn = false;

  String? _registeredName;
  String? _registeredEmail;
  String? _registeredPassword;

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _clearFields() {
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
  }

  void _switchForm() {
    _formKey.currentState?.reset();
    _clearFields();

    setState(() {
      _isLogin = !_isLogin;
      _hidePassword = true;
    });
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final email = _emailController.text.trim().toLowerCase();
    final password = _passwordController.text;

    if (_isLogin) {
      if (_registeredEmail == null) {
        _showMessage('Please register an account first.');
        return;
      }

      if (email != _registeredEmail || password != _registeredPassword) {
        _showMessage('Incorrect email or password.');
        return;
      }

      _clearFields();

      setState(() {
        _isLoggedIn = true;
      });
    } else {
      if (_registeredEmail != null) {
        _showMessage('An account already exists. Please log in.');
        return;
      }

      _registeredName = _nameController.text.trim();
      _registeredEmail = email;
      _registeredPassword = password;

      _formKey.currentState!.reset();
      _clearFields();

      setState(() {
        _isLogin = true;
        _hidePassword = true;
      });

      _showMessage('Registration successful! Please log in.');
    }
  }

  void _logout() {
    _clearFields();

    setState(() {
      _isLoggedIn = false;
      _isLogin = true;
      _hidePassword = true;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoggedIn) {
      return WelcomeScreen(
        name: _registeredName ?? '',
        email: _registeredEmail ?? '',
        onLogout: _logout,
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const BrandHeader(),
                  const SizedBox(height: 32),

                  // Login / Register switch
                  SegmentedButton<bool>(
                    showSelectedIcon: false,
                    style: SegmentedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: _ink,
                      selectedBackgroundColor: _pine,
                      selectedForegroundColor: Colors.white,
                      side: const BorderSide(color: _line),
                      minimumSize: const Size.fromHeight(46),
                    ),
                    segments: const [
                      ButtonSegment(value: true, label: Text('Login')),
                      ButtonSegment(value: false, label: Text('Register')),
                    ],
                    selected: {_isLogin},
                    onSelectionChanged: (selection) {
                      if (selection.first != _isLogin) {
                        _switchForm();
                      }
                    },
                  ),
                  const SizedBox(height: 28),

                  Text(
                    _isLogin ? 'Welcome back' : 'Create your account',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _isLogin
                        ? 'Log in to continue.'
                        : 'Fill in your details to get started.',
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 24),

                  Form(
                    key: _formKey,
                    child: AnimatedSize(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOut,
                      alignment: Alignment.topCenter,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Name field appears only during registration.
                          if (!_isLogin) ...[
                            TextFormField(
                              controller: _nameController,
                              textCapitalization: TextCapitalization.words,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                labelText: 'Full Name',
                                prefixIcon: Icon(Icons.person_outline),
                              ),
                              validator: validateFullName,
                            ),
                            const SizedBox(height: 16),
                          ],

                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            autocorrect: false,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                            validator: validateEmail,
                          ),
                          const SizedBox(height: 16),

                          TextFormField(
                            controller: _passwordController,
                            obscureText: _hidePassword,
                            autocorrect: false,
                            enableSuggestions: false,
                            textInputAction: _isLogin
                                ? TextInputAction.done
                                : TextInputAction.next,
                            onFieldSubmitted: (_) {
                              if (_isLogin) _submitForm();
                            },
                            decoration: InputDecoration(
                              labelText: 'Password',
                              helperText: _isLogin
                                  ? null
                                  : 'At least $minPasswordLength characters',
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                tooltip: _hidePassword
                                    ? 'Show password'
                                    : 'Hide password',
                                icon: Icon(
                                  _hidePassword
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _hidePassword = !_hidePassword;
                                  });
                                },
                              ),
                            ),
                            validator: validatePassword,
                          ),
                          const SizedBox(height: 16),

                          // Confirmation appears only during registration.
                          if (!_isLogin) ...[
                            TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: _hidePassword,
                              autocorrect: false,
                              enableSuggestions: false,
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (_) => _submitForm(),
                              decoration: const InputDecoration(
                                labelText: 'Confirm Password',
                                prefixIcon: Icon(Icons.lock_outline),
                              ),
                              validator: (value) => validateConfirmPassword(
                                value,
                                _passwordController.text,
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),
                  FilledButton(
                    onPressed: _submitForm,
                    child: Text(_isLogin ? 'Login' : 'Register'),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: _switchForm,
                    style: TextButton.styleFrom(foregroundColor: _pine),
                    child: Text(
                      _isLogin
                          ? 'No account yet? Register'
                          : 'Already have an account? Login',
                    ),
                  ),

                  // Customization 3: your name and section below the form.
                  const SizedBox(height: 28),
                  const Text(
                    'Your Full Name, Your Section',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black45),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
