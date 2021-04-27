import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';



import 'add.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

//TODO ハッシュタグ用のテキストフィールドを作成　達成
//TODO 日付を設定。　達成

//TODO 保存する　　　　　　最優先！！！
//TODO 削除機能をつける　　リリース後でもあり
//TODO 編集機能をつける　　リリース後でもあり
//TODO シェアをする内容がおかしい？？ []がいらない。
//TODO 全ての内容がシェアされてしまう。 なんとかして分ける。

//TODO セルを開いた後にシェアをするといい？？

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child :TodoListPage(),
      ),
    );
  }
}


class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}


class _TodoListPageState extends State<TodoListPage> {
  // Todoリストのデータ
  List<String> todoList = [];
  String hashtag = '#駆け出しエンジニア #駆け出しエンジニアと繋がりたい #今日の積み上げ';

  Future<void> sharePrefrence() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.setStringList('key', todoList);
  }


  _getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 以下の「counter」がキー名。見つからなければ０を返す
    setState(() {
      todoList = prefs.getStringList('key') ?? 0;
    });
  }

  @override
  void initState() {
    super.initState();
    _getPrefItems();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    setState(() {
      sharePrefrence();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('リスト一覧'),
      ),
      body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key(todoList[index]),
              onDismissed: (direction) {
                setState(() {
                  todoList.removeAt(index);
                });
                if (direction == DismissDirection.endToStart) {
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text("削除しました"))
                  );
                }
              },

              child: SizedBox(
                //TODO 折り畳みが理想。
                height: 300,
                child: Card(
                  child: ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(todoList[index]),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          final newListText = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return TodoAddPage();
            }),
          );
          if (newListText != null) {
            setState(() {
              todoList.add(newListText);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }




  void share() {
    //var post = '$_text $hashtag';
    var post =  '$todoList \n'
        '\n'
        '$hashtag';
    Share.share(post);
  }
}


