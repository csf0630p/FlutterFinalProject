import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'new_post_activity.dart';
import 'posts.dart';
import 'authentication.dart';

class PhotoHeroAnimation extends StatelessWidget {
  const PhotoHeroAnimation({
    Key key, this.photo, this.onTap, this.width
  }) : super(key: key);

  final String photo;
  final VoidCallback onTap;
  final double width;

  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: photo,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.network(
              photo,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

class DetailPage extends StatefulWidget {
  final PostDetail postDetail;
  static String routeName = "/detailPage";

  const DetailPage({
    Key key,
    @required this.postDetail,
  }) : super(key : key);

  @override
  State<StatefulWidget> createState() {
    return new _detailPageState(postDetail);
  }
}

class _detailPageState extends State<DetailPage> {
  PostDetail postDetail;

  _detailPageState(PostDetail postDetail) {
    this.postDetail = postDetail;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Details:", style: new TextStyle(color: Colors.white)),
      ),

      body: new Column(
        children: <Widget>[
          titleSection(),
          Expanded(
            child : new Container(
              margin: new EdgeInsets.symmetric(vertical: 10),
              height: 500,
              child: photoSection(),
            ),
          ),
        ],
      ),
    );
  }

  Widget titleSection() {
    return new Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Row(
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                    '\$${postDetail.price}',
                    style: new TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    )
                ),
              ),
            ],
          ),
          new Row(
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                    '${postDetail.title}',
                    style: new TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    )
                ),
              ),
            ],
          ),
          new Text(
              '${postDetail.description}',
              textAlign: TextAlign.left,
              style: new TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,

              )
          ),
        ],
      ),
    );
  }

  Widget photoSection() {

    return  GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 5,
      primary: false,
      children: _getGrid(),
      shrinkWrap: true,
    );

  }

  List<Widget> _getGrid() {
    List<Widget> gridList = new List();
    List<String> photoList = postDetail.pathList;
    for (int i = 0; i < photoList.length; i++) {
      gridList.add(photoGridItem(photoList[i]));
    }
    return gridList;
  }

  Widget photoGridItem(String path) {
    return Container(
      child: PhotoHeroAnimation(
        photo: path,
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('Photo:'),
                  ),
                  body: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.center,
                    child: PhotoHeroAnimation(
                      photo: path,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                );
              }
          ));
        },
      ),
    );
  }
}