import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/pages/AddTodo.dart';
import 'package:crud/pages/SignInPage.dart';
import 'package:crud/pages/TodoCard.dart';
import 'package:crud/services/Auth_Services.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthClass authClass = AuthClass();
  final Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection("todo").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          "Today's Schedule",
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        bottom: PreferredSize(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 22),
            child: Text(
              "Monday 21",
            style: TextStyle(
              fontSize: 33,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
            ),
            ),
          ),
          preferredSize: Size.fromHeight(35),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black38,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,size: 32, color: Colors.white,
              ),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (builder) => AddTodoPage(),));
              },
              child: Container(
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Colors.indigoAccent,
                      Colors.purple,
                    ]
                  )
                ),
                child: Icon(
                  Icons.add,size: 32, color: Colors.white,
                ),
              ),
            ),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,size: 32, color: Colors.white,
            ),
            title: Container(),
          ),
        ],
    ),
      body: FutureBuilder<List<Object>>(
        future: Conection(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return Text("Erro ao carregar os dados");
          }else if(snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index){
                  return TodoCard(
                    title: "Wake",
                    check: true,
                    iconBgColor: Colors.white,
                    iconData: Icons.alarm,
                    time: "10 PM",
                    inColor: Colors.red,
                  );
                });
          }
          return Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }

  Future<List<Object>> Conection() async{
    var base = await FirebaseFirestore.instance.collection("todo").get();

    List<Object> Dados = [];

    for(var doc in base.docs){
      Dados.add({
        "title": doc['title']
      });
    }
    return Dados;
  }

}






//
// AppBar(
// actions: [
// IconButton(
// onPressed: () async{
// await authClass.signOut();
// Navigator.pushAndRemoveUntil(context,
// MaterialPageRoute(builder: (builder)=>SignInPage()), (route) => false);
// },
// icon: Icon(Icons.logout),
// ),
// ],
// ),
