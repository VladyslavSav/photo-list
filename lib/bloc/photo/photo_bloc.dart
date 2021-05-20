import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

import './photo_event.dart';
import './photo_state.dart';
import '../../models/photo.dart';
import '../../contollers/token_controller.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  TokenController tokenController = TokenController.instance;

  PhotoBloc() : super(FetchingState());

  @override
  Stream<PhotoState> mapEventToState(event) async* {
    try {
      if (event is FetchPhotoEvent) {
        var list = await _fetchPhotos();
        yield FetchedState(list);
      }
    } catch (e) {
      //yield error state
    }
  }

  Future<List<Photo>> _fetchPhotos() async {
    String _token = tokenController.token;
    var url = Uri.parse(
        "https://private-5548f0-photo11.apiary-mock.com/photos?token=$_token");

    var response = await http.get(url);
    if (response.statusCode == 200) {
      List<Photo> result = [];
      List<dynamic> photoList = jsonDecode(response.body);
      for (var photo in photoList) {
        result.add(Photo.fromJson(photo));
      }
      return result;
    } else {
      throw Exception();
    }
  }
}
