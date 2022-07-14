import 'package:flutter/material.dart';

void main(){
  runApp(
      MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              brightness: Brightness.light,
              primaryColor: Colors.blue,
              accentColor: Colors.orange
          ),
          home: MyApp()
      ));

}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List users = [];

  @override
  void initState(){
    users = [
      'maisem',
      'med aziz',
      'med salmen'
    ];
    super.initState() ;

  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("list of users"),
      ),
      body: ListView.builder(itemCount: users.length,itemBuilder: (BuildContext context,int index){
        return Dismissible(key:Key(users[index]),
          background: Container(
            alignment: AlignmentDirectional.centerEnd,
            color: Colors.red,
            child: Icon(Icons.delete,color: Colors.blue,),
          ),
          onDismissed: (direction){
            setState(()=>
                users.removeAt(index));
          }
          ,
          child: Card(
            elevation: 8,
            shadowColor: Colors.black,
            margin: EdgeInsets.all(8),
            shape:RoundedRectangleBorder( borderRadius: BorderRadius.circular(8)),
            child: ListTile(title:Text(users[index]),
              trailing: IconButton(icon: Icon(Icons.delete,color: Colors.blue,),onPressed: ()=>{
                setState(()=>users.removeAt(index))
              },),
              subtitle: Text('subtitle'),
              leading:Icon(Icons.supervised_user_circle),
            ),

          ),

        );
      }),
    );
  }
}


