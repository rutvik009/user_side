import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class Skeleton_Discover extends StatefulWidget {
  const Skeleton_Discover({Key? key}) : super(key: key);

  @override
  State<Skeleton_Discover> createState() => _Skeleton_DiscoverState();
}

class _Skeleton_DiscoverState extends State<Skeleton_Discover> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SkeletonItem(
            child: Column(
              children: [
                SkeletonLine(
                  style: SkeletonLineStyle(height: 50),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SkeletonParagraph(
                    style: SkeletonParagraphStyle(
                        lines: 1,
                        spacing: 6,
                        lineStyle: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2,
                          borderRadius: BorderRadius.circular(8),
                        )),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                            shape: BoxShape.circle, width: 60, height: 60)),
                    SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                            shape: BoxShape.circle, width: 60, height: 60)),
                    SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                            shape: BoxShape.circle, width: 60, height: 60)),
                    SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                            shape: BoxShape.circle, width: 60, height: 60)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                        borderRadius: BorderRadius.circular(15),
                        width: double.infinity,
                        height: 200),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: SkeletonLine(
                    style: SkeletonLineStyle(
                      height: 50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SkeletonAvatar(
                        style: SkeletonAvatarStyle(width: 111, height: 30)),
                    SkeletonAvatar(
                        style: SkeletonAvatarStyle(width: 111, height: 30)),
                    SkeletonAvatar(
                        style: SkeletonAvatarStyle(width: 111, height: 30)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SkeletonParagraph(
                    style: SkeletonParagraphStyle(
                        lines: 1,
                        spacing: 6,
                        lineStyle: SkeletonLineStyle(
                          // randomLength: true,
                          height: 10,
                          width: MediaQuery.of(context).size.width / 3,
                          borderRadius: BorderRadius.circular(8),
                        )),
                  ),
                ),
                GridView.builder(
                  itemCount: 4,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 17.0,
                    mainAxisSpacing: 17.0,
                    mainAxisExtent: 235,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 210,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
