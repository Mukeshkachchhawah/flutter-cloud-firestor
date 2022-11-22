import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';



class DataStor extends StatefulWidget {
  const DataStor({super.key});

  @override
  State<DataStor> createState() => _DataStorState();
}

class _DataStorState extends State<DataStor> {
  final Stream<QuerySnapshot> user = FirebaseFirestore.instance.collection('user').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Comments"),
      ),
    
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
     //   mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text("Cloud Firebase Data Stor", style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),),
            ),
            Container(
              height: 250,
              child: StreamBuilder<QuerySnapshot>(
                stream: user,
                builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                   if(snapshot.hasData){
                    return Text("User Data Not Found");
                   }if(snapshot.connectionState == ConnectionState.waiting){
                    return Text("Loding");
                   }
                   final data = snapshot.requireData;
                   return ListView.builder(
                    itemCount: data.size,
                    itemBuilder: (context, index){
                    return Text("My name is ${data.docs[index]['name']} and my age 22 ${data.docs[index]['age']}");
                   });
                })
            ),

            Text("Flutter Fireabase Add Data Cloud Firestor", style: TextStyle(fontSize: 20, color: Colors.black),)
         , SizedBox(
          height: 20,
         ),
         MyCustomWidget()
          ],
        ),
      ),
    );
  }
}

class MyCustomWidget extends StatefulWidget {
  const MyCustomWidget({super.key});

  @override
  State<MyCustomWidget> createState() => _MyCustomWidgetState();
}

class _MyCustomWidgetState extends State<MyCustomWidget> {
  final _formKey = GlobalKey<FormState>();
  var name = '';
  var age = 0;
  @override
  Widget build(BuildContext context) {
    CollectionReference user = FirebaseFirestore.instance.collection('user');
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.person),
              hintText: "User Name"
            ),
            onChanged: (value) {
              name = value;
            },
            validator: (value) {
              if(value==null || value.isEmpty){
                return "Please Enter Name";
              }
              return null;
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.person),
              hintText: "User Age"
            ),
            onChanged: (value) {
              age = int.parse(value);
            },
            validator: (value) {
              if(value==null || value.isEmpty){
                return "Please Enter Age";
              }
              return null;
            },
          ),
          SizedBox(
            height: 30,
          ),

          Center(
            child: ElevatedButton(onPressed: (){
              if(_formKey.currentState!.validate()){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sedding Data Firebase")));
                user.add({'name': name ,'age': age}).then((value) => print('yes')).catchError((erro)=>print("Faild to add user: $erro"));
              }
            }, child: Text("Clike")),
          )
        ],
      ),
    );
  }
}