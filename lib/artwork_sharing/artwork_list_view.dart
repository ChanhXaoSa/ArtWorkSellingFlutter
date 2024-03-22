import 'package:aws_flutter/hotel_booking/hotel_app_theme.dart';
import 'package:aws_flutter/model/art_work.dart';
import 'package:flutter/material.dart';

class ArtWorkListView extends StatelessWidget {
  const ArtWorkListView(
      {super.key,
        this.artWorkData,
        this.animationController,
        this.animation,
        this.callback});

  final VoidCallback? callback;
  final ArtWork? artWorkData;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 8, bottom: 16),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: callback,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        offset: const Offset(4, 4),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            AspectRatio(
                              aspectRatio: 2,
                              child: Image.network(
                                artWorkData!.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              color: HotelAppTheme.buildLightTheme()
                                  .colorScheme.background,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16, top: 8, bottom: 8),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              artWorkData!.name,
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 22,
                                              ),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  artWorkData!.description,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey
                                                          .withOpacity(0.8)),
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                // Icon(
                                                //   FontAwesomeIcons.locationDot,
                                                //   size: 12,
                                                //   color: HotelAppTheme
                                                //       .buildLightTheme()
                                                //       .primaryColor,
                                                // ),
                                                // Expanded(
                                                //   child: Text(
                                                //     '${hotelData!.dist.toStringAsFixed(1)} km to city',
                                                //     overflow:
                                                //     TextOverflow.ellipsis,
                                                //     style: TextStyle(
                                                //         fontSize: 14,
                                                //         color: Colors.grey
                                                //             .withOpacity(0.8)),
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                            const Padding(
                                              padding:
                                              EdgeInsets.only(top: 4),
                                              child: Row(
                                                children: <Widget>[
                                                  // RatingBar(
                                                  //   initialRating:
                                                  //   artWorkData!.interacts,
                                                  //   direction: Axis.horizontal,
                                                  //   allowHalfRating: true,
                                                  //   itemCount: 5,
                                                  //   itemSize: 24,
                                                  //   ratingWidget: RatingWidget(
                                                  //     full: Icon(
                                                  //       Icons.star_rate_rounded,
                                                  //       color: HotelAppTheme
                                                  //           .buildLightTheme()
                                                  //           .primaryColor,
                                                  //     ),
                                                  //     half: Icon(
                                                  //       Icons.star_half_rounded,
                                                  //       color: HotelAppTheme
                                                  //           .buildLightTheme()
                                                  //           .primaryColor,
                                                  //     ),
                                                  //     empty: Icon(
                                                  //       Icons
                                                  //           .star_border_rounded,
                                                  //       color: HotelAppTheme
                                                  //           .buildLightTheme()
                                                  //           .primaryColor,
                                                  //     ),
                                                  //   ),
                                                  //   itemPadding:
                                                  //   EdgeInsets.zero,
                                                  //   onRatingUpdate: (rating) {
                                                  //     print(rating);
                                                  //   },
                                                  // ),
                                                  // Text(
                                                  //   ' ${artWorkData!.interacts} Reviews',
                                                  //   style: TextStyle(
                                                  //       fontSize: 14,
                                                  //       color: Colors.grey
                                                  //           .withOpacity(0.8)),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 16, top: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          '\$${artWorkData!.price}',
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 22,
                                          ),
                                        ),
                                        // Text(
                                        //   '/per night',
                                        //   style: TextStyle(
                                        //       fontSize: 14,
                                        //       color:
                                        //       Colors.grey.withOpacity(0.8)),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // Positioned(
                        //   top: 8,
                        //   right: 8,
                        //   child: Material(
                        //     color: Colors.transparent,
                        //     child: InkWell(
                        //       borderRadius: const BorderRadius.all(
                        //         Radius.circular(32.0),
                        //       ),
                        //       onTap: () {},
                        //       child: Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: Icon(
                        //           Icons.favorite_border,
                        //           color: HotelAppTheme.buildLightTheme()
                        //               .primaryColor,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
