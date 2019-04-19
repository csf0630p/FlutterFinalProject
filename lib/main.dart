import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() {
  debugPaintSizeEnabled = false;      //打开视觉调试开关
  runApp(new MaterialApp(
    title: 'Forms in Flutter',
    home: new HyperGarageSalePage(),
  ));
} // ignore: expected_token

class HyperGarageSalePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HyperGarageSalePageState();
}

class _HyperGarageSalePageState extends State<HyperGarageSalePage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('HyperGarageSale'),
      ),
      body: new Container(
          padding: new EdgeInsets.all(20.0),
          child: new Form(
            key: this._formKey,
            child: new ListView(
              children: <Widget>[
                new TextFormField(
                    autofocus: true,
                    decoration: new InputDecoration(
                        hintText: 'Enter title of the item',
//                        labelText: 'Title'
                    )
                ),
                new TextFormField(
                    decoration: new InputDecoration(
                        hintText: 'Enter price',
//                        labelText: 'price'
                    )
                ),
                new TextFormField(
                    initialValue: '',
                    maxLines: 23,
                    textAlign: TextAlign.start,
                    decoration: new InputDecoration(
                        hintText: 'Enter description of the item',
//                        labelText: 'Description'
                    )
                ),
//第一种post右对齐实现方式, 固定像素间距
//                new Container(
//                  padding: new EdgeInsets.only(left: 256.0, right: 0.0),
//                  child: new RaisedButton(
//                    child: new Text(
//                      'POST',
//                    ),
//                    onPressed: () => null,
//                  ),
//                  margin: new EdgeInsets.only(
//                      top: 20.0
//                  ),
//                )
                new Container( // 第二种对齐, column + row
                  child: new Column(
//                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          new RaisedButton(
                            child: new Text(
                              'POST',
                            ),
                            onPressed: () => null,
                          ),
                        ],
                      )
                    ]
                  ),
                  margin: new EdgeInsets.only(
                      top: 20.0
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}