import 'package:festival_post_app/utils/route.dart';

import 'header.dart';

void main() {
  runApp(
    const FestivalPostApp(),
  );
}

class FestivalPostApp extends StatelessWidget {
  const FestivalPostApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
    );
  }
}
