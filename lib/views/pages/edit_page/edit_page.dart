import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:festival_post_app/header.dart';
import 'package:festival_post_app/model/festival_model.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> with TickerProviderStateMixin {
  String fonts = font[0].fontFamily!;
  Color? boxColor;
  Color? fontColor = colors[1];
  Color? bgGradientColor;
  Offset fnOffset = const Offset(0, 0);
  Offset wOffset = const Offset(0, 0);
  Offset mOffset = const Offset(0, 0);
  TabController? tabController;
  double texOpacity = 30;
  String? bgImage;
  int quoteLetterSpace = 1;
  int quoteWordSpace = 1;
  int fontSize = 14;
  Alignment fontAlignment = Alignment.center;
  FontWeight fontWeight = FontWeight.bold;
  String wish = allFestivalsData[0]['wishes'][0];
  GlobalKey key = GlobalKey();
  // image save
  Future<File> share() async {
    RenderRepaintBoundary boundary =
        key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(
      pixelRatio: 25,
    );
    ByteData? bytes = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    Uint8List uInt8list = bytes!.buffer.asUint8List();

    final Directory directory = await getTemporaryDirectory();
    File file = await File(
            "${directory.path}/QA-${DateTime.now().millisecondsSinceEpoch}.png")
        .create();
    file.writeAsBytesSync(uInt8list);

    return file;
  }

  Widget saveChild = const Icon(Icons.save_alt_rounded);

  // image share

  void refresh() {
    setState(() {
      fonts = font[0].fontFamily!;
      boxColor;
      fontColor = colors[1];
      bgGradientColor;
      fnOffset = const Offset(0, 0);
      wOffset = const Offset(0, 0);
      mOffset = const Offset(0, 0);
      tabController;
      texOpacity = 30;
      bgImage;
      quoteLetterSpace = 1;
      quoteWordSpace = 1;
      fontSize = 14;
      fontAlignment = Alignment.center;
      fontWeight = FontWeight.bold;
      wish = allFestivalsData[0]['wishes'][0];
    });
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.sizeOf(context);
    FestivalModel festivalEditData =
        ModalRoute.of(context)!.settings.arguments as FestivalModel;
    return Scaffold(
      body: Stack(
        children: [
          bgWidget(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(
                  height: s.height * 0.03,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      refresh();
                    },
                    icon: const Icon(Icons.refresh),
                  ),
                ),
                SizedBox(
                  height: s.height * 0.01,
                ),
                RepaintBoundary(
                  key: key,
                  child: Container(
                    height: s.height * 0.75,
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 2,
                      ),
                      color: boxColor != null
                          ? boxColor!
                          : Colors.white.withOpacity(0.5),
                      image: (bgImage != null)
                          ? DecorationImage(
                              image: NetworkImage(bgImage!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: fontAlignment,
                            child: GestureDetector(
                              onPanUpdate: (DragUpdateDetails details) {
                                setState(() {
                                  fnOffset = fnOffset + details.delta;
                                });
                              },
                              child: Transform.translate(
                                offset: fnOffset,
                                child: SelectableText(
                                  festivalEditData.festivalName,
                                  style: TextStyle(
                                    fontSize: fontSize.toDouble(),
                                    color: fontColor,
                                    fontWeight: fontWeight,
                                    fontFamily: fonts,
                                    letterSpacing: quoteLetterSpace.toDouble(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: fontAlignment,
                            child: GestureDetector(
                              onPanUpdate: (DragUpdateDetails details) {
                                setState(() {
                                  wOffset = wOffset + details.delta;
                                });
                              },
                              child: Transform.translate(
                                offset: wOffset,
                                child: SelectableText(
                                  wish,
                                  style: TextStyle(
                                    fontSize: fontSize.toDouble(),
                                    color: fontColor,
                                    fontWeight: fontWeight,
                                    fontFamily: fonts,
                                    letterSpacing: quoteLetterSpace.toDouble(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: fontAlignment,
                            child: GestureDetector(
                              onPanUpdate: (DragUpdateDetails details) {
                                setState(() {
                                  mOffset = mOffset + details.delta;
                                });
                              },
                              child: Transform.translate(
                                offset: mOffset,
                                child: Text(
                                  festivalEditData.moral,
                                  style: TextStyle(
                                    fontSize: fontSize.toDouble(),
                                    color: fontColor,
                                    fontWeight: fontWeight,
                                    fontFamily: fonts,
                                    letterSpacing: quoteLetterSpace.toDouble(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: s.height * 0.05,
                ),
                Container(
                  height: 50,
                  width: s.width,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(
                      40,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                height: s.height * 0.4,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: const DecorationImage(
                                    image: AssetImage(
                                      'lib/assets/images/bg.jpg',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      "Background Color",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: List.generate(
                                          colors.length,
                                          (index) => GestureDetector(
                                            onTap: () {
                                              boxColor = colors[index];
                                              bgImage = null;
                                              setState(() {});
                                            },
                                            child: Container(
                                              height: 70,
                                              width: 70,
                                              margin: const EdgeInsets.only(
                                                  right: 10),
                                              decoration: BoxDecoration(
                                                color: colors[index],
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "BackGround Image",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Expanded(
                                      child: GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 10,
                                          childAspectRatio: 4 / 5,
                                        ),
                                        itemCount:
                                            festivalEditData.images.length,
                                        itemBuilder: (context, index) =>
                                            GestureDetector(
                                          onTap: () {
                                            bgImage =
                                                festivalEditData.images[index];
                                            setState(() {});
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    festivalEditData
                                                        .images[index],
                                                  ),
                                                  fit: BoxFit.cover,
                                                )),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        color: Colors.white,
                        icon: const Icon(Icons.gradient),
                      ),
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                height: s.height * 0.4,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: const DecorationImage(
                                    image: AssetImage(
                                      'lib/assets/images/bg.jpg',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Font Family",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: List.generate(
                                          font.length,
                                          (index) => GestureDetector(
                                            onTap: () {
                                              fonts = font[index].fontFamily;
                                              setState(() {});
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 80,
                                              margin: const EdgeInsets.only(
                                                  right: 5),
                                              child: Text(
                                                "ABC",
                                                style: TextStyle(
                                                  fontFamily:
                                                      font[index].fontFamily,
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      " Font Color",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: List.generate(
                                          colors.length,
                                          (index) => GestureDetector(
                                            onTap: () {
                                              fontColor = colors[index];
                                              setState(() {});
                                            },
                                            child: Container(
                                              height: 50,
                                              width: 50,
                                              margin: const EdgeInsets.only(
                                                  right: 10),
                                              decoration: BoxDecoration(
                                                color: colors[index],
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // letter spacing
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Letter Spacing",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        quoteLetterSpace--;
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      Icons.text_decrease,
                                                      color: Colors.black,
                                                    )),
                                                IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        quoteLetterSpace++;
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      Icons.text_increase,
                                                      color: Colors.black,
                                                    )),
                                              ],
                                            )
                                          ],
                                        ),
                                        // font size
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Font Size",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        fontSize--;
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      Icons.text_decrease,
                                                      color: Colors.black,
                                                    )),
                                                IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        fontSize++;
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      Icons.text_increase,
                                                      color: Colors.black,
                                                    )),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        //font Alignment
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Text(
                                              "Font Alignment",
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    fontAlignment =
                                                        Alignment.topLeft;
                                                    setState(() {});
                                                  },
                                                  icon: const Icon(
                                                    Icons.format_align_left,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    fontAlignment =
                                                        Alignment.center;
                                                    setState(() {});
                                                  },
                                                  icon: const Icon(
                                                    Icons.format_align_center,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    fontAlignment =
                                                        Alignment.topRight;
                                                    setState(() {});
                                                  },
                                                  icon: const Icon(
                                                    Icons.format_align_right,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        //font weight
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Text(
                                              "Font Weight",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      fontWeight =
                                                          FontWeight.normal;
                                                    });
                                                  },
                                                  child: Text(
                                                    "ABC",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: (fontWeight ==
                                                                FontWeight
                                                                    .normal)
                                                            ? Colors.black
                                                            : Colors.black),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      fontWeight =
                                                          FontWeight.bold;
                                                    });
                                                  },
                                                  child: Text(
                                                    "ABC",
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: (fontWeight ==
                                                              FontWeight.bold)
                                                          ? Colors.black
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.text_fields),
                        color: Colors.white,
                      ),
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                height: s.height * 0.4,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: const DecorationImage(
                                    image: AssetImage(
                                      'lib/assets/images/bg.jpg',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ListWheelScrollView(
                                        onSelectedItemChanged: (value) {
                                          setState(() {
                                            wish =
                                                festivalEditData.wishes[value];
                                          });
                                        },
                                        itemExtent: 20,
                                        useMagnifier: true,
                                        magnification: 2,
                                        diameterRatio: 1,
                                        children: List.generate(
                                          festivalEditData.wishes.length,
                                          (index) => Text(
                                            festivalEditData.wishes[index],
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.auto_awesome),
                        color: Colors.white,
                      ),
                      IconButton(
                          icon: const Icon(Icons.share),
                          color: Colors.white,
                          onPressed: () async {
                            File file = await share();
                            ShareExtend.share(
                              file.path,
                              "file",
                            );
                          }),
                      IconButton(
                        icon: const Icon(Icons.download),
                        color: Colors.white,
                        onPressed: () async {
                          saveChild = const CircularProgressIndicator();
                          setState(() {});
                          File file = await share();
                          ImageGallerySaver.saveFile(file.path).then(
                            (value) {
                              saveChild = const Icon(Icons.done)
                                  as CircularProgressIndicator;
                              setState(() {});
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
