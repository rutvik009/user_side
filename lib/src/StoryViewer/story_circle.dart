import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/account_screen.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/src/StoryViewer/full_page_view.dart';
import 'package:matrimonial_app/src/StoryViewer/stories_for_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoryCircle extends StatefulWidget {
  final List<StoryItem>? story;
  final int? selectedIndex;
  final TextStyle? storyCircleTextStyle;
  final Color? highLightColor;
  final double? circleRadius;
  final double? circlePadding;
  final double? borderThickness;
  final TextStyle? fullPagetitleStyle;
  final Color? paddingColor;

  /// Choose whether progress has to be shown
  final bool? displayProgress;

  /// Color for visited region in progress indicator
  final Color? fullpageVisitedColor;

  /// Color for non visited region in progress indicator
  final Color? fullpageUnvisitedColor;

  /// Horizontal space between stories
  final double? spaceBetweenStories;

  /// Whether image has to be show on top left of the page
  final bool? showThumbnailOnFullPage;

  /// Size of the top left image
  final double? fullpageThumbnailSize;

  /// Whether image has to be show on top left of the page
  final bool? showStoryNameOnFullPage;

  /// Status bar color in full view of story
  final Color? storyStatusBarColor;

  /// Function to run when page changes
  final Function? onPageChanged;

  /// Duration after which next story is displayed
  /// Default value is infinite.
  final Duration? autoPlayDuration;

  /// Show story name on main page
  final bool showStoryName;

  StoryCircle({
    Key? key,
    this.story,
    this.selectedIndex,
    this.storyCircleTextStyle,
    this.highLightColor,
    this.circleRadius,
    this.circlePadding,
    this.borderThickness,
    this.fullPagetitleStyle,
    this.paddingColor,
    this.displayProgress,
    this.fullpageVisitedColor,
    this.fullpageUnvisitedColor,
    this.spaceBetweenStories,
    this.showThumbnailOnFullPage,
    this.fullpageThumbnailSize,
    this.showStoryNameOnFullPage,
    this.storyStatusBarColor,
    this.onPageChanged,
    this.autoPlayDuration,
    this.showStoryName = true,
  }) : super(key: key);

  @override
  State<StoryCircle> createState() => _StoryCircleState();
}

class _StoryCircleState extends State<StoryCircle> {
  List chatData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getChats();
  }

  @override
  Widget build(BuildContext context) {
    double? altRadius = 27;
    double altPadding;
    if (widget.circleRadius != null) {
      altRadius = widget.circleRadius;
    }
    if (widget.circlePadding != null) {
      altPadding = altRadius! + widget.circlePadding!;
    } else {
      altPadding = altRadius! + 3;
    }
    return Container(
        margin: EdgeInsets.fromLTRB(
          widget.spaceBetweenStories ?? 5,
          0,
          widget.spaceBetweenStories ?? 5,
          10,
        ),
        child: (chatData.isNotEmpty)
            ? (chatData[widget.selectedIndex!]['isMsg'] != null)
                ? Column(
                    children: <Widget>[
                      const SizedBox(height: 7),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => FullPageView(
                                  storiesMapList: widget.story,
                                  storyNumber: widget.selectedIndex,
                                  fullPagetitleStyle: widget.fullPagetitleStyle,
                                  displayProgress: widget.displayProgress,
                                  fullpageVisitedColor:
                                      widget.fullpageVisitedColor,
                                  fullpageUnvisitedColor:
                                      widget.fullpageUnvisitedColor,
                                  fullpageThumbnailSize:
                                      widget.fullpageThumbnailSize,
                                  showStoryNameOnFullPage:
                                      widget.showStoryNameOnFullPage,
                                  showThumbnailOnFullPage:
                                      widget.showThumbnailOnFullPage,
                                  storyStatusBarColor:
                                      widget.storyStatusBarColor,
                                  onPageChanged: widget.onPageChanged,
                                  autoPlayDuration: widget.autoPlayDuration,
                                ),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            radius: widget.borderThickness != null
                                ? altPadding + widget.borderThickness!
                                : altPadding + 1.5,
                            backgroundColor:
                                widget.highLightColor ?? currentColor,
                            // const Color(0xffcc306C),
                            child: CircleAvatar(
                              backgroundColor:
                                  widget.paddingColor ?? Colors.white,
                              radius: altPadding,
                              child: (chatData[widget.selectedIndex!]
                                          ['userProfile'] !=
                                      "")
                                  ? CircleAvatar(
                                      radius: altRadius,
                                      backgroundColor: Colors.white,
                                      backgroundImage: widget
                                          .story![widget.selectedIndex!]
                                          .thumbnail)
                                  : CircleAvatar(
                                      radius: altRadius,
                                      backgroundColor: Colors.white,
                                      backgroundImage:
                                          AssetImage(ImagePath.userdefault)),
                            ),
                          )),
                      const SizedBox(height: 5),
                      widget.showStoryName
                          ? Container(
                              // color: Colors.amber,
                              width: 70 /* altPadding  + 2.5 */,
                              alignment: Alignment.center,
                              child: Text(
                                widget.story![widget.selectedIndex!].name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: widget.storyCircleTextStyle ??
                                    const TextStyle(fontSize: 13),
                              ),
                            )
                          : const Center()
                    ],
                  )
                : Center()
            : Center());
  }

  void getChats() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = await prefs.getString(USER_ID)!;

    firestore.collection("Users").doc(userId).get().then((value) {
      setState(() {
        chatData = value.data()!["chats"] ?? [];
      });
    });
  }
}
