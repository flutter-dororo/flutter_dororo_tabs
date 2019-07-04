// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// from Material/TabBar, this package only use Cupertino
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dororo_tabs/src/dororo_tab_theme/dororo_tab_bar_theme.dart';

// init tabHeight
const double _KTabHeight = 46.0;
const double _kTextAndIconTabHeight = 72.0;

/// Defines how the bounds of the selected tab indicator are computed.
///
/// See also:
///
///  * [DororoTabBar], which displays a row of tabs.
///  * [DororoTabBarView], which displays a widget for the currently selected tab.
///  * [DororoTabBar.indicator], which defines the appearance of the selected tab
///    indicator relative to the tab's bounds.
enum DororoTabBarIndicatorSize {
  /// The tab indicator's bounds are as wide as the space occupied by the tab
  /// in the tab bar: from the right edge of the previous tab to the left edge
  /// of the next tab.
  tab,

  /// The tab's bounds are only as wide as the (centered) tab widget itself.
  ///
  /// This value is used to align the tab's label, typically a [DororoTab]
  /// widget's text or icon, with the selected tab indicator.
  label,
}

// 生成DororoTab
class DororoTab extends StatelessWidget {
  const DororoTab({
    Key key,
    this.text,
    this.icon,
    this.child,
  })  : assert(text != null || child != null || icon != null),
        assert(!(text != null && null != child)),
        super(key: key);

  final String text;

  final Widget child;

  final Widget icon;

  // 构建字体
  Widget _buildLabelText() {
    return child ??
        Text(
          text,
          softWrap: false,
          overflow: TextOverflow.fade,
        );
  }

  @override
  Widget build(BuildContext context) {
    /// 去掉对materialApp的检测做魔改
    /// assert(debugCheckHasMaterial(context));

    double height;
    Widget label;
    // 判断icon是否为空
    if (icon == null) {
      // 如果为空则创建一个文字标签
      height = _KTabHeight;
      label = _buildLabelText();
    } else if (text == null && child == null) {
      // 如果icon不为空, 其他两个为空, 就创建一个icon Widget
      height = _KTabHeight;
      label = icon;
    } else {
      // 最后一种情况就是既有icon && text
      height = _kTextAndIconTabHeight;
      label = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: icon,
            margin: const EdgeInsets.only(bottom: 10.0),
          ),
          _buildLabelText(),
        ],
      );
    }

    // 最后返回一个SizeBox
    return SizedBox(
      height: height,
      child: Center(
        child: label,
        widthFactor: 1.0,
      ),
    );
  }

  ///
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('text', text, defaultValue: null));
    properties
        .add(DiagnosticsProperty<Widget>('icon', icon, defaultValue: null));
  }
}

//
class _DororoTabStyle extends AnimatedWidget {
  const _DororoTabStyle({
    Key key,
    Animation<double> animation,
    this.selected,
    this.labelColor,
    this.unselectedLabelColor,
    this.labelStyle,
    this.unselectedLabelStyle,
    @required this.child,
  }) : super(key: key, listenable: animation);

  final TextStyle labelStyle;
  final TextStyle unselectedLabelStyle;
  final bool selected;
  final Color labelColor;
  final Color unselectedLabelColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final DororoTabBarTheme dororoTabBarTheme = DororoTabBarTheme.of(context);
    final Animation<double> animation = listenable;

    final TextStyle defaultStyle = (labelStyle ??
            dororoTabBarTheme.labelStyle ??
            themeData.primaryTextTheme.body2)
        .copyWith(inherit: true);

    final TextStyle defaultUnselectedStyle = (unselectedLabelStyle ??
        dororoTabBarTheme.unselectedLabelStyle ??
        labelStyle ??
        themeData.primaryTextTheme.body2);

    final TextStyle textStyle = selected
        ? TextStyle.lerp(defaultStyle, defaultUnselectedStyle, animation.value)
        : TextStyle.lerp(defaultUnselectedStyle, defaultStyle, animation.value);

    final Color selectedColor = labelColor ?? dororoTabBarTheme.labelColor ?? themeData.primaryTextTheme.body2.color;

    return null;
  }
}

class DororoTabBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _DororoTabBarState createState() => new _DororoTabBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize {
    return Size.fromHeight(20 * 2.0);
  }
}

class _DororoTabBarState extends State<DororoTabBar> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Text('xxx111x'),
    );
  }
}
