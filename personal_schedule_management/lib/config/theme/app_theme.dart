import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AppTheme extends ChangeNotifier {
  static AppTheme of(BuildContext context, {bool listen = false}) =>
      Provider.of<AppTheme>(context, listen: listen);

  static const DEFAULT = 'Default';
  static const ELECTRIC_VIOLET = 'Electric Violet';
  static const HIPPIE_BLUE = 'Hippe Blue';
  static const GREEN_FOREST = 'Green Forest';
  static const SAKURA = 'Sakura';
  static const RED_WINE = 'Red Wine';
  static const GOLD_SUNSET = 'Gold Sunset';
  static const BLUE_DELIGHT = 'Blue Delight';

  static ColorScheme _lightColorScheme = SchemeLight_default;
  static ColorScheme _darkColorScheme = SchemeDark_default;
  static bool _darkMode = false;

  static get lightColorScheme => _lightColorScheme;
  static get darkColorScheme => _darkColorScheme;
  static get IsDarkMode => _darkMode;
  get darkMode => _darkMode;

  static ThemeData CreateThemeData(ColorScheme colorScheme) {
    return ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        textTheme: GoogleFonts.robotoTextTheme().copyWith(
          bodySmall: GoogleFonts.robotoTextTheme().bodySmall?.copyWith(
            color: colorScheme.onSurface
          )
        ),
        timePickerTheme: TimePickerThemeData().copyWith(
          helpTextStyle: TextStyle(color: colorScheme.onBackground),
        )
    );
  }

  void ReloadThemeData() {
    _lightTheme = CreateThemeData(_lightColorScheme);
    _darkTheme = CreateThemeData(_darkColorScheme);
  }

  ThemeData _lightTheme = CreateThemeData(SchemeLight_default);
  ThemeData _darkTheme = CreateThemeData(SchemeDark_default);
  get lightTheme => _lightTheme;
  get darkTheme => _darkTheme;

  void LoadAppTheme(String? AppThemeName) {
    switch (AppThemeName)
    {
      case AppTheme.DEFAULT:
        SetTheme_Default();
        break;
      case AppTheme.ELECTRIC_VIOLET:
        SetTheme_ElectricViolet();
        break;
      case AppTheme.BLUE_DELIGHT:
        SetTheme_BlueDelight();
        break;
      case AppTheme.HIPPIE_BLUE:
        SetTheme_HippieBlue();
        break;
      case AppTheme.GOLD_SUNSET:
        SetTheme_GoldSunset();
        break;
      case AppTheme.GREEN_FOREST:
        SetTheme_GreenForest();
        break;
      case AppTheme.RED_WINE:
        SetTheme_RedWine();
        break;
      case AppTheme.SAKURA:
        SetTheme_Sakura();
        break;
      default:
        SetTheme_Default();
    }
  }

  // SET THEMES
  void SetTheme_Default() {
    _lightColorScheme = SchemeLight_default;
    _darkColorScheme = SchemeDark_default;
    ReloadThemeData();
    notifyListeners();
  }

  void SetTheme_ElectricViolet() {
    _lightColorScheme = SchemeLight_ElectricViolet;
    _darkColorScheme = SchemeDark_ElectricViolet;
    ReloadThemeData();
    notifyListeners();
  }

  void SetTheme_BlueDelight() {
    _lightColorScheme = SchemeLight_BlueDelight;
    _darkColorScheme = SchemeDark_BlueDelight;
    ReloadThemeData();
    notifyListeners();
  }

  void SetTheme_GoldSunset() {
    _lightColorScheme = SchemeLight_GoldSunset;
    _darkColorScheme = SchemeDark_GoldSunset;
    ReloadThemeData();
    notifyListeners();
  }

  void SetTheme_HippieBlue() {
    _lightColorScheme = SchemeLight_HippieBlue;
    _darkColorScheme = SchemeDark_HippieBlue;
    ReloadThemeData();
    notifyListeners();
  }

  void SetTheme_GreenForest() {
    _lightColorScheme = SchemeLight_GreenForest;
    _darkColorScheme = SchemeDark_GreenForest;
    ReloadThemeData();
    notifyListeners();
  }

  void SetTheme_RedWine() {
    _lightColorScheme = SchemeLight_RedWine;
    _darkColorScheme = SchemeDark_RedWine;
    ReloadThemeData();
    notifyListeners();
  }

  void SetTheme_Sakura() {
    _lightColorScheme = SchemeLight_Sakura;
    _darkColorScheme = SchemeDark_Sakura;
    ReloadThemeData();
    notifyListeners();
  }

  void ToggleDarkMode() {
    _darkMode = !_darkMode;
    notifyListeners();
  }
}

