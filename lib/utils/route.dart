import 'package:festival_post_app/header.dart';
import 'package:festival_post_app/views/pages/edit_page/edit_page.dart';

class Routes {
  static String splashpage = '/';
  static String homepage = '/homepage';
  static String detailspage = '/detailspage';
  static String editpage = '/editpage';
}

Map<String, Widget Function(BuildContext context)> routes = {
  Routes.splashpage: (context) => const SplashPage(),
  Routes.homepage: (context) => const HomePage(),
  Routes.detailspage: (context) => const DetailPage(),
  Routes.editpage: (context) => const EditPage(),
};
