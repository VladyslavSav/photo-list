import '../../models/photo.dart';

abstract class PhotoState {}

class FetchingState extends PhotoState {}

class FetchedState extends PhotoState {
  final List<Photo> photoList;
  FetchedState(this.photoList);
}
