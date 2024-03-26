
import 'dart:convert';

import 'package:aws_flutter/api/base_client.dart';
import 'package:aws_flutter/artwork_sharing/artwork_info_screen.dart';
import 'package:aws_flutter/artwork_sharing/artwork_list_view.dart';
import 'package:aws_flutter/hotel_booking/calendar_popup_view.dart';
import 'package:aws_flutter/hotel_booking/model/hotel_list_data.dart';
import 'package:aws_flutter/model/art_work.dart';
import 'package:aws_flutter/model/login_model.dart';
import 'package:aws_flutter/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:aws_flutter/hotel_booking/filters_screen.dart';
import 'package:aws_flutter/hotel_booking/hotel_app_theme.dart';

class MyArtWorkScreen extends StatefulWidget {
  const MyArtWorkScreen({super.key});

  @override
  _MyArtWorkScreenState createState() => _MyArtWorkScreenState();
}

class _MyArtWorkScreenState extends State<MyArtWorkScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<HotelListData> hotelList = HotelListData.hotelList;
  final ScrollController _scrollController = ScrollController();
  String _searchString = '';
  bool _isSearching = false;

  late Future<List<ArtWork>> futureArtWork;
  late List<ArtWork> listArtWork = [];
  late List<ArtWork> listSearchArtWork = [];
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
    initializedData();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  Future<void> initializedData() async {
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
    futureArtWork = BaseClient().fetchArtWorks();
    await futureArtWork.then((value) => setState(() {
      for(var item in value) {
        if(accinfo.id == item.userOwnerId) {
          listArtWork.add(item);
        } else if (accinfo.id != item.userOwnerId && accinfo.id == item.userAccountId) {
          item.name = item.name + ' (sold)';
          listArtWork.add(item);
        }
      }
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
    super.dispose();
  }

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
              );
            },
            artWorkData: list[index],
            animation: animation,
            animationController: animationController!,
          );
        },
      ),
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
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),
            ),
            const Expanded(
              child: Center(
                child: Text(
                  'My Artworks',
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
