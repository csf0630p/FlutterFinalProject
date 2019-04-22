import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'new_post_activity.dart';
import 'posts.dart';
import 'authentication.dart';
import 'post_detail_activity.dart';

class GetPosts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _GetPostsState();
  }
}

class _GetPostsState extends State<GetPosts> {
  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('trade').snapshots(),
      builder: (context, snapshot){
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        }
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return new ListView(
      padding: const EdgeInsets.all(12.0),
      children: snapshot.map((data) => _buildItem(context, data)).toList(),
    );
  }

  Widget _buildItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);
    PostDetail postItem = new PostDetail(record.title, record.price, record.description, record.photos);

    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: new Text(
                  '\$${record.price}',
                  style: new TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  )
              ),
              title: new Text(
                  '${record.title}',
                  style: new TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  )
              ),
              subtitle: new Text(
                  '${record.description}',
                  maxLines: 3,
                  style: new TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  )
              ),
            ),

            ButtonTheme.bar(
              child: ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: const Text('View Detail'),
                    onPressed: (){
                      Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                        return DetailPage(postDetail: postItem);
                      }));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class ToPostPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _ToPostPageState();
  }
}

class _ToPostPageState extends State<ToPostPage> {
  @override
  Widget build(BuildContext context) {
    return new FloatingActionButton(
        child: Icon(Icons.add),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        elevation: 7.0,
        highlightElevation: 14.0,
        onPressed: () {
          Navigator.of(context).pushNamed(PostPage.routeName);
        }
    );
  }
}

class BrowsePage extends StatefulWidget {
  static String routeName = "/browsePage";

  @override
  State<StatefulWidget> createState() {
    return new _BrowsePageState();
  }
}

class _BrowsePageState extends State<BrowsePage> {
  var _browseScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _browseScaffoldKey,
      appBar: new AppBar(
        title: new Text("Selling:", style: new TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        iconTheme: new IconThemeData(color: Colors.white),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(LoginPage.routeName, (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
      body: GetPosts(),
      floatingActionButton: ToPostPage(),
    );
  }
}