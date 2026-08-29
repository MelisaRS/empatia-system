import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({
    super.key,
    this.title,
    this.showBackButton = false,
    this.showProfile = false,
    this.showLogo = true,
    this.centerLogo = false,
    this.profileImage,
    this.onBack,
  });

  final String? title;
  final bool showBackButton;
  final bool showProfile;
  final bool showLogo;
  final bool centerLogo;
  final ImageProvider? profileImage;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF0FBFD),
      elevation: 0,
      scrolledUnderElevation: 0,
      toolbarHeight: 64,
      centerTitle: true,

      leading: showBackButton
          ? IconButton(onPressed: onBack, icon: const Icon(Icons.chevron_left))
          : null,

      title: centerLogo
          ? Image.asset('assets/images/logo.jpg', height: 32)
          : title != null
          ? Text(
              title!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )
          : showLogo
          ? Align(
              alignment: Alignment.centerLeft,
              child: Image.asset('assets/images/logo.jpg', height: 32),
            )
          : null,

      actions: showProfile
          ? [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFE85C9E),
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundImage: profileImage,
                    child: profileImage == null
                        ? const Icon(Icons.person, size: 16)
                        : null,
                  ),
                ),
              ),
            ]
          : null,

      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1, color: const Color(0xFFB8E6ED)),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(65);
}
