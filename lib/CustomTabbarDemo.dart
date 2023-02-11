import 'package:flutter/material.dart';
import 'package:flutter_custom_tab_bar/custom_tab_bar.dart';
import 'package:flutter_custom_tab_bar/indicator/custom_indicator.dart';
import 'package:flutter_custom_tab_bar/indicator/round_indicator.dart';
import 'package:flutter_custom_tab_bar/transform/color_transform.dart';
import 'package:matrimonial_app/Ui/Home_screen/Home/HomeScreenDetail/basic_ddetail.dart';
import 'package:matrimonial_app/Ui/Home_screen/Home/HomeScreenDetail/lookinfor_detail.dart';

class VerticalRoundTabBarPage extends StatefulWidget {
  VerticalRoundTabBarPage({Key? key}) : super(key: key);

  @override
  _VerticalRoundTabBarPageState createState() =>
      _VerticalRoundTabBarPageState();
}

class _VerticalRoundTabBarPageState extends State<VerticalRoundTabBarPage> {
  final int pageCount = 6;
  late PageController _controller = PageController(initialPage: 0);
  CustomTabBarController _tabBarController = CustomTabBarController();

  List tab = [
    "a",
    "a",
    "a",
    "a",
    "a",
    "a",
  ];

  @override
  void initState() {
    super.initState();
  }

  Widget getTabbarChild(BuildContext context, int index) {
    return TabBarItem(
        transform: ColorsTransform(
            highlightColor: Colors.white,
            normalColor: Colors.black,
            builder: (context, color) {
              return Container(
                  padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                  alignment: Alignment.center,
                  constraints: BoxConstraints(minHeight: 35),
                  child: Text(tab[index]));
            }),
        index: index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Column(
        children: [
          CustomTabBar(
            height: 80,
            tabBarController: _tabBarController,
            direction: Axis.horizontal,
            itemCount: pageCount,
            builder: getTabbarChild,
            indicator: RoundIndicator(
              color: Colors.red,
              top: 2.5,
              bottom: 2.5,
              left: 2.5,
              right: 2.5,
              radius: BorderRadius.circular(5),
            ),
            pageController: _controller,
          ),
          Expanded(
              child: PageView.builder(
                  scrollDirection: Axis.vertical,
                  controller: _controller,
                  itemCount: pageCount,
                  itemBuilder: (context, index) {
                    return PageItem(index);
                  })),
        ],
      ),
    );
  }
}

class PageItem extends StatefulWidget {
  final int index;
  PageItem(this.index, {Key? key}) : super(key: key);

  @override
  _PageItemState createState() => _PageItemState();
}

class _PageItemState extends State<PageItem>
    with AutomaticKeepAliveClientMixin {
  List tabName = [
    Basic_DDetail(),
    Looking_Detail(),
    Basic_DDetail(),
    Looking_Detail(),
    Basic_DDetail(),
    Looking_Detail(),
  ];
  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('build index:${widget.index} page');
    return Container(
      child: tabName[widget.index], 
      
      alignment: Alignment.center,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