const SchemeLight_default = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF006C4A),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFF8AF8C5),
  onPrimaryContainer: Color(0xFF002114),
  secondary: Color(0xFF4D6357),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFCFE9D9),
  onSecondaryContainer: Color(0xFF0A1F16),
  tertiary: Color(0xFF3D6473),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFC1E9FB),
  onTertiaryContainer: Color(0xFF001F29),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFBFDF9),
  onBackground: Color(0xFF191C1A),
  surface: Color(0xFFFBFDF9),
  onSurface: Color(0xFF191C1A),
  surfaceVariant: Color(0xFFDCE5DD),
  onSurfaceVariant: Color(0xFF404943),
  outline: Color(0xFF707973),
  onInverseSurface: Color(0xFFEFF1ED),
  inverseSurface: Color(0xFF2E312F),
  inversePrimary: Color(0xFF6DDBAA),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF006C4A),
  outlineVariant: Color(0xFFBFC9C1),
  scrim: Color(0xFF000000),
);

const SchemeDark_default = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF6DDBAA),
  onPrimary: Color(0xFF003825),
  primaryContainer: Color(0xFF005137),
  onPrimaryContainer: Color(0xFF8AF8C5),
  secondary: Color(0xFFB4CCBD),
  onSecondary: Color(0xFF1F352A),
  secondaryContainer: Color(0xFF364B40),
  onSecondaryContainer: Color(0xFFCFE9D9),
  tertiary: Color(0xFFA5CCDE),
  onTertiary: Color(0xFF073543),
  tertiaryContainer: Color(0xFF244C5A),
  onTertiaryContainer: Color(0xFFC1E9FB),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF191C1A),
  onBackground: Color(0xFFE1E3DF),
  surface: Color(0xFF191C1A),
  onSurface: Color(0xFFE1E3DF),
  surfaceVariant: Color(0xFF404943),
  onSurfaceVariant: Color(0xFFBFC9C1),
  outline: Color(0xFF8A938C),
  onInverseSurface: Color(0xFF191C1A),
  inverseSurface: Color(0xFFE1E3DF),
  inversePrimary: Color(0xFF006C4A),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF6DDBAA),
  outlineVariant: Color(0xFF404943),
  scrim: Color(0xFF000000),
);

class ColorPalette {
  static const Color onselectedColor = Color(0xff3399FF);
}

class Gradients {
  static const Gradient defaultGradientBackground = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.white,
      Colors.lightGreenAccent,
    ],
  );
}

// COLOR SCHEMES PACK
const ColorScheme SchemeLight_ElectricViolet = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xff6d23f9),
  onPrimary: Color(0xffffffff),
  primaryContainer: Color(0xffe8ddff),
  onPrimaryContainer: Color(0xff22005d),
  secondary: Color(0xff625b71),
  onSecondary: Color(0xffffffff),
  secondaryContainer: Color(0xffe8def8),
  onSecondaryContainer: Color(0xff1e192b),
  tertiary: Color(0xff7d5260),
  onTertiary: Color(0xffffffff),
  tertiaryContainer: Color(0xffffd9e3),
  onTertiaryContainer: Color(0xff31101d),
  error: Color(0xffba1a1a),
  onError: Color(0xffffffff),
  errorContainer: Color(0xffffdad6),
  onErrorContainer: Color(0xff410002),
  background: Color(0xfffaf5fe),
  onBackground: Color(0xff1c1b1e),
  surface: Color(0xfffaf5fe),
  onSurface: Color(0xff1c1b1e),
  surfaceVariant: Color(0xffe3daec),
  onSurfaceVariant: Color(0xff49454e),
  outline: Color(0xff7a757f),
  outlineVariant: Color(0xffcac4cf),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xff322f38),
  onInverseSurface: Color(0xfff4eff4),
  inversePrimary: Color(0xffcfbdff),
  surfaceTint: Color(0xff6d23f9),
);

