import 'package:cached_network_image/cached_network_image.dart';
import 'package:evermos/core/config_size.dart';
import 'package:evermos/models/photo.dart';
import 'package:evermos/ui/photos/view/photo_detail.dart';
import 'package:flutter/material.dart';

import 'bottom_loader.dart';

class PhotosListItem extends StatelessWidget {
  const PhotosListItem({Key? key, required this.photo}) : super(key: key);

  final Photos photo;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Material(
      child: ListTile(
        leading: SizedBox(
          width: SizeConfig.safeBlockHorizontal * 25,
          height: SizeConfig.safeBlockHorizontal * 25,
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
        contentPadding: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 8,
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PhotoDetail(photo: photo)));
        },
      ),
    );
  }
}
