import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/photo.dart';
import '../contollers/token_controller.dart';

class PhotoBloc {
  TokenController tokenController = TokenController.instance;
  PhotoBloc() {
    _fetchController.stream.listen(handler);
  }

  StreamController<List<Photo>> _outController =
      StreamController<List<Photo>>();

  Stream<List<Photo>> get fetch => _outController.stream;
  StreamSink<List<Photo>> get _outputPhotos => _outController.sink;

  StreamController _fetchController = StreamController();
  StreamSink get fetchProces => _fetchController.sink;

  void handler(data) async {
    List<Photo> photos = await _fetchPhotos();
    _outputPhotos.add(photos);
  }

  Future<List<Photo>> _fetchPhotos() async {
    String _token = tokenController.token;
    var url = Uri.parse(
        "https://private-5548f0-photo11.apiary-mock.com/photos?token=$_token");
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Photo> result = [];
        List<dynamic> photoList = jsonDecode(response.body);
        for (var photo in photoList) {
          result.add(Photo.fromJson(photo));
        }
        return result;
      }
    } catch (e) {
      _outputPhotos.addError(e);
    }
    return null;
  }

  void dispose() {
    _outController.close();
    _fetchController.close();
  }
}
