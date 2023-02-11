import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonLoader extends StatefulWidget {
  const SkeletonLoader({Key? key}) : super(key: key);

  @override
  State<SkeletonLoader> createState() => _SkeletonLoaderState();
}

class _SkeletonLoaderState extends State<SkeletonLoader> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: SkeletonItem(
        child: Column(
          children: [
            Stack(
              children: [
                SkeletonAvatar(
                  style:
                      SkeletonAvatarStyle(width: double.infinity, height: 300),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 255, left: 15),
                  child: Row(
                    children: [
                      SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                            shape: BoxShape.circle, width: 100, height: 100),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 45),
                          child: SkeletonParagraph(
                            style: SkeletonParagraphStyle(
                                lines: 3,
                                spacing: 6,
                                lineStyle: SkeletonLineStyle(
                                  randomLength: true,
                                  height: 10,
                                  borderRadius: BorderRadius.circular(8),
                                  minLength:
                                      MediaQuery.of(context).size.width / 6,
                                  maxLength:
                                      MediaQuery.of(context).size.width / 3,
                                )),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    SkeletonAvatar(
                        style: SkeletonAvatarStyle(width: 30, height: 30)),
                    SizedBox(
                      height: 8,
                    ),
                    SkeletonAvatar(
                        style: SkeletonAvatarStyle(width: 111, height: 30)),
                  ],
                ),
                Column(
                  children: [
                    SkeletonAvatar(
                        style: SkeletonAvatarStyle(width: 30, height: 30)),
                    SizedBox(
                      height: 8,
                    ),
                    SkeletonAvatar(
                        style: SkeletonAvatarStyle(width: 111, height: 30)),
                  ],
                ),
                Column(
                  children: [
                    SkeletonAvatar(
                        style: SkeletonAvatarStyle(width: 30, height: 30)),
                    SizedBox(
                      height: 8,
                    ),
                    SkeletonAvatar(
                        style: SkeletonAvatarStyle(width: 111, height: 30)),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SkeletonParagraph(
                        style: SkeletonParagraphStyle(
                            lines: 1,
                            spacing: 6,
                            lineStyle: SkeletonLineStyle(
                              randomLength: true,
                              height: 10,width: 60,
                              borderRadius: BorderRadius.circular(8),
                              // minLength: 10.0,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                              shape: BoxShape.circle, width: 30, height: 30)),
                    ),
                  ],
                ),
                SkeletonParagraph(
                  style: SkeletonParagraphStyle(
                      lines: 1,
                      spacing: 6,
                      lineStyle: SkeletonLineStyle(
                        randomLength: true,
                        height: 10,
                        width: 60,
                        borderRadius: BorderRadius.circular(8),
                        // minLength: 10.0,
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SkeletonParagraph(
                        style: SkeletonParagraphStyle(
                            lines: 1,
                            spacing: 6,
                            lineStyle: SkeletonLineStyle(
                              randomLength: true,
                              height: 10,
                              borderRadius: BorderRadius.circular(8),
                              minLength: MediaQuery.of(context).size.width / 5,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                              shape: BoxShape.circle, width: 30, height: 30)),
                    ),
                  ],
                ),
                SkeletonParagraph(
                  style: SkeletonParagraphStyle(
                      lines: 1,
                      spacing: 6,
                      lineStyle: SkeletonLineStyle(
                        randomLength: true,
                        height: 10,
                        borderRadius: BorderRadius.circular(8),
                        minLength: MediaQuery.of(context).size.width / 4,
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            // basic details
            SkeletonLine(
              style: SkeletonLineStyle(height: 30),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // looking for
            SizedBox(
              height: 10,
            ),
            SkeletonLine(
              style: SkeletonLineStyle(height: 30),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            //contact detail
            SizedBox(
              height: 10,
            ),
            SkeletonLine(
              style: SkeletonLineStyle(height: 30),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // family details
            SizedBox(
              height: 10,
            ),
            SkeletonLine(
              style: SkeletonLineStyle(height: 30),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // career & education details
            SizedBox(
              height: 10,
            ),
            SkeletonLine(
              style: SkeletonLineStyle(height: 30),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // location detail
            SizedBox(
              height: 10,
            ),
            SkeletonLine(
              style: SkeletonLineStyle(height: 30),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // hobbies
            SizedBox(
              height: 10,
            ),
            SkeletonLine(
              style: SkeletonLineStyle(height: 30),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: MediaQuery.of(context).size.width / 2 - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
