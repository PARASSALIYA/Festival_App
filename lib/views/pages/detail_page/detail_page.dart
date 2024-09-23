import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:festival_post_app/header.dart';
import 'package:festival_post_app/model/festival_model.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.sizeOf(context);
    FestivalModel festivalData =
        ModalRoute.of(context)!.settings.arguments as FestivalModel;
    return Scaffold(
      body: Stack(
        children: [
          bgWidget(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Row(
                    children: [
                      const Spacer(),
                      Text(
                        festivalData.festivalName,
                        style: GoogleFonts.aclonica(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.editpage,
                              arguments: festivalData);
                        },
                        child: const Text(
                          "Edit",
                          style: TextStyle(
                            fontSize: 18,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  FanCarouselImageSlider.sliderType1(
                    isAssets: false,
                    autoPlay: false,
                    imageRadius: 30,
                    sliderWidth: 550,
                    sliderHeight: 400,
                    showIndicator: false,
                    imagesLink: festivalData.detailing,
                  ),
                  const SizedBox(height: 20),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: "Description \n",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: festivalData.description,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: "UpcomingDate \t\t\t\t",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: festivalData.date,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: "Region \t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: festivalData.region,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text:
                              "Moral \t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: festivalData.moral,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
