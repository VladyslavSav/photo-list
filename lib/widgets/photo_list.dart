import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../bloc/photo_bloc.dart';
import '../bloc/photo_event.dart';
import '../models/photo.dart';

class PhotoList extends StatefulWidget {
  final BoxConstraints _constrains;

  PhotoList(this._constrains);

  @override
  _PhotoListState createState() => _PhotoListState();
}

class _PhotoListState extends State<PhotoList> {
  final PhotoBloc _photoBloc = PhotoBloc();
  @override
  Widget build(BuildContext context) {
    _photoBloc.fetchProces.add(PhotoEvent.Fetch);
    return StreamBuilder<List<Photo>>(
      stream: _photoBloc.fetch,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return Padding(
                child: _buildPhoto(snapshot.data[index]),
                padding: const EdgeInsets.all(2),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildPhoto(Photo photo) {
    return Image.network(
      photo.url,
      fit: BoxFit.fill,
      loadingBuilder: (context, child, loadingProgress) {
        return (loadingProgress == null)
            ? child
            : Container(
                width: double.infinity,
                height: widget._constrains.maxHeight * 0.2,
                child: Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes
                        : null,
                  ),
                ),
              );
      },
    );
  }

  @override
  void dispose() {
    _photoBloc.dispose();
    super.dispose();
  }
}
