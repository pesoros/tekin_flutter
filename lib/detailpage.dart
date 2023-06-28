// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tekin_flutter/controller.dart';
import 'package:tekin_flutter/model.dart';
import 'package:tekin_flutter/styles.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key? key, required this.id}) : super(key: key);
  String id;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isLoad = true;
  String? name;
  String? img;
  List<DetailSpec>? detailSpec;
  List<QuickSpec>? quickSpec;
  int selectedTile = -1;

  getData(String q) async {
    await deviceDetail(q).then((val) {
      List<DetailSpec> listD = [];
      for (var data in val['detailSpec'] as List) {
        List<Specifications> listS = [];
        for (var dataS in data['specifications'] as List) {
          listS.add(Specifications.fromJson(jsonEncode(dataS)));
        }
        listD.add(
          DetailSpec(
            category: data['category'],
            specifications: listS,
          ),
        );
      }
      List<QuickSpec> listQ = [];
      for (var data in val['quickSpec'] as List) {
        listQ.add(QuickSpec.fromJson(jsonEncode(data)));
      }
      if (!mounted) return;
      setState(() {
        name = val['name'];
        img = val['img'];
        detailSpec = listD;
        quickSpec = listQ;
        isLoad = false;
      });
    });
  }

  @override
  void initState() {
    getData(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: (isLoad)
            ? loadingIndicator
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widthButton(context, 'BACK', CrossAxisAlignment.start,
                        () => Navigator.pop(context)),
                    Container(
                      padding: EdgeInsets.all(largeFontSize),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width,
                      child: Image.network(
                        img ?? '',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: extraSmallFontSize),
                      child: Text(
                        name ?? '',
                        style: nameList,
                      ),
                    ),
                    SizedBox(height: smallFontSize),
                    expansionList('Quick Specification', quickSpec),
                    SizedBox(height: smallFontSize),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: extraSmallFontSize),
                      child: Text(
                        'Full Specification',
                        style: nameList,
                      ),
                    ),
                    SizedBox(height: smallFontSize),
                    Column(
                      children: List.generate(detailSpec!.length, (index) {
                        return expansionList('${detailSpec![index].category}',
                            detailSpec![index].specifications);
                      }),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget expansionList(String title, var list) {
    return ExpansionTile(
      title: Text(
        title,
        style: titleContentCollapsed,
      ),
      collapsedTextColor: whiteColor,
      collapsedIconColor: whiteColor,
      collapsedBackgroundColor: blackColor,
      textColor: blackColor,
      iconColor: blackColor,
      backgroundColor: whiteColor,
      tilePadding: EdgeInsets.symmetric(horizontal: extraSmallFontSize),
      childrenPadding: EdgeInsets.only(
          left: extraSmallFontSize,
          right: extraSmallFontSize,
          bottom: extraSmallFontSize),
      children: List.generate(list!.length, (index) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              (list[index].name == " ")
                  ? ''
                  : '${list![index].name}: '.toUpperCase(),
              style: childrenNameContentCollapsed,
            ),
            Expanded(
              child: Text(
                '${list![index].value}'.replaceAll("\n", " ").toUpperCase(),
                style: childrenValueContentCollapsed,
              ),
            ),
          ],
        );
      }),
    );
  }
}
