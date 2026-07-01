import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/colors.dart';
import '../../core/text_styles.dart';
import '../../viewmodels/auth_provider.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    
    // Using LayoutBuilder to ensure the scroll view takes at least the full height
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false, // Let the green wave go to the very bottom
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      // Top Asset Logo
                      Image.asset(
                        'assets/alive_logo.png',
                        width: 80,
                        height: 80,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(Icons.videocam, color: Colors.white, size: 40),
                        ),
                      ),
                      const SizedBox(height: 20), // Less spacing
                      
                      // Welcome Text
                      Text('Welcome back! 👋', style: AppTextStyles.headline1.copyWith(fontSize: 24)),
                      const SizedBox(height: 4),
                      Text(
                        'Sign in to continue your live streaming journey.',
                        style: AppTextStyles.subtitle1.copyWith(color: AppColors.textSecondary, fontSize: 13),
                      ),
                      const SizedBox(height: 24), // Less spacing
                      
                      // Form
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Email ID or Phone Number', style: AppTextStyles.bodyText1),
                            const SizedBox(height: 6),
                            _buildTextField(hint: 'Enter Registered Email or Phone No.'),
                            const SizedBox(height: 16),
                            Text('Password', style: AppTextStyles.bodyText1),
                            const SizedBox(height: 6),
                            _buildTextField(
                              hint: 'Enter your password',
                              isPassword: true,
                            ),
                            const SizedBox(height: 4),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(0, 0),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: const Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColors.primary,
                                    color: AppColors.primary, 
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: _navigateToHome,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text('Login', style: AppTextStyles.buttonText),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 24), // Spacing before wave
                      
                      // Double Wave Bottom Section
                      Expanded(
                        child: Stack(
                          children: [
                            // Back Wave (Lighter Green)
                            Positioned.fill(
                              child: ClipPath(
                                clipper: BackWaveClipper(),
                                child: Container(
                                  color: AppColors.primary.withOpacity(0.3),
                                ),
                              ),
                            ),
                            // Front Wave (Gradient Green) with Content
                            Positioned.fill(
                              child: ClipPath(
                                clipper: FrontWaveClipper(),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    gradient: AppColors.primaryGradient,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(height: 60), // Push content down past the wave curve
                                        Row(
                                          children: [
                                            const Expanded(child: Divider(color: Colors.white, thickness: 0.5)),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                              child: Text(
                                                'or continue with',
                                                style: AppTextStyles.bodyText1.copyWith(color: Colors.white, fontSize: 13),
                                              ),
                                            ),
                                            const Expanded(child: Divider(color: Colors.white, thickness: 0.5)),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        _buildSocialButton(
                                          iconPath: 'assets/google.png',
                                          label: 'Continue with Google',
                                          fallbackIcon: Icons.g_mobiledata,
                                          fallbackIconColor: Colors.red,
                                          isLoading: authViewModel.isLoading,
                                          onTap: () async {

                                            bool isSuccess = await context.read<AuthViewModel>().loginWithGoogle();


                                            if (isSuccess == true) {
                                              // Navigate to home
                                              if (context.mounted) {
                                                Navigator.of(context).pushReplacement(
                                                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                                                );
                                              }
                                            } else {
                                              if (context.mounted) {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(content: Text('Login Failed! Please try again.')),
                                                );
                                              }
                                            }
                                          },
                                        ),
                                        const SizedBox(height: 12),
                                        _buildSocialButton(
                                          iconPath: 'assets/facebook.png',
                                          label: 'Continue with Facebook',
                                          onTap: _navigateToHome,
                                          fallbackIcon: Icons.facebook,
                                          fallbackIconColor: Colors.blue,
                                        ),
                                        const Spacer(),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Don't have an account? ",
                                              style: AppTextStyles.bodyText1.copyWith(color: Colors.white, fontSize: 13),
                                            ),
                                            GestureDetector(
                                              onTap: () {},
                                              child: Text(
                                                "Sign Up",
                                                style: AppTextStyles.bodyText1.copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  decoration: TextDecoration.underline,
                                                  decorationColor: Colors.white,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
                                      ],
                                    ),
                                  ),
                                ),
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
        ),
      ),
    );
  }

  Widget _buildTextField({required String hint, bool isPassword = false}) {
    return SizedBox(
      height: 50,
      child: TextField(
        obscureText: isPassword && _obscurePassword,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          filled: true,
          fillColor: AppColors.cardBackground,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required String iconPath,
    required String label,
    required VoidCallback? onTap,
    required IconData fallbackIcon,
    required Color fallbackIconColor,
    bool isLoading = false,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: isLoading ? null : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          disabledBackgroundColor: Colors.white, // Keep background white when disabled/loading
        ),
        child: isLoading 
          ? const SizedBox(
              width: 24, 
              height: 24, 
              child: CircularProgressIndicator(
                strokeWidth: 2.5, 
                color: AppColors.primary,
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  iconPath,
                  width: 26,
                  height: 26,
                  errorBuilder: (context, error, stackTrace) => Icon(fallbackIcon, color: fallbackIconColor, size: 28),
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ],
            ),
      ),
    );
  }
}

class FrontWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 40);
    
    // First curve (goes down)
    var firstControlPoint = Offset(size.width / 4, 10);
    var firstEndPoint = Offset(size.width / 2, 40);
    path.quadraticBezierTo(
      firstControlPoint.dx, firstControlPoint.dy, 
      firstEndPoint.dx, firstEndPoint.dy
    );

    // Second curve (goes up then right)
    var secondControlPoint = Offset(size.width * 0.75, 70);
    var secondEndPoint = Offset(size.width, 30);
    path.quadraticBezierTo(
      secondControlPoint.dx, secondControlPoint.dy, 
      secondEndPoint.dx, secondEndPoint.dy
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class BackWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 20);
    
    var firstControlPoint = Offset(size.width / 4, 60);
    var firstEndPoint = Offset(size.width / 2, 30);
    path.quadraticBezierTo(
      firstControlPoint.dx, firstControlPoint.dy, 
      firstEndPoint.dx, firstEndPoint.dy
    );

    var secondControlPoint = Offset(size.width * 0.75, 0);
    var secondEndPoint = Offset(size.width, 50);
    path.quadraticBezierTo(
      secondControlPoint.dx, secondControlPoint.dy, 
      secondEndPoint.dx, secondEndPoint.dy
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
