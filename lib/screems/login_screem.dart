import 'package:flutter/material.dart';
import 'package:gestion_contact1/constants/colors.dart';
import 'package:gestion_contact1/constants/string.dart';
import 'package:gestion_contact1/constants/widgets.dart';
import 'package:gestion_contact1/services/contact_database.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  late ContactDataBase contactDataBase;
final TextEditingController textEditingControllerMail =
      TextEditingController();

  final TextEditingController textEditingControllerPassword =
      TextEditingController();

  @override 
  void initState(){
    contactDataBase=ContactDataBase();
    super.initState();
  }

  @override 
  void dispose(){
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.getWhiteColor,
      body: Container(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            CustomPaint(
            size: Size(width, height),
            painter: RPSCustomPainter2(),
          ),
          CustomPaint(
            size: Size(width, height * .5),
            painter: RPSCustomPainter(),
          ),
           Positioned(
            top: height*.15,
            left: width*.03,
            child: Column(
              children: [Text(StringData.welcome.split(" ")[0],style: TextStyle(color: AppColors.getWhiteColor,fontSize: width*.1,fontWeight: FontWeight.bold),), 
              Text(StringData.welcome.split(" ")[1],style: TextStyle(color: AppColors.getWhiteColor,fontSize: width*.1,fontWeight: FontWeight.bold),),
           
              ])),

//We implemente here the different fields of screem
               SingleChildScrollView( 
              child: Container( 
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.45),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin:const  EdgeInsets.only(left: 35, right: 35),
                        child: Column(
                          children: [
                            Fields(
                            hintText: StringData.email,
                            controller: textEditingControllerMail),
                            SizedBox(height: height*.05,),
                            Fields(
                            hintText: StringData.password,
                            controller: textEditingControllerPassword),
                             SizedBox(height: height*.05,),
                             Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, 'register');
                                // Navigator.of(context).push(_createRoute());
                              },
                              style: const ButtonStyle(),
                              child:Text(
                                StringData.signUp,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                            ),


                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, 'register');
                                // Navigator.of(context).push(_createRoute());
                              },
                              style: const ButtonStyle(),
                              child:Text(
                                StringData.forget,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    decorationStyle: TextDecorationStyle.solid,
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                            ),
                              ],
                             ),
                             SizedBox(height: height*.05,),
                             Row( 
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                              StringData.login,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 27,
                                  fontWeight: FontWeight.w700),
                            ),

                            // login button
                            CircleAvatar(
                              radius: 40,
                              backgroundColor:const  Color(0xff4c505b),
                              child: IconButton(
                                  color: Colors.white,
                                  onPressed: () {
                                    setState(() {
                                      ContactDataBase.login(textEditingControllerMail.text, textEditingControllerPassword.text).then((value){
                                        if(value){
                                           Navigator.pushNamed(context, 'home');
                                        }else{
                                          print("Désoléeeeeeeeeeee");
                                        }
                                      });
                                    });
                                    

                                  },
                                  icon:const  Icon(
                                    Icons.arrow_forward,
                                  )),
                            )
                              ],
                             ), 

                          ],
                        ),
                      )
                    ],
                  ),
              ),
            )
        ]),
      ),
    );
  }
}