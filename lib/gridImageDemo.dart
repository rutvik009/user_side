import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GridImageDemo extends StatefulWidget {
  const GridImageDemo({Key? key}) : super(key: key);

  @override
  State<GridImageDemo> createState() => _GridImageDemoState();
}

class _GridImageDemoState extends State<GridImageDemo> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
            child: StaggeredGridView.countBuilder(
        itemCount: null,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        shrinkWrap: true,
        itemBuilder: (context, index) {
            return (index % 5 == 0)
                ? Container(
                    height: 100,
                    width: 100,
                    color: Colors.blueAccent,
                    child: Text("hello"),
                  )
                : Container(
                    height: 100,
                    width: 100,
                    color: Colors.blueGrey,
                    child: Text("Hey"),
                  );
        },
        staggeredTileBuilder: (index) {
            StaggeredTile.count(2, index % 5 == 0 ? 2 : 1);
        },
      ),
          )),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.index,
    this.extent,
    this.backgroundColor,
    this.bottomSpace,
  }) : super(key: key);

  final int index;
  final double? extent;
  final double? bottomSpace;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final child = Container(
      color: Colors.blue,
      height: extent,
      child: Center(
        child: CircleAvatar(
          minRadius: 20,
          maxRadius: 20,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          child: Text('$index', style: const TextStyle(fontSize: 20)),
        ),
      ),
    );

    if (bottomSpace == null) {
      return child;
    }

    return Column(
      children: [
        Expanded(child: child),
        Container(
          height: bottomSpace,
          color: Colors.green,
        )
      ],
    );
  }
}
