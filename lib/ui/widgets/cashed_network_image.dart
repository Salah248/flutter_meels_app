import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meels_app/resources/color_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    super.key,
    this.width,
    this.height,
    required this.imageUrl,
  });

  final double? width;
  final double? height;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
      clipBehavior: Clip.antiAlias,
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(color: ColorManager.primary),
        ),
        errorWidget: (context, url, error) {
          debugPrint('error $error');
          return const Icon(Icons.error);
        },
        imageUrl: imageUrl,
        height: height?.h,
        width: width?.w,
      ),
    );
  }
}
