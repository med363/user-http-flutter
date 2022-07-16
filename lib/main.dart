import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main(){
  runApp(UserListApp()
     /* MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              brightness: Brightness.light,
              primaryColor: Colors.blue,
              accentColor: Colors.orange
          ),
          home: MyApp()*/
      );
  
}

/*add class user contain all information about it*/
class User{
  /*declare les attributs*/
  String fullname,username,imageUrl;
  /*constructor*/
  User(
       this.fullname,
      this.imageUrl,
      this.username
      );
  /*fetch data from json*/
  User.fromJson(Map<String,dynamic> json)
      : fullname = json['name']['first'] + '' + json['name']['last'],
        imageUrl = json['picture']['medium'],
        username = json['login']['username'];

}

class UserListApp extends StatefulWidget {
  const UserListApp({Key? key}) : super(key: key);

  @override
  State<UserListApp> createState() => _UserListAppState();
}

class _UserListAppState extends State<UserListApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text('User List'),),
          body: UserList(),
        )
    );
  }
}


class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  /*var boolean pour detecte que les donnees bien arrive*/
  late bool loading;
  List<User> users = [];

  @override
  void initState() {
    /*users = [
      'maisem',
      'med aziz',
      'med salmen'
    ];*/
    /*declare list of various users*/
    /*users = [
      User('maisem bent fouleen', '', 'maisem'),
      User('med aziz ben fouleen', '', 'med aziz'),
      User('med salmen ben fouleen', '', 'med salmen')
    ];*/
    /*declare variable initiallement*/
    /*list of user vide*/
    users = [];
    /*fetch user initialement true*/
    loading = true;
    /*class asynchrone pour get users*/
    loadUsers();

    super.initState();
  }

  void loadUsers() async {
    await Future.delayed(Duration(seconds: 2));
    final url = Uri.parse('https://randomuser.me/api/?results=20');
    final res = await http.get(url);
    final json = jsonDecode(res.body);
    /*list of users will rempl*/
    List<User> _users = [];
    /*parcours tab resultats in jso file*/
    for (var i in json['results']) {
      _users.add(User.fromJson(i));
    }
    setState(() {
      /*a chaque list of user doit etre remplir*/
      users = _users;
      /*stop charge de donnes*/
      loading = false;
    }

    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    /*   return Scaffold(
      appBar: AppBar(
        title: Text("list of users"),
      ),*/
    return ListView.builder(itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          /*declare qui va affiche fullname ou bien username*/
          return Dismissible(key: Key(users[index].fullname),
            background: Container(
              alignment: AlignmentDirectional.centerEnd,
              color: Colors.red,
              child: Icon(Icons.delete, color: Colors.blue,),
            ),
            onDismissed: (direction) {
              setState(() =>
                  users.removeAt(index));
            }
            ,
            child: Card(
              elevation: 8,
              shadowColor: Colors.black,
              margin: EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              /*declare qui va affiche fullname ou bien username*/
              child: ListTile(title: Text(users[index].fullname),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.blue,),
                  onPressed: () =>
                  {
                    setState(() => users.removeAt(index))
                  },),
                subtitle: Text(users[index].username),
                /*leading: Icon(Icons.supervised_user_circle),*/
                leading: CircleAvatar(backgroundImage: NetworkImage(users[index].imageUrl),),
              ),

            ),

          );
        }
    );
  }
}










