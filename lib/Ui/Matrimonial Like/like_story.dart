import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class LikeStoryView extends StatefulWidget {
  final List<String> story;

  LikeStoryView({required this.story});

  @override
  State<LikeStoryView> createState() => _LikeStoryViewState();
}

class _LikeStoryViewState extends State<LikeStoryView> {
  CarouselController carouselController = CarouselController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTapDown: (details) {
          var position = details.globalPosition;

          if (position.dx < MediaQuery.of(context).size.width / 2) {
            if (currentPage != 0) {
              carouselController.previousPage();
            } else {
              setState(() {
                currentPage = 0;
              });

              Navigator.pop(context);
            }
          } else {
            if (currentPage < widget.story.length - 1) {
              carouselController.nextPage();
            } else {
              setState(() {
                currentPage = 0;
              });

              Navigator.pop(context);
            }
          }
        },
        child: Stack(
          children: [
            CarouselSlider(
              carouselController: carouselController,
              options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  /* width: MediaQuery.of(context).size.width,*/
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  height: MediaQuery.of(context).size.height,
                  autoPlay: false,
                  enableInfiniteScroll: false),
              items: widget.story.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: CachedNetworkImage(
                        imageUrl: i,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                Center(child: CircularProgressIndicator()),
                      ),
                      /*   Image.network(i, fit: BoxFit.fill),*/
                    );
                  },
                );
              }).toList(),
            ),
            Container(
              height: 4,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 10.0, right: 10, top: 60),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.story.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Container(
                          child: Padding(
                            padding: EdgeInsets.all(
                                (MediaQuery.of(context).size.width) /
                                    (2.18 * widget.story.length)),
                            child: Text(
                              " ",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          color:
                              currentPage == index ? Colors.white : Colors.grey,
                        ),
                        SizedBox(
                          width: 5,
                        )
                      ],
                    );
                  }),
            ),
           
          ],
        ),
      ),
    );
  }
}
