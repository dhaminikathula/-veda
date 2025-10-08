import 'dart:math';
//import 'package:veda/Main_Screen.dart/edit_profile.dart';
//import 'package:veda/Main_Screen.dart/Payment.dart';
//import 'package:veda/Main_Screen.dart/feedback.dart';
//import 'package:veda/Main_Screen.dart/help.dart';
import 'package:flutter/material.dart';

class Profile_Page extends StatefulWidget {
  const Profile_Page({super.key});

  @override
  State<Profile_Page> createState() => _Profile_PageState();
}

class _Profile_PageState extends State<Profile_Page> {
  bool _isHovered = false;
  bool _isHovered1 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to your profile",style: TextStyle(fontSize: 25,color: Colors.white),),
        backgroundColor: const Color.fromARGB(255, 58, 11, 228),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            
            children: [
              Text(""),
              Align(alignment: Alignment.topCenter,
              child: CircleAvatar(radius: 70,backgroundColor: Colors.blue,
              child: Icon(Icons.person,size: 100,)
              ,)
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Text("Hi Aditya!",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.blue),)
              ),
              Row(
                children: [
                  MouseRegion(
                    onEnter: (event) => setState(() => _isHovered = true),
                    onExit: (event) => setState(() => _isHovered = false),
                    child: AnimatedContainer(duration: Duration(milliseconds: 200),
                    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 244, 246, 249).withOpacity(0.6), // deep blue shadow
                      blurRadius: _isHovered ? 30 : 15, // stronger blur on hover
                      spreadRadius: _isHovered ? 6 : 3,
                      offset: const Offset(0, 8), // shadow position
                    ),
                  ],
                    ),
                    transform: _isHovered
                    ? Matrix4.translationValues(0, -10, 0) // float up on hover
                    : Matrix4.identity(),
                    child: ClipRRect(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 58, 11, 228),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(child: Text("Events Registered",style: TextStyle(color: Colors.white,fontSize: 18),)),
                    ),
                    ),
                    
                  )
                  ),
                  SizedBox(width: 5,),
                   MouseRegion(
                    onEnter: (event) => setState(() => _isHovered1 = true),
                    onExit: (event) => setState(() => _isHovered1 = false),
                    child: AnimatedContainer(duration: Duration(milliseconds: 200),
                    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                    height: 50,
                    width: 170,
                    decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 244, 246, 249).withOpacity(0.6), // deep blue shadow
                      blurRadius: _isHovered1 ? 30 : 15, // stronger blur on hover
                      spreadRadius: _isHovered1 ? 6 : 3,
                      offset: const Offset(0, 8), // shadow position
                    ),
                  ],
                    ),
                    transform: _isHovered1
                    ? Matrix4.translationValues(0, -10, 0) // float up on hover
                    : Matrix4.identity(),
                    child: ClipRRect(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 58, 11, 228),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(child: Text("Events Participated",style: TextStyle(color: Colors.white,fontSize: 18),)),
                    ),
                    ),
                    
                  )
                  ),

                ],
            
              ),
              SizedBox(height: 20,),
              ListTile(
                leading: Icon(Icons.person),
                title: Text("   Edit Profile",style: TextStyle(fontSize: 20),),
               onTap: (){
                
               },
              ),
               SizedBox(height: 20,),
              ListTile(
                leading: Icon(Icons.payment_outlined),
                title: Text("   Payment_Process",style: TextStyle(fontSize: 20),),
               onTap: (){
               
               },
              ),
               SizedBox(height: 20,),
              ListTile(
                leading: Icon(Icons.post_add_outlined),
                title: Text("   share your suggestions",style: TextStyle(fontSize: 20),),
               onTap: (){
                
               },
              ),
               SizedBox(height: 20,),
              ListTile(
                leading: Icon(Icons.help),
                title: Text("   Help & Support",style: TextStyle(fontSize: 20),),
               onTap: (){
                
               },
              ),
              SizedBox(height: 20,),
              ListTile(
                leading: Icon(Icons.logout,color: Colors.red,),
                title: Text("   Logout",style: TextStyle(fontSize: 20),),
               onTap: (){
                
               },
              ),
            ],
          ),
        ),
      ),
      

      
    );
  }
}
