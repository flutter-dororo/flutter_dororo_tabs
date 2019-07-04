import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dororo_tabs/src/dororo_tab_theme/dororo_tab_theme_data.dart';

class DororoTheme extends StatelessWidget {

  const DororoTheme({
    Key key,
    this.isCupertinoAppTheme = false,
    @required this.data,
    @required this.child,
  }): assert(child != null),
  assert(data != null),
  super(key: key);

  final DororoCupertinoThemeData data;

  final bool isCupertinoAppTheme;

  final Widget child;

  static final DororoCupertinoThemeData _kFallbackTheme = DororoCupertinoThemeData.fallback();

  static DororoCupertinoThemeData of(BuildContext context, { bool shadowThemeOnly = false }) {
    final _InheritedDororoCupertinoTheme inheritedTheme = context.inheritFromWidgetOfExactType(_InheritedDororoCupertinoTheme);
    if (shadowThemeOnly) {
      if (inheritedTheme == null || inheritedTheme.theme.isCupertinoAppTheme)
        return null;
      return inheritedTheme.theme.data;
    }

    final MaterialLocalizations localizations = MaterialLocalizations.of(context);
    final ScriptCategory category = localizations?.scriptCategory ?? ScriptCategory.englishLike;
    final DororoCupertinoThemeData theme = inheritedTheme?.theme?.data ?? _kFallbackTheme;
    return DororoCupertinoThemeData.localize(theme, theme.typography.geometryThemeFor(category));
  }


  @override
  Widget build(BuildContext context) {
    return _InheritedDororoCupertinoTheme(
      theme: this,
      child: DororoTheme(
        data: DororoCupertinoThemeData(),
        child: IconTheme(
          data: data.iconTheme,
          child: child,
        ),
      )
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<DororoCupertinoThemeData>('data', data, showName: false));
  }
}


class _InheritedDororoCupertinoTheme extends InheritedWidget {
  const _InheritedDororoCupertinoTheme({
    Key key,
    @required this.theme,
    @required Widget child,
  })  : assert(theme != null),
        super(key: key, child: child);

  final DororoTheme theme;

  @override
  bool updateShouldNotify(_InheritedDororoCupertinoTheme old) =>
      theme.data != old.theme.data;
}
