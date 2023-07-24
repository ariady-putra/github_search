import 'package:flutter/material.dart';

class AppColor {
  static const Color darkShade = Color(0xFF77115B);
  static const Color lightShade = Color(0xFFF9E5ED);
}

class AppTheme {
  static final ThemeData _baseLight = ThemeData(useMaterial3: true).copyWith(
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.darkShade,
    ),
    cardColor: AppColor.darkShade,
    disabledColor: Colors.grey[400],
    hintColor: AppColor.darkShade,
    indicatorColor: AppColor.lightShade,
    primaryColorDark: AppColor.darkShade,
    primaryColorLight: AppColor.lightShade,
    secondaryHeaderColor: Colors.grey[700],
    unselectedWidgetColor: Colors.white.withOpacity(.75),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return AppColor.lightShade;
        }
        return null;
      }),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return AppColor.lightShade;
        }
        return null;
      }),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return AppColor.lightShade;
        }
        return null;
      }),
      trackColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return AppColor.lightShade;
        }
        return null;
      }),
    ),
  );
  static ThemeData light = _baseLight.copyWith(
    colorScheme: _baseLight.colorScheme.copyWith(
      primary: AppColor.darkShade,
      secondary: AppColor.darkShade,
      tertiary: AppColor.darkShade,
      inversePrimary: AppColor.lightShade,
    ),
  );

  static final ThemeData _baseDark =
      ThemeData.dark(useMaterial3: true).copyWith(
    disabledColor: Colors.white10,
    // hintColor: AppColor.lightShade.withOpacity(.5),
    indicatorColor: AppColor.lightShade,
    primaryColorDark: AppColor.lightShade,
    primaryColorLight: AppColor.lightShade,
    secondaryHeaderColor: Colors.white70,
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return AppColor.lightShade;
        }
        return null;
      }),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return AppColor.lightShade;
        }
        return null;
      }),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return AppColor.lightShade;
        }
        return null;
      }),
      trackColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return AppColor.lightShade;
        }
        return null;
      }),
    ),
    // unselectedWidgetColor: AppColor.lightShade,
  );
  static ThemeData dark = _baseDark.copyWith(
    colorScheme: _baseDark.colorScheme.copyWith(
      primary: AppColor.lightShade,
      secondary: AppColor.lightShade,
      tertiary: AppColor.lightShade,
      inversePrimary: AppColor.darkShade,
    ),
  );
}

// SVG illustrations by https://undraw.co/illustrations
class AppSvg {
  static String _fillColor(BuildContext context) => Theme.of(context)
      .colorScheme
      .primary
      .value
      .toRadixString(16)
      .padLeft(8, '0')
      .substring(2);

