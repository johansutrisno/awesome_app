import 'package:cached_network_image/cached_network_image.dart';
import 'package:evermos/core/config_size.dart';
import 'package:evermos/models/photo.dart';
import 'package:evermos/ui/photos/widgets/bottom_loader.dart';
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
                child: Text(photo.photographer),
              ),
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
