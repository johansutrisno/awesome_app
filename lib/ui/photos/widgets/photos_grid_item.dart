import 'package:cached_network_image/cached_network_image.dart';
import 'package:evermos/core/config_size.dart';
import 'package:evermos/models/photo.dart';
import 'package:evermos/ui/photos/widgets/bottom_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhotosGridItem extends StatelessWidget {
  const PhotosGridItem({Key? key, required this.photo}) : super(key: key);

  final Photos photo;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Material(
      child: ListTile(
        title: SizedBox(
          width: SizeConfig.safeBlockHorizontal * 100,
          height: SizeConfig.safeBlockHorizontal * 100,
          child: CachedNetworkImage(
            imageUrl: photo.src.small,
            // placeholder: (context, url) => ProgressLoader(),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.fill,
          ),
        ),
        isThreeLine: true,
        subtitle: Text(photo.url),
        dense: true,
        contentPadding: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 8,
        ),
        onTap: () {},
      ),
    );
  }
}