const ColorScheme SchemeDark_ElectricViolet = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xffcfbdff),
  onPrimary: Color(0xff3a0093),
  primaryContainer: Color(0xff5300cd),
  onPrimaryContainer: Color(0xffe8ddff),
  secondary: Color(0xffcbc2dc),
  onSecondary: Color(0xff332d41),
  secondaryContainer: Color(0xff4a4458),
  onSecondaryContainer: Color(0xffe8def8),
  tertiary: Color(0xffefb8c8),
  onTertiary: Color(0xff4a2532),
  tertiaryContainer: Color(0xff633b49),
  onTertiaryContainer: Color(0xffffd9e3),
  error: Color(0xffffb4ab),
  onError: Color(0xff690005),
  errorContainer: Color(0xff93000a),
  onErrorContainer: Color(0xffffb4ab),
  background: Color(0xff252329),
  onBackground: Color(0xffe6e1e6),
  surface: Color(0xff252329),
  onSurface: Color(0xffe6e1e6),
  surfaceVariant: Color(0xff4f4b57),
  onSurfaceVariant: Color(0xffcac4cf),
  outline: Color(0xff948f99),
  outlineVariant: Color(0xff49454e),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xffe4dfe7),
  onInverseSurface: Color(0xff313033),
  inversePrimary: Color(0xff6d23f9),
  surfaceTint: Color(0xffcfbdff),
);

const ColorScheme SchemeLight_HippieBlue = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xff006783),
  onPrimary: Color(0xffffffff),
  primaryContainer: Color(0xffbce9ff),
  onPrimaryContainer: Color(0xff001f29),
  secondary: Color(0xff4d616b),
  onSecondary: Color(0xffffffff),
  secondaryContainer: Color(0xffd0e6f2),
  onSecondaryContainer: Color(0xff081e27),
  tertiary: Color(0xff5c5b7d),
  onTertiary: Color(0xffffffff),
  tertiaryContainer: Color(0xffe2dfff),
  onTertiaryContainer: Color(0xff191836),
  error: Color(0xffba1a1a),
  onError: Color(0xffffffff),
  errorContainer: Color(0xffffdad6),
  onErrorContainer: Color(0xff410002),
  background: Color(0xfff4f7fa),
  onBackground: Color(0xff191c1e),
  surface: Color(0xfff4f7fa),
  onSurface: Color(0xff191c1e),
  surfaceVariant: Color(0xffd5e0e6),
  onSurfaceVariant: Color(0xff40484c),
  outline: Color(0xff70787d),
  outlineVariant: Color(0xffc0c8cd),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xff2c3234),
  onInverseSurface: Color(0xffeff1f3),
  inversePrimary: Color(0xff62d4ff),
  surfaceTint: Color(0xff006783),
);

const ColorScheme SchemeDark_HippieBlue = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xff62d4ff),
  onPrimary: Color(0xff003545),
  primaryContainer: Color(0xff004d63),
  onPrimaryContainer: Color(0xffbce9ff),
  secondary: Color(0xffb4cad5),
  onSecondary: Color(0xff1e333c),
  secondaryContainer: Color(0xff354a53),
  onSecondaryContainer: Color(0xffd0e6f2),
  tertiary: Color(0xffc5c3ea),
  onTertiary: Color(0xff2e2d4d),
  tertiaryContainer: Color(0xff444364),
  onTertiaryContainer: Color(0xffe2dfff),
  error: Color(0xffffb4ab),
  onError: Color(0xff690005),
  errorContainer: Color(0xff93000a),
  onErrorContainer: Color(0xffffb4ab),
  background: Color(0xff1c2529),
  onBackground: Color(0xffe1e2e4),
  surface: Color(0xff1c2529),
  onSurface: Color(0xffe1e2e4),
  surfaceVariant: Color(0xff414f55),
  onSurfaceVariant: Color(0xffc0c8cd),
  outline: Color(0xff8a9296),
  outlineVariant: Color(0xff40484c),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xffdae1e5),
  onInverseSurface: Color(0xff2e3132),
  inversePrimary: Color(0xff006783),
  surfaceTint: Color(0xff62d4ff),
);

