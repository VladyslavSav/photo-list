import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/photo/photo_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/photo/photo_bloc.dart';
import '../bloc/photo/photo_state.dart';
import '../models/photo.dart';

class PhotoList extends StatefulWidget {
  final BoxConstraints _constrains;

  PhotoList(this._constrains);

  @override
  _PhotoListState createState() => _PhotoListState();
}

class _PhotoListState extends State<PhotoList> {
  @override
  Widget build(BuildContext context) {
    context.read<PhotoBloc>().add(FetchPhotoEvent());
    return BlocBuilder<PhotoBloc, PhotoState>(
      builder: (context, state) {
        if (state is FetchedState) {
          return ListView.builder(
            itemCount: state.photoList.length,
            itemBuilder: (context, index) {
              return Padding(
                child: _buildPhoto(state.photoList[index]),
                padding: const EdgeInsets.all(2),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
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
}
