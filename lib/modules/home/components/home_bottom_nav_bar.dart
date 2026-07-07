import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';

class HomeNavItem {
  const HomeNavItem({required this.icon, required this.label, required this.route});

  final IconData icon;
  final String label;
  final String route;
}

class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({super.key, required this.selectedIndex, required this.items, required this.onTap, required this.onScanTap});

  final int selectedIndex;
  final List<HomeNavItem> items;
  final ValueChanged<int> onTap;
  final VoidCallback onScanTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final navBarColor = isDark ? AppColors.darkSurface : AppColors.white;

    // Define status bar colors and icon brightness based on active tab
    final bool isHomeTab = selectedIndex == 0;

    final Color statusBarColor = isHomeTab ? Colors.transparent : (isDark ? AppColors.darkBackground : AppColors.white);

    final Brightness statusBarIconBrightness =
        isHomeTab
            ? Brightness
                .light // Always light icons on dark gradient hero banner
            : (isDark ? Brightness.light : Brightness.dark);

    final Brightness statusBarBrightness = isHomeTab ? Brightness.dark : (isDark ? Brightness.dark : Brightness.light);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        // Set Android bottom system navigation bar color
        systemNavigationBarColor: navBarColor,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarContrastEnforced: false,
        // Set top status bar color and brightness dynamically
        statusBarColor: statusBarColor,
        statusBarIconBrightness: statusBarIconBrightness,
        statusBarBrightness: statusBarBrightness,
        systemStatusBarContrastEnforced: false,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: navBarColor,
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.06), blurRadius: 16, offset: const Offset(0, -4))],
          border: Border(top: BorderSide(color: isDark ? AppColors.grey800 : AppColors.grey100, width: 1)),
        ),
        child: SafeArea(
          top: false,
          child: Container(
            height: 68,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // ── Tab 0: Home ───────────────────────────────────────────────
                Expanded(
                  child: _TabItem(
                    icon: items[0].icon,
                    label: items[0].label,
                    isSelected: selectedIndex == 0,
                    onTap: () {
                      HapticFeedback.lightImpact();
                      onTap(0);
                    },
                    isDark: isDark,
                  ),
                ),

                // ── Tab 1: Subjects ───────────────────────────────────────────
                Expanded(
                  child: _TabItem(
                    icon: items[1].icon,
                    label: items[1].label,
                    isSelected: selectedIndex == 1,
                    onTap: () {
                      HapticFeedback.lightImpact();
                      onTap(1);
                    },
                    isDark: isDark,
                  ),
                ),

                // ── Center: Flat Scan Button ──────────────────────────────────
                Expanded(
                  child: _CenterScanTabButton(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      onScanTap();
                    },
                  ),
                ),

                // ── Tab 2: Revision ───────────────────────────────────────────
                Expanded(
                  child: _TabItem(
                    icon: items[2].icon,
                    label: items[2].label,
                    isSelected: selectedIndex == 2,
                    onTap: () {
                      HapticFeedback.lightImpact();
                      onTap(2);
                    },
                    isDark: isDark,
                  ),
                ),

                // ── Tab 3: Mastery ────────────────────────────────────────────
                Expanded(
                  child: _TabItem(
                    icon: items[3].icon,
                    label: items[3].label,
                    isSelected: selectedIndex == 3,
                    onTap: () {
                      HapticFeedback.lightImpact();
                      onTap(3);
                    },
                    isDark: isDark,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Individual Tab Item ─────────────────────────────────────────────────────

class _TabItem extends StatelessWidget {
  const _TabItem({required this.icon, required this.label, required this.isSelected, required this.onTap, required this.isDark});

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final activeColor = AppColors.primary;
    final inactiveColor = isDark ? AppColors.grey500 : AppColors.grey400;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.all(isSelected ? 8 : 6),
            decoration: BoxDecoration(
              color: isSelected ? activeColor.withValues(alpha: 0.12) : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: isSelected ? activeColor : inactiveColor, size: 22),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? activeColor : inactiveColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// ─── Center Scan Action Button (Flat Aligned) ────────────────────────────────

class _CenterScanTabButton extends StatefulWidget {
  const _CenterScanTabButton({required this.onTap});
  final VoidCallback onTap;

  @override
  State<_CenterScanTabButton> createState() => _CenterScanTabButtonState();
}

class _CenterScanTabButtonState extends State<_CenterScanTabButton> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 100), lowerBound: 0.90, upperBound: 1.0, value: 1.0);
    _scaleAnim = _ctrl;
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.reverse(),
      onTapUp: (_) {
        _ctrl.forward();
        widget.onTap();
      },
      onTapCancel: () => _ctrl.forward(),
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: ScaleTransition(
          scale: _scaleAnim,
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.brandPurple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 10, offset: const Offset(0, 4))],
            ),
            child: const Center(child: FaIcon(FontAwesomeIcons.qrcode, color: AppColors.white, size: 20)),
          ),
        ),
      ),
    );
  }
}
