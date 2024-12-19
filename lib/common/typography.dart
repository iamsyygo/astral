import 'package:flutter/material.dart';

/// 应用的排版样式配置，统一管理应用内的文字样式,便于维护和保持一致性
/// 使用示例:
/// ```dart
/// Text(
///   '示例文字',
///   style: AppTypography.heading1, // 直接使用预定义样式
/// )
///
/// // 或者基于预定义样式自定义
/// Text(
///   '示例文字',
///   style: AppTypography.heading1.copyWith(
///     color: Colors.blue, // 修改颜色
///     fontSize: 28.0, // 修改字号
///   ),
/// )
///
/// // 使用响应式字号
/// Text(
///   '示例文字',
///   style: AppTypography.heading1.copyWith(
///     fontSize: ResponsiveTextUtils.getResponsiveFontSize(context, AppTypography.heading1.fontSize!),
///   ),
/// )
/// ```
class AppTypography {
  // 主题色配置,用于特殊强调文字
  static const Color primaryTextColor = Color(0xFF333333);
  static const Color secondaryTextColor = Color(0xFF666666);
  static const Color captionTextColor = Color(0xFF999999);

  /// 标题样式系列 h1
  static const TextStyle heading1 = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w600,
    height: 1.3,
    color: primaryTextColor,
    letterSpacing: -0.5,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w500,
    height: 1.3,
    color: primaryTextColor,
  );

  static const TextStyle heading3 = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: primaryTextColor,
  );

  /// 正文样式系列 bodyLarge
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: primaryTextColor,
  );

  /// 正文样式系列 bodyMedium
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: secondaryTextColor,
  );

  /// 辅助文字样式 caption
  static const TextStyle caption = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: captionTextColor,
  );

  /// 按钮文字样式 button
  static const TextStyle button = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    height: 1.0,
    letterSpacing: 0.5,
  );

  /// 表单输入框文字样式 input
  static const TextStyle input = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: primaryTextColor,
  );

  /// 导航栏标题样式 appBarTitle
  static const TextStyle appBarTitle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    height: 1.3,
    color: primaryTextColor,
  );

  /// 标签文字样式 tag
  static const TextStyle tag = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    height: 1.0,
    letterSpacing: 0.2,
  );
}

// 响应式字体大小计算工具
class ResponsiveTextUtils {
  static double getResponsiveFontSize(BuildContext context, double fontSize) {
    // 获取屏幕宽度
    double screenWidth = MediaQuery.of(context).size.width;

    // 基准屏幕宽度(以iPhone 12为例)
    const double baseWidth = 375.0;

    // 计算缩放比例
    double scaleFactor = screenWidth / baseWidth;

    // 限制最大最小缩放范围
    double scale = scaleFactor.clamp(0.8, 1.2);

    return fontSize * scale;
  }
}
