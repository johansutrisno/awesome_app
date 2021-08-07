import 'package:evermos/ui/photos/bloc/photo_bloc.dart';
import 'package:evermos/ui/photos/widgets/bottom_loader.dart';
import 'package:evermos/ui/photos/widgets/photos_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotosList extends StatefulWidget {
  const PhotosList({Key? key}) : super(key: key);

  @override
  _PhotosListState createState() => _PhotosListState();
}

class _PhotosListState extends State<PhotosList> {
  final _scrollController = ScrollController();
  late PhotoBloc _photoBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _photoBloc = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotoBloc, PhotoState>(
      builder: (context, state) {
        switch (state.status) {
          case PhotoStatus.success:
            if (state.photos.isEmpty) {
              return const Center(child: Text('no photos'));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.photos.length
                    ? ProgressLoader()
                    : PhotosListItem(photo: state.photos[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.photos.length
                  : state.photos.length + 1,
              controller: _scrollController,
            );
          case PhotoStatus.failure:
            return const Center(child: Text('failed to fetch photos'));
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _onScroll() {
    if (_isBottom) _photoBloc.add(PhotoFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= maxScroll;
  }
}
