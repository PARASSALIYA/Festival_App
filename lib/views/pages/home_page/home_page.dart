import 'package:festival_post_app/header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          bgWidget(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ListWheelScrollView(
              itemExtent: 350,
              diameterRatio: 1,
              // offAxisFraction: 1,
              squeeze: 1.5,
              clipBehavior: Clip.none,
              renderChildrenOutsideViewport: true,
              children: allFestivals
                  .map(
                    (e) => GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.detailspage,
                            arguments: e);
                      },
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey,
                          image: DecorationImage(
                            image: NetworkImage(
                              e.thumbnail,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Text(
                          e.festivalName,
                          style: GoogleFonts.aclonica(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
