import 'package:evermos/ui/photos/bloc/photo_bloc.dart';
import 'package:evermos/ui/photos/view/photos_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotosPage extends StatelessWidget {
  const PhotosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photos'),
      ),
      body: BlocProvider(
        create: (context) => PhotoBloc()..add(PhotoFetched()),
        child: PhotosList(),
      ),
    );
  }
}
