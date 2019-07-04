/// DororoTabBarTheme
import 'package:flutter/cupertino.dart';
import 'dart:ui' show Color, hashValues;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../dororo_tabs.dart';
import 'package:flutter_dororo_tabs/src/dororo_tab_theme/dororo_theme.dart';


/// Defines a theme for [TabBar] widgets.
///
/// A tab bar theme describes the color of the tab label and the size/shape of
/// the [TabBar.indicator].
///
/// Descendant widgets obtain the current theme's [TabBarTheme] object using
/// `TabBarTheme.of(context)`. Instances of [TabBarTheme] can be customized with
/// [TabBarTheme.copyWith].
///
/// See also:
///
///  * [TabBar], a widget that displays a horizontal row of tabs.
///  * [ThemeData], which describes the overall theme information for the
///    application.

class DororoTabBarTheme extends Diagnosticable {
  const DororoTabBarTheme({
    this.indicator,
    this.indicatorSize,
    this.labelColor,
    this.labelPadding,
    this.labelStyle,
    this.unselectedLabelColor,
    this.unselectedLabelStyle,
  });

  /// Default value for [DororoTabBar.indicator]
  final Decoration indicator;

  /// Default value for [TabBar.indicatorSize].
  final DororoTabBarIndicatorSize indicatorSize;

  /// Default value for [TabBar.labelColor].
  final Color labelColor;

  /// Default value for [TabBar.labelPadding].
  final EdgeInsetsGeometry labelPadding;

  /// Default value for [TabBar.labelStyle].
  final TextStyle labelStyle;

  /// Default value for [TabBar.unselectedLabelColor].
  final Color unselectedLabelColor;

  /// Default value for [TabBar.unselectedLabelStyle].
  final TextStyle unselectedLabelStyle;

  DororoTabBarTheme copyWith({
    Decoration indicator,
    DororoTabBarIndicatorSize indicatorSize,
    Color labelColor,
    EdgeInsetsGeometry labelPadding,
    TextStyle labelStyle,
    Color unselectedLabelColor,
    TextStyle unselectedLabelStyle,
  }) {
    return DororoTabBarTheme(
      indicator: indicator ?? this.indicator,
      indicatorSize: indicatorSize ?? this.indicatorSize,
      labelColor: labelColor ?? this.labelColor,
      labelPadding: labelPadding ?? this.labelPadding,
      labelStyle: labelStyle ?? this.labelStyle,
      unselectedLabelColor: unselectedLabelColor ?? this.unselectedLabelColor,
      unselectedLabelStyle: unselectedLabelStyle ?? this.unselectedLabelStyle,
    );
  }

  static DororoTabBarTheme of(BuildContext context) {
    return DororoTheme.of(context).dororoTabBarTheme;
  }

  static DororoTabBarTheme lerp(
      DororoTabBarTheme a, DororoTabBarTheme b, double t) {
    assert(a != null);
    assert(b != null);
    assert(t != null);
    return DororoTabBarTheme(
      indicator: Decoration.lerp(a.indicator, b.indicator, t),
      indicatorSize: t < 0.5 ? a.indicatorSize : b.indicatorSize,
      labelColor: Color.lerp(a.labelColor, b.labelColor, t),
      labelPadding: EdgeInsets.lerp(a.labelPadding, b.labelPadding, t),
      labelStyle: TextStyle.lerp(a.labelStyle, b.labelStyle, t),
      unselectedLabelColor:
          Color.lerp(a.unselectedLabelColor, b.unselectedLabelColor, t),
      unselectedLabelStyle:
          TextStyle.lerp(a.unselectedLabelStyle, b.unselectedLabelStyle, t),
    );
  }

  @override
  int get hashCode {
    return hashValues(
      indicator,
      indicatorSize,
      labelColor,
      labelPadding,
      labelStyle,
      unselectedLabelColor,
      unselectedLabelStyle,
    );
  }

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    final DororoTabBarTheme typedOther = other;
    return typedOther.indicator == indicator &&
        typedOther.indicatorSize == indicatorSize &&
        typedOther.labelColor == labelColor &&
        typedOther.labelPadding == labelPadding &&
        typedOther.labelStyle == labelStyle &&
        typedOther.unselectedLabelColor == unselectedLabelColor &&
        typedOther.unselectedLabelStyle == unselectedLabelStyle;
  }

}
