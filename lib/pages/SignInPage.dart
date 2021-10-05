import 'package:crud/pages/HomePage.dart';
import 'package:crud/pages/SignUpPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class SignInPage extends StatefulWidget {
const SignInPage({Key? key}) : super(key: key);

@override
_SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  bool circular = false;

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width : MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Sign In",
            style: TextStyle(
              fontSize: 35,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            )
          ),
          SizedBox(height: 15),
          textItem("Email", emailController,false),
          SizedBox(height: 20,),
          textItem("senha",senhaController,true),
          SizedBox(height: 20,),
          bntSignUp(),
          SizedBox(height: 25,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "Voce não possui uma conta?",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder) => SignUpPage()), (route) => false);
                },
              child: Text(
                "Cadastre-se",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
              ),
            ],
          )
          ],
        ),
      ),
    )
  );
}

  Widget bntSignUp(){
    return InkWell(
      onTap: () async{
        setState(() {
          circular: true;
        });
        try{
          firebase_auth.UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(
              email: emailController.text, password: senhaController.text);
          print(userCredential.user!.email);
          setState(() {
            circular = false;
          });
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (builder) => HomePage()), (route) => false);
        }catch(e){
          final snackbar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          setState(() {
            circular = false;
          });
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 90,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
              colors: [Color(0xfff1029FA), Color(0xffff1730FA), Color(0xfff1B41FA)]),
        ),
        child: Center(
          child: circular?CircularProgressIndicator() :
          Text("Entrar", style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
      ),
    );
  }

  Widget textItem(String labeltext, TextEditingController controller, bool obscureText){
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(
          fontSize: 17,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          labelText: labeltext,
          labelStyle: TextStyle(
            fontSize: 17,
            color: Colors.black,
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                width: 1.5,
                color: Colors.grey,
              )
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                width: 1,
                color: Colors.grey,
              )
          ),
        ),
      ),
    );
}
}
