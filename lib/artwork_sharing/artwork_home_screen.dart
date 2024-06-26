
import 'package:aws_flutter/api/base_client.dart';
import 'package:aws_flutter/artwork_sharing/artwork_info_screen.dart';
import 'package:aws_flutter/artwork_sharing/artwork_list_view.dart';
import 'package:aws_flutter/hotel_booking/calendar_popup_view.dart';
import 'package:aws_flutter/hotel_booking/model/hotel_list_data.dart';
import 'package:aws_flutter/model/art_work.dart';
import 'package:aws_flutter/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:aws_flutter/hotel_booking/filters_screen.dart';
import 'package:aws_flutter/hotel_booking/hotel_app_theme.dart';

class ArtWorkHomeScreen extends StatefulWidget {
  const ArtWorkHomeScreen({super.key});

  @override
  _ArtWorkScreenState createState() => _ArtWorkScreenState();
}

class _ArtWorkScreenState extends State<ArtWorkHomeScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  AnimationController? animationController;
  List<HotelListData> hotelList = HotelListData.hotelList;
  final ScrollController _scrollController = ScrollController();
  String _searchString = '';
  bool _isSearching = false;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));

  late Future<List<ArtWork>> futureArtWork;
  late List<ArtWork> listArtWork = [];
  late List<ArtWork> listSearchArtWork = [];

  @override
  void initState() {
    initializedData();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
    // WidgetsBinding.instance.addObserver(this);
  }

  Future<void> initializedData() async {
    futureArtWork = BaseClient().fetchArtWorks();
    futureArtWork.then((value) => setState(() {
      listArtWork = value.toList();
    }));
  }

  void _searchArtWork() async {
    listSearchArtWork = [];
    if(_searchString.trim().isEmpty) {
      _isSearching = false;
      listSearchArtWork = [];
    } else {
      _isSearching = true;
    }
    for(var item in listArtWork) {
      if(item.name.toLowerCase().contains(_searchString.toLowerCase())) {
        setState(() {
          listSearchArtWork.add(item);
          _isSearching = true;
        });
      }
    }
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    // WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.resumed) {
  //     setState(() {
  //       initializedData();
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: HotelAppTheme.buildLightTheme(),
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Column(
                children: <Widget>[
                  getAppBarUI(),
                  Expanded(
                    child: NestedScrollView(
                      controller: _scrollController,
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) {
                        return <Widget>[
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                  return Column(
                                    children: <Widget>[
                                      getSearchBarUI(),
                                    ],
                                  );
                                }, childCount: 1),
                          ),
                          // SliverPersistentHeader(
                          //   pinned: true,
                          //   floating: true,
                          //   delegate: ContestTabHeader(
                          //     // getFilterBarUI(),
                          //   ),
                          // ),
                        ];
                      },
                      body: _isSearching ? getArtWorksUI(listSearchArtWork) : getArtWorksUI(listArtWork),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getArtWorksUI(List<ArtWork> list) {
    return Container(
      color:
      HotelAppTheme.buildLightTheme().colorScheme.background,
      child: ListView.builder(
        itemCount: list.length,
        padding: const EdgeInsets.only(top: 8),
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          final int count =
          list.length > 10 ? 10 : list.length;
          final Animation<double> animation =
          Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: animationController!,
                  curve: Interval(
                      (1 / count) * index, 1.0,
                      curve: Curves.fastOutSlowIn)));
          animationController?.forward();
          return ArtWorkListView(
            callback: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) =>
                    ArtWorkInfoScreen(artWorkId: list[index].id),
                ),
              ).then((value) {
                  initializedData();
              });;
            },
            artWorkData: list[index],
            animation: animation,
            animationController: animationController!,
          );
        },
      ),
    );
  }

  Widget getArtWorkViewList() {
    final List<Widget> artWorkListViews = <Widget>[];
    for (int i = 0; i < listArtWork.length; i++) {
      final int count = listArtWork.length;
      final Animation<double> animation =
      Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: animationController!,
          curve: Interval((1 / count) * i, 1.0, curve: Curves.fastOutSlowIn),
        ),
      );
      artWorkListViews.add(
        ArtWorkListView(
          callback: () {},
          artWorkData: listArtWork[i],
          animation: animation,
          animationController: animationController!,
        ),
      );
    }
    animationController?.forward();
    return Column(
      children: artWorkListViews,
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: HotelAppTheme.buildLightTheme().colorScheme.background,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 4, bottom: 4),
                  child: TextField(
                    onChanged: (String txt) {
                      _searchString = txt;
                    },
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    cursorColor: HotelAppTheme.buildLightTheme().primaryColor,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search Art Work...',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xffC79D67),
              borderRadius: const BorderRadius.all(
                Radius.circular(38.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: const Offset(0, 2),
                    blurRadius: 8.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  _searchArtWork();
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(FontAwesomeIcons.magnifyingGlass,
                      size: 20,
                      color: HotelAppTheme.buildLightTheme().colorScheme.background,),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget getFilterBarUI() {
  //   return Stack(
  //     children: <Widget>[
  //       Positioned(
  //         top: 0,
  //         left: 0,
  //         right: 0,
  //         child: Container(
  //           height: 24,
  //           decoration: BoxDecoration(
  //             color: HotelAppTheme.buildLightTheme().colorScheme.background,
  //             boxShadow: <BoxShadow>[
  //               BoxShadow(
  //                   color: Colors.grey.withOpacity(0.2),
  //                   offset: const Offset(0, -2),
  //                   blurRadius: 8.0),
  //             ],
  //           ),
  //         ),
  //       ),
  //       Container(
  //         color: HotelAppTheme.buildLightTheme().colorScheme.background,
  //         child: Padding(
  //           padding:
  //           const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
  //           child: Row(
  //             children: <Widget>[
  //               Expanded(
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: Text(
  //                     '${listArtWork.length} artworks found',
  //                     style: const TextStyle(
  //                       fontWeight: FontWeight.w100,
  //                       fontSize: 16,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               Material(
  //                 color: Colors.transparent,
  //                 child: InkWell(
  //                   focusColor: Colors.transparent,
  //                   highlightColor: Colors.transparent,
  //                   hoverColor: Colors.transparent,
  //                   splashColor: Colors.grey.withOpacity(0.2),
  //                   borderRadius: const BorderRadius.all(
  //                     Radius.circular(4.0),
  //                   ),
  //                   onTap: () {
  //                     FocusScope.of(context).requestFocus(FocusNode());
  //                     Navigator.push<dynamic>(
  //                       context,
  //                       MaterialPageRoute<dynamic>(
  //                           builder: (BuildContext context) => const FiltersScreen(),
  //                           fullscreenDialog: true),
  //                     );
  //                   },
  //                   child: const Padding(
  //                     padding: EdgeInsets.only(left: 8),
  //                     child: Row(
  //                       children: <Widget>[
  //                         Text(
  //                           'Filter',
  //                           style: TextStyle(
  //                             fontWeight: FontWeight.w100,
  //                             fontSize: 16,
  //                           ),
  //                         ),
  //                         Padding(
  //                           padding: EdgeInsets.all(8.0),
  //                           child: Icon(Icons.sort,
  //                               color: Color(0xffC79D67)),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //       const Positioned(
  //         top: 0,
  //         left: 0,
  //         right: 0,
  //         child: Divider(
  //           height: 1,
  //         ),
  //       )
  //     ],
  //   );
  // }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: HotelAppTheme.buildLightTheme().colorScheme.background,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                // child: InkWell(
                //   borderRadius: const BorderRadius.all(
                //     Radius.circular(32.0),
                //   ),
                //   onTap: () {
                //     Navigator.pop(context);
                //   },
                //   child: const Padding(
                //     padding: EdgeInsets.all(8.0),
                //     child: Icon(Icons.arrow_back),
                //   ),
                // ),
              ),
            ),
            const Expanded(
              child: Center(
                child: Text(
                  'Explore',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  // Material(
                  //   color: Colors.transparent,
                  //   child: InkWell(
                  //     borderRadius: const BorderRadius.all(
                  //       Radius.circular(32.0),
                  //     ),
                  //     onTap: () {},
                  //     child: const Padding(
                  //       padding: EdgeInsets.all(8.0),
                  //       child: Icon(Icons.favorite_border),
                  //     ),
                  //   ),
                  // ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(),
                          ),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(FontAwesomeIcons.solidUser),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  ContestTabHeader(
      this.searchUI,
      );
  final Widget searchUI;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return searchUI;
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
