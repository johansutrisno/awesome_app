import 'package:cached_network_image/cached_network_image.dart';
import 'package:evermos/models/photo.dart';
import 'package:flutter/material.dart';

import 'bottom_loader.dart';

class PhotosListItem extends StatelessWidget {
  const PhotosListItem({Key? key, required this.photo}) : super(key: key);

  final Photos photo;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      child: ListTile(
        leading: SizedBox(
          width: size.width / 6,
          height: size.width / 6,
          child: CachedNetworkImage(
            imageUrl: photo.src.small,
            placeholder: (context, url) => ProgressLoader(),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.fill,
          ),
        ),
        title: Text(photo.photographer),
        isThreeLine: true,
        subtitle: Text(photo.url),
        dense: true,
        onTap: () {},
      ),
    );
  }
}
