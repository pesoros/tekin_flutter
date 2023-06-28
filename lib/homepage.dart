import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tekin_flutter/controller.dart';
import 'package:tekin_flutter/detailpage.dart';
import 'package:tekin_flutter/model.dart';
import 'package:tekin_flutter/styles.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Top10> list = [];
  List<SearchDevice> searchList = [];
  bool openSearch = false;
  TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  getData() async {
    await getTop10().then((val) {
      setState(() {
        list = val;
      });
    });
  }

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (query.isEmpty) {
        if (!mounted) return;
        setState(() {
          searchList.clear();
        });
      } else {
        await searchDevice(query).then((val) {
          if (!mounted) return;
          setState(() {
            searchList = val;
          });
        });
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      excludeFromSemantics: true,
      gestures: const [
        GestureType.onTap,
        GestureType.onVerticalDragStart,
        GestureType.onHorizontalDragStart,
      ],
      child: (list.isEmpty)
          ? Scaffold(
              body: loadingIndicator,
              backgroundColor: whiteColor,
            )
          : DefaultTabController(
              length: list.length,
              child: Scaffold(
                backgroundColor: whiteColor,
                body: SafeArea(
                    child: Column(
                  children: [
                    widthButton(context, (!openSearch) ? 'SEARCH' : 'TOP10',
                        CrossAxisAlignment.end, () {
                      if (!mounted) return;
                      setState(() {
                        openSearch = !openSearch;
                        searchController.clear();
                        searchList.clear();
                      });
                    }),
                    (openSearch)
                        ? TextField(
                            controller: searchController,
                            style: formSearch,
                            cursorColor: whiteColor,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: blackColor,
                              border: InputBorder.none,
                              hintStyle: formSearch,
                              hintText: 'SEARCH DEVICE',
                            ),
                            onChanged: _onSearchChanged,
                          )
                        : empty,
                    (openSearch)
                        ? Expanded(
                            child:
                                bodySearch(context, 1, searchController.text),
                          )
                        : Expanded(
                            child: TabBarView(
                              physics: const BouncingScrollPhysics(),
                              children: List.generate(list.length, (index) {
                                return bodyBar(context, index);
                              }),
                            ),
                          ),
                  ],
                )),
              ),
            ),
    );
  }

  Widget bodyBar(BuildContext context, int idx) {
    bool isLast = idx == (list.length - 1);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: smallFontSize, vertical: largeFontSize),
          child: Row(
            children: [
              (isLast)
                  ? Icon(
                      Icons.arrow_back_ios,
                      size: largeFontSize,
                    )
                  : empty,
              Expanded(
                child: Text(
                  '${list[idx].category}'.toUpperCase(),
                  style: titleList,
                  textAlign: (isLast) ? TextAlign.end : TextAlign.start,
                ),
              ),
              (!isLast)
                  ? Icon(
                      Icons.arrow_forward_ios,
                      size: largeFontSize,
                    )
                  : empty,
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: list[idx].list!.length,
            separatorBuilder: (context, index) {
              return defaultDivider;
            },
            itemBuilder: (context, index) {
              Top10List itemList = list[idx].list![index];
              return ListTile(
                title: Text(
                  itemList.name ?? '',
                  style: nameList,
                ),
                trailing: Text(
                  '#${itemList.position.toString()}',
                  style: positionList,
                ),
                subtitle: Row(
                  children: [
                    Icon(
                      Icons.thumb_up_rounded,
                      size: smallFontSize,
                    ),
                    SizedBox(width: extraSmallFontSize),
                    Text(
                      itemList.favorites.toString(),
                      style: favoritesList,
                    ),
                  ],
                ),
                onTap: () => navigateToDetail(itemList.id ?? ''),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget bodySearch(BuildContext context, int idx, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: smallFontSize, vertical: largeFontSize),
          child: Text(
            "'$title'".toUpperCase(),
            style: titleList,
          ),
        ),
        Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: searchList.length,
            separatorBuilder: (context, index) {
              return defaultDivider;
            },
            itemBuilder: (context, index) {
              SearchDevice itemList = searchList[index];
              return ListTile(
                title: Text(
                  itemList.name ?? '',
                  style: nameList,
                ),
                onTap: () => navigateToDetail(itemList.id ?? ''),
              );
            },
          ),
        ),
      ],
    );
  }

  navigateToDetail(String id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(
          id: id,
        ),
      ),
    );
  }
}