  static String search(BuildContext context) {
    final String fillColor = _fillColor(context);
    return '<svg width="148" height="122"><g data-name="Group 107"><path data-name="Path 574" d="M129.164 80.771c15.139 16.742-28.745 40.869-64.2 40.869S4.972 102.946.764 80.771c-10.215-53.765 87.038-87.938 64.2-40.869-33.287 68.61 52.278 27.684 64.2 40.869z" fill="#3f3d56"></path><circle data-name="Ellipse 129" cx="1.29" cy="1.29" r="1.29" transform="translate(45.687 26.087)" fill="#d0cde1"></circle><circle data-name="Ellipse 130" cx="1.29" cy="1.29" r="1.29" transform="translate(28.205 103.323)" fill="#d0cde1"></circle><circle data-name="Ellipse 131" cx="0.573" cy="0.573" r="0.573" transform="translate(48.696 45.719)" fill="#d0cde1"></circle><circle data-name="Ellipse 132" cx="0.573" cy="0.573" r="0.573" transform="translate(18.604 75.524)" fill="#d0cde1"></circle><circle data-name="Ellipse 133" cx="0.573" cy="0.573" r="0.573" transform="translate(93.977 97.018)" fill="#d0cde1"></circle><circle data-name="Ellipse 134" cx="0.573" cy="0.573" r="0.573" transform="translate(16.741 46.292)" fill="#d0cde1"></circle><path data-name="Path 575" d="M52.134 31.676h-.287v-.287h-.143v.287h-.287v.143h.287v.287h.143v-.287h.287z" fill="#d0cde1"></path><path data-name="Path 576" d="M30.21 36.405h-.287v-.287h-.143v.287h-.287v.143h.287v.287h.143v-.287h.287z" fill="#d0cde1"></path><path data-name="Path 577" d="M15.881 63.345h-.282v-.287h-.143v.287h-.287v.143h.287v.287h.143v-.287h.287z" fill="#d0cde1"></path><circle data-name="Ellipse 135" cx="0.573" cy="0.573" r="0.573" transform="translate(55.574 109.342)" fill="#d0cde1"></circle><circle data-name="Ellipse 136" cx="0.573" cy="0.573" r="0.573" transform="translate(53.711 80.11)" fill="#d0cde1"></circle><circle data-name="Ellipse 137" cx="0.573" cy="0.573" r="0.573" transform="translate(121.49 90.714)" fill="#d0cde1"></circle><path data-name="Path 578" d="M52.851 97.162h-.287v-.287h-.143v.287h-.287v.143h.287v.287h.143v-.287h.287z" fill="#d0cde1"></path><path data-name="Path 579" d="M80.65 107.336h-.286v-.286h-.143v.286h-.287v.143h.287v.287h.143v-.287h.286z" fill="#d0cde1"></path><path data-name="Path 580" d="M10.434 81.83h-.287v-.287h-.143v.287h-.287v.143h.287v.286h.143v-.286h.287z" fill="#d0cde1"></path><path data-name="Path 581" d="M50.272 61.195h-.287v-.287h-.143v.287h-.284v.143h.287v.287h.143v-.287h.287z" fill="#d0cde1"></path><path data-name="Path 582" d="M32.646 44.286h-.287v-.287h-.143v.287h-.287v.143h.287v.287h.143v-.287h.287z" fill="#d0cde1"></path><path data-name="Path 583" d="M44.401 72.515h-.287v-.287h-.143v.287h-.287v.143h.287v.287h.143v-.287h.287z" fill="#d0cde1"></path><path data-name="Path 584" d="M27.201 90.284h-.287v-.287h-.143v.287h-.287v.143h.287v.287h.143v-.287h.287z" fill="#d0cde1"></path><ellipse data-name="Ellipse 138" cx="8.454" cy="1.29" rx="8.454" ry="1.29" transform="translate(24.622 63.487)" fill="#$fillColor"></ellipse><path data-name="Path 585" d="M33.937 65.203c-3.456 0-8.6-.382-8.6-1.433s5.142-1.433 8.6-1.433 8.6.382 8.6 1.433-5.144 1.433-8.6 1.433zm0-2.579A41.61 41.61 0 0027.98 63c-1.863.284-2.355.628-2.355.77s.492.486 2.355.77a47.349 47.349 0 0011.913 0c1.862-.284 2.355-.628 2.355-.77s-.492-.486-2.355-.77a41.611 41.611 0 00-5.956-.372z" fill="#d0cde1"></path><path data-name="Path 587" d="M135.711 75.641c-11.927-13.184-97.487 27.741-64.205-40.867C86.342 4.191 50.482 7.906 26.343 29.007c23.375-16.051 51.591-16.513 38.141 11.212-33.282 68.61 52.283 27.684 64.2 40.869 5.547 6.135 3.169 13.261-3.816 19.829 12.011-7.871 17.972-17.392 10.843-25.276z" fill="#e6e6e6"></path><path data-name="Path 588" d="M65.549 121.377l-.184-.069a10.753 10.753 0 01-6.916-12.825l.044-.192.184.069a10.753 10.753 0 016.915 12.825zm-5.843-5.295a12.047 12.047 0 005.59 4.826 10.37 10.37 0 00-6.551-12.149 12.062 12.062 0 00.961 7.323z" fill="#d0cde1"></path><path data-name="Path 589" d="M60.847 115.188a12.29 12.29 0 014.7 6.1 10.582 10.582 0 01-12.292-7.4 12.291 12.291 0 017.592 1.3z" fill="#$fillColor"></path><path data-name="Path 590" d="M108.473 41.035s-7.777 7.622-4.511 8.555 7-7 7-7z" fill="#ffb9b9"></path><path data-name="Path 591" d="M116.25 66.701l-.933 4.355 7 .311-1.089-4.667z" fill="#ffb9b9"></path><path data-name="Path 592" d="M138.338 93.611l-.933 4.355 7 .311-1.089-4.667z" fill="#ffb9b9"></path><path data-name="Path 593" d="M126.05 37.613l.622 2.489s-17.266-3.422-16.333 5.289a60.166 60.166 0 004.978 17.11s-.311 2.8.311 3.267 0 2.022 0 2.022 5.755.778 5.911-.622a9.756 9.756 0 00-.156-2.8s.311 0 0-1.556-1.568-14.1-2.5-15.811c0 0 8.256 6.323 12.612 5.545a40.993 40.993 0 001.867 14.466c2.489 8.244 2.489 9.177 2.489 9.177s2.955 15.711 2.178 17.577l-.156.778h5.755s-.467-8.244 0-9.333.467-10.422-2.178-15.088c-1.873-3.3-1.524-12.886-.5-16.674a19.591 19.591 0 00.573-8.884 10.407 10.407 0 00-4.118-6.952z" fill="#2f2e41"></path><circle data-name="Ellipse 139" cx="5.6" cy="5.6" r="5.6" transform="translate(125.039 3.003)" fill="#ffb9b9"></circle><path data-name="Path 594" d="M129.161 12.57s1.711 4.978 1.556 5.911 4.978-1.867 4.978-1.867-2.022-4.978-1.4-6.378z" fill="#ffb9b9"></path><path data-name="Path 595" d="M135.383 14.899l-5.444 2.178.311 1.867s-.467.622-.311.933-2.022 1.555-1.711 2.022-1.867 2.333-1.711 2.8-4.978 3.267-2.178 8.711a6.676 6.676 0 011.27 4.119q-.01.118-.025.237c-.311 2.333 11.822-.311 11.822-.311v-2.644s1.089-.467.933-2.489-1.089-1.089 0-2.178 1.089-.933.933-1.867c-.062-.373-.075-1.713-.067-3.188a14.154 14.154 0 00-2.888-8.634z" fill="#d0cde1"></path><path data-name="Path 596" d="M132.428 18.947l-10.111 10.577L107.54 41.19l3.267 2.644 27.221-18.2s2.333-9.954-5.6-6.687z" fill="#d0cde1"></path><path data-name="Path 597" d="M116.717 69.034s-1.089-1.867-1.867-1.244l-5.444 4.355s-9.644 2.8-.311 4.978c0 0 5.133.778 6.222 0a3.609 3.609 0 013.267-.311c.467.311 6.378-.156 6.378-1.4s-3.26-6.683-3.26-6.683-1.87 2.171-4.985.305z" fill="#2f2e41"></path><path data-name="Path 598" d="M138.805 95.944s-1.089-1.867-1.867-1.244l-5.444 4.355s-9.644 2.8-.311 4.978c0 0 5.133.778 6.222 0a3.609 3.609 0 013.267-.311c.467.311 6.378-.156 6.378-1.4s-3.26-6.683-3.26-6.683-1.874 2.172-4.985.305z" fill="#2f2e41"></path><path data-name="Path 599" d="M123.928 6.382s.947-8.323 9.045-5.96c0 0 5.729-1.165 7.752 5.99l2.054 7.5-.94-.489-.416.956-1.5.411-.67-1.268-.282 1.561-10.361 2.095a16.1 16.1 0 003.479-9.867l-1.029 1.135z" fill="#2f2e41"></path><path data-name="Path 602" d="M41.055 60.267l-5.82-5.82a5.266 5.266 0 10-1.515 1.515l5.82 5.82zm-12.874-6.058a3.748 3.748 0 115.3 0 3.749 3.749 0 01-5.3-.002z" fill="#$fillColor"></path></g></svg>';
  }