const ColorScheme SchemeLight_GreenForest = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xff1b6d24),
  onPrimary: Color(0xffffffff),
  primaryContainer: Color(0xffb7f1ae),
  onPrimaryContainer: Color(0xff002204),
  secondary: Color(0xff52634f),
  onSecondary: Color(0xffffffff),
  secondaryContainer: Color(0xffd6e8ce),
  onSecondaryContainer: Color(0xff111f0f),
  tertiary: Color(0xff38656a),
  onTertiary: Color(0xffffffff),
  tertiaryContainer: Color(0xffbcebf0),
  onTertiaryContainer: Color(0xff002023),
  error: Color(0xffba1a1a),
  onError: Color(0xffffffff),
  errorContainer: Color(0xffffdad6),
  onErrorContainer: Color(0xff410002),
  background: Color(0xfff5f9f0),
  onBackground: Color(0xff1a1c19),
  surface: Color(0xfff5f9f0),
  onSurface: Color(0xff1a1c19),
  surfaceVariant: Color(0xffd8e1d3),
  onSurfaceVariant: Color(0xff424940),
  outline: Color(0xff72796f),
  outlineVariant: Color(0xffc2c9bd),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xff2e322c),
  onInverseSurface: Color(0xfff0f1eb),
  inversePrimary: Color(0xff88d982),
  surfaceTint: Color(0xff1b6d24),
);

const ColorScheme SchemeDark_GreenForest = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xff88d982),
  onPrimary: Color(0xff003909),
  primaryContainer: Color(0xff005312),
  onPrimaryContainer: Color(0xffb7f1ae),
  secondary: Color(0xffbaccb3),
  onSecondary: Color(0xff253423),
  secondaryContainer: Color(0xff3b4b38),
  onSecondaryContainer: Color(0xffd6e8ce),
  tertiary: Color(0xffa0cfd4),
  onTertiary: Color(0xff00363b),
  tertiaryContainer: Color(0xff1f4d52),
  onTertiaryContainer: Color(0xffbcebf0),
  error: Color(0xffffb4ab),
  onError: Color(0xff690005),
  errorContainer: Color(0xff93000a),
  onErrorContainer: Color(0xffffb4ab),
  background: Color(0xff1f251e),
  onBackground: Color(0xffe2e3dd),
  surface: Color(0xff1f251e),
  onSurface: Color(0xffe2e3dd),
  surfaceVariant: Color(0xff455043),
  onSurfaceVariant: Color(0xffc2c9bd),
  outline: Color(0xff8c9388),
  outlineVariant: Color(0xff424940),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xffdde2d8),
  onInverseSurface: Color(0xff2f312d),
  inversePrimary: Color(0xff1b6d24),
  surfaceTint: Color(0xff88d982),
);

const ColorScheme SchemeLight_Sakura = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xffa23956),
  onPrimary: Color(0xffffffff),
  primaryContainer: Color(0xffffd9df),
  onPrimaryContainer: Color(0xff3f0016),
  secondary: Color(0xff75565c),
  onSecondary: Color(0xffffffff),
  secondaryContainer: Color(0xffffd9df),
  onSecondaryContainer: Color(0xff2b151a),
  tertiary: Color(0xff7a5732),
  onTertiary: Color(0xffffffff),
  tertiaryContainer: Color(0xffffdcbc),
  onTertiaryContainer: Color(0xff2c1700),
  error: Color(0xffba1a1a),
  onError: Color(0xffffffff),
  errorContainer: Color(0xffffdad6),
  onErrorContainer: Color(0xff410002),
  background: Color(0xfffcf5fa),
  onBackground: Color(0xff201a1b),
  surface: Color(0xfffcf5fa),
  onSurface: Color(0xff201a1b),
  surfaceVariant: Color(0xfff0d8dc),
  onSurfaceVariant: Color(0xff524345),
  outline: Color(0xff847375),
  outlineVariant: Color(0xffd6c2c4),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xff372f31),
  onInverseSurface: Color(0xfffaeeee),
  inversePrimary: Color(0xffffb1c0),
  surfaceTint: Color(0xffa23956),
);

const ColorScheme SchemeDark_Sakura = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xffffb1c0),
  onPrimary: Color(0xff640529),
  primaryContainer: Color(0xff83213f),
  onPrimaryContainer: Color(0xffffd9df),
  secondary: Color(0xffe4bdc3),
  onSecondary: Color(0xff43292e),
  secondaryContainer: Color(0xff5b3f44),
  onSecondaryContainer: Color(0xffffd9df),
  tertiary: Color(0xffecbe91),
  onTertiary: Color(0xff462a08),
  tertiaryContainer: Color(0xff5f401d),
  onTertiaryContainer: Color(0xffffdcbc),
  error: Color(0xffffb4ab),
  onError: Color(0xff690005),
  errorContainer: Color(0xff93000a),
  onErrorContainer: Color(0xffffb4ab),
  background: Color(0xff2b2123),
  onBackground: Color(0xffece0e0),
  surface: Color(0xff2b2123),
  onSurface: Color(0xffece0e0),
  surfaceVariant: Color(0xff5a484b),
  onSurfaceVariant: Color(0xffd6c2c4),
  outline: Color(0xff9f8c8f),
  outlineVariant: Color(0xff524345),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xffecddde),
  onInverseSurface: Color(0xff352f30),
  inversePrimary: Color(0xffa23956),
  surfaceTint: Color(0xffffb1c0),
);

