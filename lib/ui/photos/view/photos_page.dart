import 'package:evermos/repository/repository_impl.dart';
import 'package:evermos/ui/photos/bloc/photo_bloc.dart';
import 'package:evermos/ui/photos/view/photos_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotosPage extends StatelessWidget {
  const PhotosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            PhotoBloc(repository: RepositoryImpl())..add(PhotoFetched()),
        child: PhotosList(),
      ),
    );
  }
}
