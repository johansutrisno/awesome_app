import 'package:cached_network_image/cached_network_image.dart';
import 'package:evermos/core/config_size.dart';
import 'package:evermos/models/photo.dart';
import 'package:evermos/ui/photos/widgets/progress_loader.dart';
import 'package:flutter/material.dart';

class PhotoDetail extends StatelessWidget {
  const PhotoDetail({Key? key, required this.photo}) : super(key: key);

  final Photos photo;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: SizeConfig.safeBlockVertical * 50,
            title: Text('Detail ${photo.photographer}'),
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: photo.src.large2x,
                placeholder: (context, url) => ProgressLoader(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: const EdgeInsets.all(SizeConfig.defaultMargin),
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
              ),
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