  static String error(BuildContext context) {
    final String fillColor = _fillColor(context);
    return '<svg width="117" height="156"><g data-name="Group 124" transform="translate(-400 -579.602)"><circle data-name="Ellipse 140" cx="14.038" cy="14.038" r="14.038" transform="translate(432.592 588.156)" fill="#ff6584"></circle><path data-name="Path 604" d="M514.927 654.86c0 33.122-19.691 44.687-43.98 44.687s-43.98-11.565-43.98-44.687 43.98-75.259 43.98-75.259 43.98 42.138 43.98 75.259z" fill="#f2f2f2"></path><path data-name="Path 605" d="M469.345 694.482l.451-27.72 18.745-34.294-18.675 29.945.2-12.464 12.919-24.811-12.863 21.512.364-22.417 13.834-19.753-13.777 16.228.228-41.106-1.43 54.416.118-2.245-14.066-21.529 13.84 25.839-1.311 25.036-.039-.664-16.215-22.653 16.166 25-.164 3.131-.029.047.013.257-3.325 63.52h4.442l.533-32.809 16.127-24.946z" fill="#3f3d56"></path><ellipse data-name="Ellipse 141" cx="57.363" cy="6.149" rx="57.363" ry="6.149" transform="translate(400 722.706)" fill="#3f3d56"></ellipse><circle data-name="Ellipse 145" cx="17.328" cy="17.328" r="17.328" transform="translate(403.966 686.478)" fill="#2f2e41"></circle><path data-name="Rectangle 228" fill="#2f2e41" d="M413.238 717.31l5.264.062-.111 9.43-5.264-.062z"></path><path data-name="Rectangle 229" fill="#2f2e41" d="M423.766 717.434l5.264.062-.111 9.43-5.264-.062z"></path><ellipse data-name="Ellipse 146" cx="1.645" cy="4.387" rx="1.645" ry="4.387" transform="rotate(-89.325 575.117 155.247)" fill="#2f2e41"></ellipse><ellipse data-name="Ellipse 147" cx="1.645" cy="4.387" rx="1.645" ry="4.387" transform="rotate(-89.325 580.334 149.872)" fill="#2f2e41"></ellipse><circle data-name="Ellipse 148" cx="5.922" cy="5.922" r="5.922" transform="translate(415.862 693.502)" fill="#fff"></circle><circle data-name="Ellipse 149" cx="1.974" cy="1.974" r="1.974" transform="translate(419.81 697.45)" fill="#3f3d56"></circle><path data-name="Path 608" d="M404.677 687.494c-1.325-6.282 3.222-12.56 10.155-14.023s13.629 2.444 14.954 8.726-3.285 8.539-10.219 10-13.565 1.579-14.89-4.703z" fill="#$fillColor"></path><path data-name="Path 609" d="M447.726 713.472c0 12.08-7.181 16.3-16.04 16.3q-.308 0-.615-.007c-.41-.009-.817-.028-1.219-.056-8-.566-14.207-5-14.207-16.235 0-11.627 14.858-26.3 15.974-27.383l.064-.063s16.043 15.363 16.043 27.444z" fill="#$fillColor"></path><path data-name="Path 610" d="M431.101 727.922l5.867-8.2-5.881 9.1-.016.941c-.41-.009-.817-.028-1.219-.056l.632-12.086v-.094l.011-.018.06-1.141-5.9-9.12 5.914 8.264.014.242.478-9.132-5.048-9.424 5.109 7.821.5-18.932v-.064.063l-.083 14.929 5.025-5.918-5.046 7.2-.133 8.176 4.692-7.847-4.711 9.05-.074 4.545 6.812-10.921-6.837 12.507z" fill="#3f3d56"></path><path data-name="Path 613" d="M510.11 724.524l5.385-7.525-5.4 8.351-.014.864c-.377-.008-.75-.026-1.119-.051l.58-11.094v-.086l.01-.016.055-1.048-5.412-8.372 5.429 7.586.013.222.439-8.382-4.633-8.651 4.69 7.179.457-17.379v-.059.057l-.076 13.7 4.613-5.433-4.632 6.613-.122 7.505 4.307-7.2-4.325 8.307-.068 4.172 6.253-10.025-6.276 11.481z" fill="#3f3d56"></path><ellipse data-name="Ellipse 156" cx="2.72" cy="8.664" rx="2.72" ry="8.664" transform="rotate(-68.159 727.074 53.502)" fill="#2f2e41"></ellipse></g></svg>';
  }
}
