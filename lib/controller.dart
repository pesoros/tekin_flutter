import 'dart:convert';

import 'package:http/http.dart' as http;
import 'model.dart';

get(String query) async {
  String url = 'https://gsmarena-expressjs.vercel.app/$query';
  Uri parseUrl = Uri.parse(url);
  var response = await http.get(parseUrl);
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    return null;
  }
}

getTop10() async {
  List<Top10> listT = [];
  await get('top').then((val) {
    if (val != null) {
      for (var data in val as List) {
        List<Top10List> listL = [];
        for (var detail in data['list'] as List) {
          listL.add(Top10List.fromJson(jsonEncode(detail)));
        }
        listT.add(
          Top10(
            category: data['category'],
            list: listL,
          ),
        );
      }
    } else {}
  });
  return listT;
}

searchDevice(String query) async {
  List<SearchDevice> list = [];
  await get('search?q=$query').then((val) {
    if (val != null) {
      for (var data in val as List) {
        list.add(SearchDevice.fromJson(jsonEncode(data)));
      }
    } else {}
  });
  return list;
}

deviceDetail(String query) async {
  var val = await get('device?id=$query');
  return val;
}
