// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/assets_app.dart';
import 'loading_screen.dart';

class CustomImageView extends StatelessWidget {
  static const String namePackage = 'com.example.student_portal'; // Project-specific file extension
  ///[imagePath] is required parameter for showing image
  String? imagePath;

  double? height;
  double? width;
  Color? color;
  BoxFit? fit;
  final String placeHolder;
  final Widget? placeHolderWidget;
  final bool materialNeeded;
  Alignment? alignment;
  VoidCallback? onTap;
  EdgeInsetsGeometry? margin;
  BorderRadius? radius;
  BoxBorder? border;
  bool circle;
  bool matchTextDirection;
  double opacity;

  ///a [CustomImageView] it can be used for showing any type of images
  /// it will shows the placeholder image if image is not found on network image
  CustomImageView({
    super.key,
    this.imagePath,
    this.height,
    this.width,
    this.color,
    this.fit,
    this.alignment,
    this.onTap,
    this.radius,
    this.margin,
    this.border,
    this.opacity = 1,
    this.circle = false,
    this.matchTextDirection = false,
    this.placeHolder = AssetsApp.logo,
    this.placeHolderWidget,
    this.materialNeeded = false,
  });

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment!,
            child: _buildWidget(),
          )
        : _buildWidget();
  }

  Widget _buildWidget() {
    log('imagePath: ${imagePath ?? 'NULL'}');
    Widget body = InkWell(
      onTap: onTap,
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: _buildCircleImage(),
      ),
    );
    if (materialNeeded) {
      return Material(
        type: MaterialType.transparency,
        child: body,
      );
    }
    return body;
  }

  ///build the image with border radius
  _buildCircleImage() {
    if (circle) {
      return Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: _buildImageWithBorder(),
      );
    } else {
      return ClipRRect(
        borderRadius: radius ?? BorderRadius.zero,
        child: _buildImageWithBorder(),
      );
    }
  }

  ///build the image with border and border radius style
  _buildImageWithBorder() {
    if (border != null) {
      return Container(
        decoration: BoxDecoration(
          border: border,
          borderRadius: radius,
        ),
        child: _buildImageView(),
      );
    } else {
      return _buildImageView();
    }
  }

  Widget _buildImageView() {
    fit ??= (circle ? BoxFit.cover : BoxFit.contain);
    if (imagePath != null && imagePath!.isNotEmpty) {
      switch (imagePath!.imageType) {
        case ImageType.svg:
          return SizedBox(
            height: height,
            width: width,
            child: SvgPicture.asset(
              imagePath!,
              height: height,
              width: width,
              fit: fit!,
              matchTextDirection: matchTextDirection,
              colorFilter: color == null
                  ? null
                  : ColorFilter.mode(color!, BlendMode.srcIn),
            ),
          );
        case ImageType.file:
          return Image.file(
            File(imagePath!),
            height: height,
            width: width,
            fit: fit!,
            color: color,
          );
        case ImageType.network:
          try {
            return CachedNetworkImage(
              height: height,
              width: width,
              fit: fit,
              imageUrl: imagePath!,
              color: color,
              placeholder: (context, url) => const SizedBox(
                height: 30,
                width: 30,
                child: LoadingScreen(),
              ),
              errorWidget: (context, url, error) {
                log('🛑 Network image failed: $error');
                return placeHolderWidget ??
                    Image.asset(
                      placeHolder,
                      height: height,
                      width: width,
                      fit: fit ?? BoxFit.cover,
                    );
              },
            );
          } on Exception catch (e) {
            log('🔥 Exception rendering CachedNetworkImage: $e');
            return placeHolderWidget ??
                Image.asset(
                  placeHolder,
                  height: height,
                  width: width,
                  fit: fit ?? BoxFit.cover,
                );
          }
        case ImageType.png:
          return Image.asset(
            imagePath!,
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
            color: color,
            opacity: AlwaysStoppedAnimation(opacity),
          );
        default:
          return placeHolderWidget ??
              Image.asset(
                placeHolder,
                height: height,
                width: width,
                fit: fit ?? BoxFit.cover,
              );
      }
    }
    return placeHolderWidget ??
        Image.asset(
          placeHolder,
          height: height,
          width: width,
          fit: fit ?? BoxFit.cover,
        );
  }
}

extension ImageTypeExtension on String {
  ImageType get imageType {
    if (startsWith('http') || startsWith('https')) {
      return ImageType.network;
    } else if (endsWith('.svg')) {
      return ImageType.svg;
    } else if (contains(CustomImageView.namePackage)) {
      return ImageType.file;
    } else {
      return ImageType.png;
    }
  }
}

enum ImageType { svg, png, network, file, unknown }
