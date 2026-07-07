import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class ScannerCameraView extends StatelessWidget {
  const ScannerCameraView({
    super.key,
    required this.controller,
    required this.isInitialized,
    required this.pageCount,
    required this.onCapture,
    required this.onPickGallery,
    required this.onClose,
    required this.onRetry,
    required this.onPreview,
  });

  final CameraController? controller;
  final bool isInitialized;
  final int pageCount;
  final VoidCallback onCapture;
  final VoidCallback onPickGallery;
  final VoidCallback onClose;
  final VoidCallback onRetry;
  final VoidCallback onPreview;

  @override
  Widget build(BuildContext context) {
    final EdgeInsets safePadding = MediaQuery.paddingOf(context);

    return Scaffold(
      backgroundColor: AppColors.homeInk,
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (isInitialized && controller != null)
            _CameraPreview(controller: controller!)
          else
            _CameraUnavailable(onRetry: onRetry, onGallery: onPickGallery),
          _CameraTopBar(topPadding: safePadding.top, pageCount: pageCount, onClose: onClose),
          if (isInitialized && controller != null) const _DocumentGuide(),
          if (isInitialized && controller != null)
            _CameraControls(
              bottomPadding: safePadding.bottom,
              onCapture: onCapture,
              onGallery: onPickGallery,
              pageCount: pageCount,
              onPreview: onPreview,
            ),
        ],
      ),
    );
  }
}

class _CameraPreview extends StatelessWidget {
  const _CameraPreview({required this.controller});

  final CameraController controller;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final double scale = 1 / (controller.value.aspectRatio * size.aspectRatio);

    return ClipRect(child: Transform.scale(scale: scale < 1 ? 1 / scale : scale, child: Center(child: CameraPreview(controller))));
  }
}

class _CameraTopBar extends StatelessWidget {
  const _CameraTopBar({required this.topPadding, required this.pageCount, required this.onClose});

  final double topPadding;
  final int pageCount;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topPadding + Dimens.h8,
      left: Dimens.w16,
      right: Dimens.w16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _CameraCircleButton(icon: Icons.close_rounded, onTap: onClose),
          Container(
            padding: EdgeInsets.symmetric(horizontal: Dimens.w12, vertical: Dimens.h8),
            decoration: BoxDecoration(color: AppColors.homeInk.withValues(alpha: 0.72), borderRadius: BorderRadius.circular(Dimens.r20)),
            child: Text(
              pageCount == 0 ? AppStrings.scanStudyMaterial : '$pageCount ${AppStrings.pagesCaptured}',
              style: AppStyles.labelMedium.copyWith(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _DocumentGuide extends StatelessWidget {
  const _DocumentGuide();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimens.w28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 0.72,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimens.r20),
                  border: Border.all(color: AppColors.white.withValues(alpha: 0.9), width: Dimens.borderWidthMedium),
                ),
              ),
            ),
            SizedBox(height: Dimens.h12),
            Text(AppStrings.alignPageWithinFrame, style: AppStyles.bodySmallBold.copyWith(color: AppColors.white)),
          ],
        ),
      ),
    );
  }
}

class _CameraControls extends StatelessWidget {
  const _CameraControls({
    required this.bottomPadding,
    required this.onCapture,
    required this.onGallery,
    required this.pageCount,
    required this.onPreview,
  });

  final double bottomPadding;
  final VoidCallback onCapture;
  final VoidCallback onGallery;
  final int pageCount;
  final VoidCallback onPreview;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.fromLTRB(Dimens.w28, Dimens.h20, Dimens.w28, bottomPadding + Dimens.h20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.transparent, AppColors.homeInk.withValues(alpha: 0.95)],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _CameraCircleButton(icon: Icons.photo_library_outlined, onTap: onGallery),
            Semantics(
              button: true,
              label: AppStrings.capturePage,
              child: GestureDetector(
                onTap: onCapture,
                child: Container(
                  width: Dimens.w80,
                  height: Dimens.h80,
                  padding: EdgeInsets.all(Dimens.w6),
                  decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.white)),
                  child: const DecoratedBox(decoration: BoxDecoration(color: AppColors.white, shape: BoxShape.circle)),
                ),
              ),
            ),
            if (pageCount > 0)
              _CameraCircleButton(icon: Icons.arrow_forward_rounded, onTap: onPreview, badgeCount: pageCount)
            else
              const SizedBox(width: 48),
          ],
        ),
      ),
    );
  }
}

class _CameraCircleButton extends StatelessWidget {
  const _CameraCircleButton({required this.icon, required this.onTap, this.badgeCount = 0});

  final IconData icon;
  final VoidCallback onTap;
  final int badgeCount;

  @override
  Widget build(BuildContext context) {
    final button = Material(
      color: AppColors.homeInk.withValues(alpha: 0.72),
      shape: const CircleBorder(),
      child: IconButton(onPressed: onTap, icon: Icon(icon, color: AppColors.white, size: Dimens.icon24)),
    );

    if (badgeCount > 0) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          button,
          Positioned(
            top: -2,
            right: -2,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
              constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
              child: Center(
                child: Text('$badgeCount', style: const TextStyle(color: AppColors.white, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      );
    }
    return button;
  }
}

class _CameraUnavailable extends StatelessWidget {
  const _CameraUnavailable({required this.onRetry, required this.onGallery});

  final VoidCallback onRetry;
  final VoidCallback onGallery;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(Dimens.w28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.no_photography_outlined, color: AppColors.grey400, size: Dimens.icon56),
              SizedBox(height: Dimens.h16),
              Text(AppStrings.cameraUnavailable, textAlign: TextAlign.center, style: AppStyles.bodyLarge.copyWith(color: AppColors.white)),
              SizedBox(height: Dimens.h20),
              FilledButton(onPressed: onRetry, child: const Text(AppStrings.retry)),
              TextButton(onPressed: onGallery, child: const Text(AppStrings.uploadFromGallery)),
            ],
          ),
        ),
      ),
    );
  }
}
