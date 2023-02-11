import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class StoryView extends StatefulWidget {
  final List<String> story;
  final List<String>? hobbies;
  var aboutMe;

  StoryView({required this.story, required this.aboutMe, this.hobbies});

  @override
  State<StoryView> createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryView> {
  CarouselController carouselController = CarouselController();
  int currentPage = 0;
  int selectIndex = 0;

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
                    print("index :: $currentPage");
                  },
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
                        fit: BoxFit.fitHeight,
                        alignment: Alignment.center,
                        filterQuality: FilterQuality.high,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                Center(child: CircularProgressIndicator()),
                      ),
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
            (currentPage == 0)
                ? (widget.aboutMe != null)
                    ? Positioned(
                        bottom: 0,
                        child: Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            gradient: LinearGradient(
                              tileMode: TileMode.mirror,
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0, 0.2, 0.7, 1],
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.2),
                                Colors.black.withOpacity(0.6),
                                Colors.black.withOpacity(0.9),
                              ],
                            ),
                          ),
                          child: Container(
                              padding: EdgeInsets.only(
                                  top: 3, bottom: 3, right: 20, left: 20),
                              alignment: Alignment.center,
                              child: Text(
                                widget.aboutMe,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              color: Colors.transparent
                              // Color(0xff000000).withOpacity(0.5),
                              ),
                        ),
                      )
                    : Container()
                : (currentPage == 1)
                    ? Positioned(
                        bottom: 30,
                        child: Container(
                            // height: 100,
                            width: MediaQuery.of(context).size.width,
                            // color: Colors.amber,
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Column(
                                children: [
                                  Wrap(
                                    runSpacing: 8,
                                    spacing: 12,
                                    alignment: WrapAlignment.center,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: List.generate(
                                        widget.hobbies!.length,
                                        (index) => Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: Color(0xff000000)
                                                .withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(
                                                    left: 15,
                                                    right: 15,
                                                    top: 8,
                                                    bottom: 10),
                                            child: Text(
                                              widget.hobbies![index],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                          ),
                                        )),
                                  )
                                ],
                              ),
                            )
                            /* Row(
                            children: [
                              Flexible(
                                child: Wrap(
                                    children: List.generate(
                                  widget.hobbies!.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 8, bottom: 8),
                                    child: Container(
                                      height: 35,
                                      width: MediaQuery.of(context).size.width / 3.5,
                                      // padding: EdgeInsets.only(
                                      //     left: 10, right: 10),
                                      // width: widget.hobbies![index].characters.length
                                      //         .toDouble() *
                                      //     16,
                                      decoration: BoxDecoration(
                                        color: Color(0xff000000)
                                            .withOpacity(0.5),
                                        borderRadius:
                                            BorderRadius.circular(20),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        widget.hobbies![index],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ),
                                )),
                              ),
                            ],
                          ), */
                            /* Wrap(
                            children: List.generate(
                                widget.hobbies!.length,
                                (index) => Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 8, bottom: 8),
                                      child: Container(
                                        height: 35,
                                        // padding: EdgeInsets.only(
                                        //     left: 10, right: 10),
                                        width: widget.hobbies![index].characters
                                                .length
                                                .toDouble() *
                                            16,
                                        decoration: BoxDecoration(
                                          color: Color(0xff000000)
                                              .withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              widget.hobbies![index],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            )
                                          ],
                                        ),
                                      ),
                                    )),
                          ), */
                            ),
                      )
                    : Container(),
          ],
        ),
      ),
    );
  }
}
