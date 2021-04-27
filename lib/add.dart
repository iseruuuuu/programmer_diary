import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';


// リスト追加画面用Widget
class TodoAddPage extends StatefulWidget {

  @override
  _TodoAddPageState createState() => _TodoAddPageState();
}

class _TodoAddPageState extends State<TodoAddPage> {

  //TODO 今日の日付を記載 達成
  //TODO 文字を打つときのエラーをなくす達成
  //TODO textfledを広くする。達成
  //TODO Listの高さを設定達成

  //TODO


  //TODO やることリスト

  //TODO Listを押すと開く感じにしたい。
  //TODO ツイート画面を開きたい。
  //TODO ListのなかにボタンをつけてTwiterを押す。
  //TODO 写真もあげられるようにできたらいいな
  //TODO 以前使用したshare機能を使用する？？
  //TODO
  //TODO


  String _text = '';


  //TODO Twitterようにする。
  //TODO ハッシュタグを固定？？
  //TODO 自由に選択できたらいいな。




  //TODO とりあえず、しっかりとシェアをすることができた！！！　　　　達成！！
  //TODO 保存する。　　　　　　　　　　　　　　　　　　　　　　　　　達成！！


  //TODO 削除機能


  String hashtag = '#駆け出しエンジニア #駆け出しエンジニアと繋がりたい #今日の積み上げ';

  bool cancel = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // *** 追加する部分 ***
      appBar: AppBar(
        title: Text('リスト追加'),
      ),
      // *** 追加する部分 ***
      body:  GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          reverse: true,
          child: Container(
            // 余白を付ける
            padding: EdgeInsets.only(top: 50, left: 30,right: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Text('', style: TextStyle(color: Colors.blue),),
                const SizedBox(height: 8,),
                //TODO 他を押すとtextfieldを閉じるようにする
                // テキスト入力
                Container(
                  height: 300,
                  color: Color(0xffeeeeee),
                  padding: EdgeInsets.all(10.0),
                  child: new ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 200.0,
                    ),
                    child: new Scrollbar(
                      child: new SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        reverse: true,
                        child: SizedBox(
                          height: 190.0,
                          child: TextField(
                            maxLines: 10,
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                            ),
                            onChanged: (String value) {
                              setState(() {
                                _text  = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  // 横幅いっぱいに広げる
                  width: double.infinity,
                  // リスト追加ボタン
                  child: ElevatedButton(
                    onPressed: () {
                      //TODO ダイアログを出す
                      if (cancel == true) {
                        var now = new DateTime.now();
                        var formatter = new DateFormat('yyyy/MM/dd  HH:mm');
                        String formattedDate = formatter.format(
                            now); // 2016-01-25
                        final post = '\n'
                            '$formattedDate \n'
                            '\n'
                            '$_text';
                        Navigator.of(context).pop(post);
                      }else{
                        showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: Center(child: Text("\n"
                                  "ツイートしましたか？",style: TextStyle(color: Colors.black),)),
                              content: Text("リストの追加の前にツイートしておくことをオススメします。"),
                              actions: <Widget>[
                                // ボタン領域
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 20,left: 0),
                                        child: TextButton(
                                          child: Text("ツイートする",style: TextStyle(fontSize: 15),),
                                          onPressed: () => Navigator.pop(context),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 0,left: 20),
                                        child: TextButton(
                                          child: Text("リストに追加",style: TextStyle(fontSize: 15),),
                                          onPressed: () {
                                            cancel = true;
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Text('リスト追加', style: TextStyle(color: Colors.white)),
                  ),

                ),
                const SizedBox(height: 8),

                Container(
                  // 横幅いっぱいに広げる
                  width: double.infinity,
                  // キャンセルボタン
                  child: TextButton(
                    // ボタンをクリックした時の処理
                    onPressed: () {
                      share();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(EvaIcons.twitter),
                          SizedBox(width: 10.0),
                          Text('Twitterにシェア'),
                        ],
                      ),
                    ),
                  ),
                ),


                Container(
                  // 横幅いっぱいに広げる
                  width: double.infinity,
                  // キャンセルボタン
                  child: TextButton(
                    // ボタンをクリックした時の処理
                    onPressed: () {
                      //TODO キャンセルダイアログを出す
                      Navigator.of(context).pop();
                    },
                    child: Text('キャンセル'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void openTwitter() async {
    var post = '$_text $hashtag';
    //プレイヤーのツイート画面を開きたい。
    final url = 'twitter://user';
    await launch(url);
  }

  void share() {
    var post = '$_text $hashtag';
    Share.share(post);
  }
}


/*
TextButton(
                        // ボタンをクリックした時の処理
                        onPressed: () {
                          var postt = todoList[index];

                          var post =  '$postt  \n'
                              '\n'
                              '$hashtag';
                          Share.share(post);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 30),
                          child: Row(
                            children: [
                              Icon(EvaIcons.twitter),
                              SizedBox(width: 10.0),
                              Text('Twitterにシェア'),
                            ],
                          ),
                        ),
                      ),
 */