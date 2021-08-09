import 'package:cached_network_image/cached_network_image.dart';
import 'package:evermos/core/config_size.dart';
import 'package:evermos/models/photo.dart';
import 'package:evermos/ui/photos/view/photo_detail.dart';
import 'package:flutter/material.dart';

import 'progress_loader.dart';

class PhotosListItem extends StatelessWidget {
  const PhotosListItem({Key? key, required this.photo}) : super(key: key);

  final Photos photo;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PhotoDetail(photo: photo)));
      },
      child: Container(
        margin: EdgeInsets.all(SizeConfig.defaultMargin),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: SizeConfig.safeBlockHorizontal * 25,
              height: SizeConfig.safeBlockHorizontal * 25,
              child: CachedNetworkImage(
                imageUrl: photo.src.small,
                // placeholder: (context, url) => ProgressLoader(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              width: SizeConfig.defaultMargin,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    photo.photographer,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Average color : ${photo.avgColor}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    'Width : ${photo.width}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    'Height : ${photo.height}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
