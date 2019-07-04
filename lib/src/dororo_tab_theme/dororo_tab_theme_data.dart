import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dororo_tab_bar_theme.dart';

/// 需要返回自定的themeData
@immutable
class DororoCupertinoThemeData extends Diagnosticable {
  factory DororoCupertinoThemeData({
    DororoTabBarTheme dororoTabBarTheme,
    Brightness brightness,
    IconThemeData iconTheme,
    Typography typography,
    TargetPlatform platform,
  }) {
    brightness ??= Brightness.light;
    final bool isDark = brightness == Brightness.dark;
    dororoTabBarTheme ??= const DororoTabBarTheme();
    iconTheme ??= isDark ? const IconThemeData(color: Colors.white) : const IconThemeData(color: Colors.black87);
    platform ??= defaultTargetPlatform;
    typography ??= Typography(platform: platform);
    return DororoCupertinoThemeData.raw(
      brightness: brightness,
      dororoTabBarTheme: dororoTabBarTheme,
      iconTheme: iconTheme,
      platform: platform,
      typography: typography,
    );
  }

  const DororoCupertinoThemeData.raw({
    @required this.brightness,
    @required this.dororoTabBarTheme,
    @required this.platform,
    @required this.iconTheme,
    @required this.typography,
  })  : assert(brightness != null),
        assert(dororoTabBarTheme != null),
        assert(iconTheme != null),
        assert(platform != null),
        assert(typography != null);


  /// defined
  final Brightness brightness;

  final TargetPlatform platform;

  final DororoTabBarTheme dororoTabBarTheme;

  final IconThemeData iconTheme;

  final Typography typography;

  factory DororoCupertinoThemeData.light() =>
      DororoCupertinoThemeData(brightness: Brightness.light);

  factory DororoCupertinoThemeData.fallback() =>
      DororoCupertinoThemeData.light();

  DororoCupertinoThemeData copyWith({
    Brightness brightness,
    DororoTabBarTheme dororoTabBarTheme,
    IconThemeData iconTheme,
    TargetPlatform platform,
    Typography typography,
  }) {
    return DororoCupertinoThemeData.raw(
      brightness: brightness ?? this.brightness,
      iconTheme: iconTheme ?? this.iconTheme,
      dororoTabBarTheme: dororoTabBarTheme ?? this.dororoTabBarTheme,
      platform: platform ?? this.platform,
      typography: typography ?? this.typography,
    );
  }

  static const int _localizedThemeDataCacheSize = 5;

  static final _FifoCache<_IdentityThemeDataCacheKey, DororoCupertinoThemeData>
      _localizedThemeDataCache =
      _FifoCache<_IdentityThemeDataCacheKey, DororoCupertinoThemeData>(
          _localizedThemeDataCacheSize);

  static DororoCupertinoThemeData localize(
      DororoCupertinoThemeData baseTheme, TextTheme localTextGeometry) {
    assert(baseTheme != null);
    assert(localTextGeometry != null);

    return _localizedThemeDataCache.putIfAbsent(
      _IdentityThemeDataCacheKey(baseTheme, localTextGeometry),
      () {
        return baseTheme.copyWith(
          dororoTabBarTheme: baseTheme.dororoTabBarTheme,
          brightness: baseTheme.brightness,
        );
      },
    );
  }

  static DororoCupertinoThemeData lerp(
      DororoCupertinoThemeData a, DororoCupertinoThemeData b, double t) {
    assert(a != null);
    assert(b != null);
    assert(t != null);

    return DororoCupertinoThemeData.raw(
      brightness: t < 0.5 ? a.brightness : b.brightness,
      iconTheme: IconThemeData.lerp(a.iconTheme, b.iconTheme, t),
      platform: t < 0.5 ? a.platform : b.platform,
      typography: Typography.lerp(a.typography, b.typography, t),
      dororoTabBarTheme:
          DororoTabBarTheme.lerp(a.dororoTabBarTheme, b.dororoTabBarTheme, t),
    );
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    final DororoCupertinoThemeData otherData = other;

    return (otherData.dororoTabBarTheme == dororoTabBarTheme) && (otherData.platform == platform) && (otherData.iconTheme == iconTheme) && (otherData.typography == typography);
  }

  @override
  int get hashCode {
    return hashValues(
      brightness,
      hashValues(
        iconTheme,
        hashValues(
          dororoTabBarTheme,
          platform,
          typography,
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    final DororoCupertinoThemeData defaultData =
        DororoCupertinoThemeData.fallback();
    properties.add(EnumProperty<TargetPlatform>('platform', platform, defaultValue: defaultTargetPlatform));
    properties.add(EnumProperty<Brightness>('brightness', brightness,
        defaultValue: defaultData.brightness));
    properties.add(DiagnosticsProperty<DororoTabBarTheme>(
        'dororoTabBarTheme', dororoTabBarTheme));
    properties.add(DiagnosticsProperty<IconThemeData>('iconTheme', iconTheme));
    properties.add(DiagnosticsProperty<Typography>('typography', typography, defaultValue: defaultData.typography));

  }
}

class _IdentityThemeDataCacheKey {
  _IdentityThemeDataCacheKey(this.baseTheme, this.localTextGeometry);

  final DororoCupertinoThemeData baseTheme;
  final TextTheme localTextGeometry;

  // Using XOR to make the hash function as fast as possible (e.g. Jenkins is
  // noticeably slower).
  @override
  int get hashCode =>
      identityHashCode(baseTheme) ^ identityHashCode(localTextGeometry);

  @override
  bool operator ==(Object other) {
    // We are explicitly ignoring the possibility that the types might not
    // match in the interests of speed.
    final _IdentityThemeDataCacheKey otherKey = other;
    return identical(baseTheme, otherKey.baseTheme) &&
        identical(localTextGeometry, otherKey.localTextGeometry);
  }
}

class _FifoCache<K, V> {
  _FifoCache(this._maximumSize)
      : assert(_maximumSize != null && _maximumSize > 0);

  /// In Dart the map literal uses a linked hash-map implementation, whose keys
  /// are stored such that [Map.keys] returns them in the order they were
  /// inserted.
  final Map<K, V> _cache = <K, V>{};

  /// Maximum number of entries to store in the cache.
  ///
  /// Once this many entries have been cached, the entry inserted least recently
  /// is evicted when adding a new entry.
  final int _maximumSize;

  /// Returns the previously cached value for the given key, if available;
  /// if not, calls the given callback to obtain it first.
  ///
  /// The arguments must not be null.
  V putIfAbsent(K key, V loader()) {
    assert(key != null);
    assert(loader != null);
    final V result = _cache[key];
    if (result != null) return result;
    if (_cache.length == _maximumSize) _cache.remove(_cache.keys.first);
    return _cache[key] = loader();
  }
}