const ColorScheme SchemeLight_RedWine = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xffaf2b3d),
  onPrimary: Color(0xffffffff),
  primaryContainer: Color(0xffffdada),
  onPrimaryContainer: Color(0xff40000b),
  secondary: Color(0xff765657),
  onSecondary: Color(0xffffffff),
  secondaryContainer: Color(0xffffdada),
  onSecondaryContainer: Color(0xff2c1516),
  tertiary: Color(0xff76592f),
  onTertiary: Color(0xffffffff),
  tertiaryContainer: Color(0xffffddb1),
  onTertiaryContainer: Color(0xff291800),
  error: Color(0xffba1a1a),
  onError: Color(0xffffffff),
  errorContainer: Color(0xffffdad6),
  onErrorContainer: Color(0xff410002),
  background: Color(0xfffcf5f9),
  onBackground: Color(0xff201a1a),
  surface: Color(0xfffcf5f9),
  onSurface: Color(0xff201a1a),
  surfaceVariant: Color(0xfff2d8d8),
  onSurfaceVariant: Color(0xff524343),
  outline: Color(0xff857373),
  outlineVariant: Color(0xffd7c1c1),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xff392e2f),
  onInverseSurface: Color(0xfffbeeed),
  inversePrimary: Color(0xffffb3b5),
  surfaceTint: Color(0xffaf2b3d),
);

const ColorScheme SchemeDark_RedWine = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xffffb3b5),
  onPrimary: Color(0xff680018),
  primaryContainer: Color(0xff8e0f28),
  onPrimaryContainer: Color(0xffffdada),
  secondary: Color(0xffe6bdbd),
  onSecondary: Color(0xff44292a),
  secondaryContainer: Color(0xff5d3f40),
  onSecondaryContainer: Color(0xffffdada),
  tertiary: Color(0xffe6c18d),
  onTertiary: Color(0xff422c05),
  tertiaryContainer: Color(0xff5c421a),
  onTertiaryContainer: Color(0xffffddb1),
  error: Color(0xffffb4ab),
  onError: Color(0xff690005),
  errorContainer: Color(0xff93000a),
  onErrorContainer: Color(0xffffb4ab),
  background: Color(0xff2b2121),
  onBackground: Color(0xffece0df),
  surface: Color(0xff2b2121),
  onSurface: Color(0xffece0df),
  surfaceVariant: Color(0xff5a4848),
  onSurfaceVariant: Color(0xffd7c1c1),
  outline: Color(0xff9f8c8c),
  outlineVariant: Color(0xff524343),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xffecdddc),
  onInverseSurface: Color(0xff362f2f),
  inversePrimary: Color(0xffaf2b3d),
  surfaceTint: Color(0xffffb3b5),
);

const ColorScheme SchemeLight_GoldSunset = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xff8f4e00),
  onPrimary: Color(0xffffffff),
  primaryContainer: Color(0xffffdcc2),
  onPrimaryContainer: Color(0xff2e1500),
  secondary: Color(0xff745944),
  onSecondary: Color(0xffffffff),
  secondaryContainer: Color(0xffffdcc2),
  onSecondaryContainer: Color(0xff2a1707),
  tertiary: Color(0xff5b6237),
  onTertiary: Color(0xffffffff),
  tertiaryContainer: Color(0xffe0e7b1),
  onTertiaryContainer: Color(0xff191e00),
  error: Color(0xffba1a1a),
  onError: Color(0xffffffff),
  errorContainer: Color(0xffffdad6),
  onErrorContainer: Color(0xff410002),
  background: Color(0xfffbf6f8),
  onBackground: Color(0xff201b17),
  surface: Color(0xfffbf6f8),
  onSurface: Color(0xff201b17),
  surfaceVariant: Color(0xfff0dbcb),
  onSurfaceVariant: Color(0xff51443b),
  outline: Color(0xff847469),
  outlineVariant: Color(0xffd6c3b6),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xff372f29),
  onInverseSurface: Color(0xfffaeee8),
  inversePrimary: Color(0xffffb77b),
  surfaceTint: Color(0xff8f4e00),
);

