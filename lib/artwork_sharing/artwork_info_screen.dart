import 'dart:convert';

import 'package:aws_flutter/api/base_client.dart';
import 'package:aws_flutter/model/art_work.dart';
import 'package:aws_flutter/model/login_model.dart';
import 'package:aws_flutter/model/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'design_artwork_app_theme.dart';

class ArtWorkInfoScreen extends StatefulWidget {
  final String artWorkId;

  const ArtWorkInfoScreen({super.key, required this.artWorkId});

  @override
  _ArtWorkInfoScreenState createState() => _ArtWorkInfoScreenState();
}

class _ArtWorkInfoScreenState extends State<ArtWorkInfoScreen>
    with TickerProviderStateMixin {
  late Future<ArtWork> futureArtWork;
  late ArtWork artWork = ArtWork.empty();

  final double infoHeight = 364.0;
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;

  late Future<Accinfo?> accInfoFuture;
  late Future<String?> tokenFuture;
  late Accinfo accinfo = Accinfo.empty();
  late String token = '';

  final storage = FlutterSecureStorage();

  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  Future<Accinfo?> getAccInfo() async {
    String? accinfoJsonString = await storage.read(key: 'accinfo');
    if (accinfoJsonString != null) {
      Map<String, dynamic> accinfoJson = json.decode(accinfoJsonString);
      Accinfo accinfo = Accinfo.fromJson(accinfoJson);
      return accinfo;
    }
    return null;
  }

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
  }

  Future<void> setData() async {
    animationController?.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
    futureArtWork = BaseClient().fetchArtWorkById(widget.artWorkId);
    await futureArtWork.then((value) => setState(() {
          artWork = value;
        }));
    tokenFuture = getToken();
    tokenFuture.then((value) => {
          setState(() {
            token = value!;
          })
        });
    accInfoFuture = getAccInfo();
    accInfoFuture.then((value) => {
          setState(() {
            accinfo = value!;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        24.0;
    if (artWork.id.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Container(
        color: DesignArtWorkAppTheme.nearlyWhite,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1.2,
                    child: Image.network(artWork.imageUrl),
                  ),
                ],
              ),
              Positioned(
                top: (MediaQuery.of(context).size.width / 1.2) - 24.0,
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: DesignArtWorkAppTheme.nearlyWhite,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(32.0),
                        topRight: Radius.circular(32.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: DesignArtWorkAppTheme.grey.withOpacity(0.2),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: SingleChildScrollView(
                      child: Container(
                        constraints: BoxConstraints(
                            minHeight: infoHeight,
                            maxHeight: tempHeight > infoHeight
                                ? tempHeight
                                : infoHeight),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 32.0, left: 18, right: 16),
                              child: Text(
                                artWork.name,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22,
                                  letterSpacing: 0.27,
                                  color: DesignArtWorkAppTheme.darkerText,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, bottom: 8, top: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    '\$${artWork.price}',
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 22,
                                      letterSpacing: 0.27,
                                      color: DesignArtWorkAppTheme.nearlyBlue,
                                    ),
                                  ),
                                  // Container(
                                  //   child: Row(
                                  //     children: <Widget>[
                                  //       Text(
                                  //         '4.3',
                                  //         textAlign: TextAlign.left,
                                  //         style: TextStyle(
                                  //           fontWeight: FontWeight.w200,
                                  //           fontSize: 22,
                                  //           letterSpacing: 0.27,
                                  //           color: DesignArtWorkAppTheme.grey,
                                  //         ),
                                  //       ),
                                  //       Icon(
                                  //         Icons.star,
                                  //         color: DesignArtWorkAppTheme.nearlyBlue,
                                  //         size: 24,
                                  //       ),
                                  //     ],
                                  //   ),
                                  // )
                                ],
                              ),
                            ),
                            // AnimatedOpacity(
                            //   duration: const Duration(milliseconds: 500),
                            //   opacity: opacity1,
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(8),
                            //     child: Row(
                            //       children: <Widget>[
                            //         getTimeBoxUI('24', 'Classe'),
                            //         getTimeBoxUI('2hours', 'Time'),
                            //         getTimeBoxUI('24', 'Seat'),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            Expanded(
                              child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 500),
                                opacity: opacity2,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16, top: 8, bottom: 8),
                                  child: Text(
                                    artWork.description,
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 14,
                                      letterSpacing: 0.27,
                                      color: DesignArtWorkAppTheme.grey,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                            AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: opacity3,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, bottom: 16, right: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    // Container(
                                    //   width: 48,
                                    //   height: 48,
                                    //   child: Container(
                                    //     decoration: BoxDecoration(
                                    //       color: DesignArtWorkAppTheme.nearlyWhite,
                                    //       borderRadius: const BorderRadius.all(
                                    //         Radius.circular(16.0),
                                    //       ),
                                    //       border: Border.all(
                                    //           color: DesignArtWorkAppTheme.grey
                                    //               .withOpacity(0.2)),
                                    //     ),
                                    //     child: Icon(
                                    //       Icons.add,
                                    //       color: DesignArtWorkAppTheme.nearlyBlue,
                                    //       size: 28,
                                    //     ),
                                    //   ),
                                    // ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          var response = BaseClient()
                                              .createOrder(
                                                  order: Order(
                                                      id: '',
                                                      created: DateTime.now(),
                                                      isDeleted: false,
                                                      buyerAccountId:
                                                          accinfo.id,
                                                      ownerAccountId:
                                                          artWork.userOwnerId,
                                                      artWorkId: artWork.id,
                                                      status: 0));
                                          response.then((value) => {
                                                if (value.statusCode == 200)
                                                  {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                            'Add artwork success'),
                                                      ),
                                                    )
                                                  }
                                                else
                                                  {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                            'Add artwork fail'),
                                                      ),
                                                    )
                                                  }
                                              });
                                        },
                                        child: Container(
                                          height: 48,
                                          decoration: BoxDecoration(
                                            color: DesignArtWorkAppTheme
                                                .nearlyBrown,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(16.0),
                                            ),
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                  color: DesignArtWorkAppTheme
                                                      .nearlyBrown
                                                      .withOpacity(0.5),
                                                  offset:
                                                      const Offset(1.1, 1.1),
                                                  blurRadius: 10.0),
                                            ],
                                          ),
                                          child: const Center(
                                            child: Text(
                                              'Buy Art Work',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                                letterSpacing: 0.0,
                                                color: DesignArtWorkAppTheme
                                                    .nearlyWhite,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).padding.bottom,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Positioned(
              //   top: (MediaQuery.of(context).size.width / 1.2) - 24.0 - 35,
              //   right: 35,
              //   child: ScaleTransition(
              //     alignment: Alignment.center,
              //     scale: CurvedAnimation(
              //         parent: animationController!, curve: Curves.fastOutSlowIn),
              //     child: Card(
              //       color: DesignArtWorkAppTheme.nearlyBlue,
              //       shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(50.0)),
              //       elevation: 10.0,
              //       child: Container(
              //         width: 60,
              //         height: 60,
              //         child: Center(
              //           child: Icon(
              //             Icons.favorite,
              //             color: DesignArtWorkAppTheme.nearlyWhite,
              //             size: 30,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: SizedBox(
                  width: AppBar().preferredSize.height,
                  height: AppBar().preferredSize.height,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius:
                          BorderRadius.circular(AppBar().preferredSize.height),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: DesignArtWorkAppTheme.nearlyBlack,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
  }

  Widget getTimeBoxUI(String text1, String txt2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: DesignArtWorkAppTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: DesignArtWorkAppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: DesignArtWorkAppTheme.nearlyBlue,
                ),
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: DesignArtWorkAppTheme.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
