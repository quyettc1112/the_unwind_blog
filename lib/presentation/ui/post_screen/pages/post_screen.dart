import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_unwind_blog/common/helper/is_dark_mode.dart';
import '../../../../common/widgets/appbar/app_bar.dart';
import '../../../../common/widgets/tabbar/circle_tab_indicator.dart';
import '../../../../core/config/theme/app_colors.dart';
import '../../../../gen/assets.gen.dart';

class PostScreen extends StatefulWidget {
  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB9C2FF), // Màu tím pastel
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: _postBlogTemp()
      ),
    );
  }

  Widget _postBlogTemp() {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 30), // Khoảng cách đầu
          const Text(
            "THE UNWIND BLOG",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Create your\nown blog",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // TODO: handle button click
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
            ),
            child: const Text(
              "Get Started",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          const SizedBox(height: 40),

          Expanded(
            child: Center(
              child: Transform.scale(
                scale: 0.95, // 👈 scale 120% so với gốc
                child: SvgPicture.asset(
                  Assets.vectors.undrawIdeasFlow8d3x,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),


          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