const ColorScheme SchemeDark_GoldSunset = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xffffb77b),
  onPrimary: Color(0xff4c2700),
  primaryContainer: Color(0xff6d3a00),
  onPrimaryContainer: Color(0xffffdcc2),
  secondary: Color(0xffe3c0a5),
  onSecondary: Color(0xff412c19),
  secondaryContainer: Color(0xff5a422e),
  onSecondaryContainer: Color(0xffffdcc2),
  tertiary: Color(0xffc4cb97),
  onTertiary: Color(0xff2d330d),
  tertiaryContainer: Color(0xff444a22),
  onTertiaryContainer: Color(0xffe0e7b1),
  error: Color(0xffffb4ab),
  onError: Color(0xff690005),
  errorContainer: Color(0xff93000a),
  onErrorContainer: Color(0xffffb4ab),
  background: Color(0xff2b221c),
  onBackground: Color(0xffece0da),
  surface: Color(0xff2b221c),
  onSurface: Color(0xffece0da),
  surfaceVariant: Color(0xff59493e),
  onSurfaceVariant: Color(0xffd6c3b6),
  outline: Color(0xff9e8e82),
  outlineVariant: Color(0xff51443b),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xffecddd5),
  onInverseSurface: Color(0xff352f2b),
  inversePrimary: Color(0xff8f4e00),
  surfaceTint: Color(0xffffb77b),
);

const ColorScheme SchemeLight_BlueDelight = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xff005db7),
  onPrimary: Color(0xffffffff),
  primaryContainer: Color(0xffd6e3ff),
  onPrimaryContainer: Color(0xff001b3d),
  secondary: Color(0xff555f71),
  onSecondary: Color(0xffffffff),
  secondaryContainer: Color(0xffdae2f9),
  onSecondaryContainer: Color(0xff121c2b),
  tertiary: Color(0xff6f5575),
  onTertiary: Color(0xffffffff),
  tertiaryContainer: Color(0xfff9d8fd),
  onTertiaryContainer: Color(0xff28132f),
  error: Color(0xffba1a1a),
  onError: Color(0xffffffff),
  errorContainer: Color(0xffffdad6),
  onErrorContainer: Color(0xff410002),
  background: Color(0xfff6f6fd),
  onBackground: Color(0xff1a1b1e),
  surface: Color(0xfff6f6fd),
  onSurface: Color(0xff1a1b1e),
  surfaceVariant: Color(0xffd9deea),
  onSurfaceVariant: Color(0xff44474e),
  outline: Color(0xff74777f),
  outlineVariant: Color(0xffc4c6cf),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xff2d3136),
  onInverseSurface: Color(0xfff1f0f4),
  inversePrimary: Color(0xffa9c7ff),
  surfaceTint: Color(0xff005db7),
);

const ColorScheme SchemeDark_BlueDelight = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xffa9c7ff),
  onPrimary: Color(0xff003063),
  primaryContainer: Color(0xff00468c),
  onPrimaryContainer: Color(0xffd6e3ff),
  secondary: Color(0xffbdc7dc),
  onSecondary: Color(0xff283141),
  secondaryContainer: Color(0xff3e4758),
  onSecondaryContainer: Color(0xffdae2f9),
  tertiary: Color(0xffdcbce1),
  onTertiary: Color(0xff3f2845),
  tertiaryContainer: Color(0xff563e5c),
  onTertiaryContainer: Color(0xfff9d8fd),
  error: Color(0xffffb4ab),
  onError: Color(0xff690005),
  errorContainer: Color(0xff93000a),
  onErrorContainer: Color(0xffffb4ab),
  background: Color(0xff212329),
  onBackground: Color(0xffe3e2e6),
  surface: Color(0xff212329),
  onSurface: Color(0xffe3e2e6),
  surfaceVariant: Color(0xff494d57),
  onSurfaceVariant: Color(0xffc4c6cf),
  outline: Color(0xff8e9099),
  outlineVariant: Color(0xff44474e),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xffe0e0e7),
  onInverseSurface: Color(0xff2f3033),
  inversePrimary: Color(0xff005db7),
  surfaceTint: Color(0xffa9c7ff),
);
