

import 'package:flutter/material.dart';
import 'package:gestion_contact1/constants/colors.dart';
import 'package:gestion_contact1/constants/string.dart';
import 'package:gestion_contact1/constants/widgets.dart';
import 'package:gestion_contact1/models/account_model.dart';
import 'package:gestion_contact1/services/contact_database.dart';

class RegisterScreem extends StatefulWidget {
  const RegisterScreem({super.key});

  @override
  State<RegisterScreem> createState() => _RegisterScreemState();
}

class _RegisterScreemState extends State<RegisterScreem> {
  //late ContactDataBase contactDataBase;
  Account account=Account(email: " ",
    password: " ", 
    firstName:" ",lastName: " ", 
    id: 0);
  final TextEditingController textEditingControllerfirstName =
      TextEditingController();
  final TextEditingController textEditingControllerLasttName =
      TextEditingController();

  final TextEditingController textEditingControllerMail =
      TextEditingController();

  final TextEditingController textEditingControllerPassword =
      TextEditingController();

  @override
  void initState() {
    
    /*account=Account(email: " ",
    password: " ", 
    firstName:" ",lastName: " ", 
    id: 0);*/
    super.initState();
  }

  @override
  void dispose() {
    textEditingControllerLasttName.dispose();
    textEditingControllerMail.dispose();
    textEditingControllerPassword.dispose();
    textEditingControllerfirstName.dispose();
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
            size: Size(width, height * .45),
            painter: RPSCustomPainter(),
          ),
          Positioned(
              top: width * .1,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: width * .08,
                  color: AppColors.getWhiteColor,
                ),
                onPressed: (() {}),
              )),
          Positioned(
            top: height*.15,
            left: width*.03,
            child: Column(
              children: [Text(StringData.register.split(" ")[0],style: TextStyle(color: AppColors.getWhiteColor,fontSize: width*.1,fontWeight: FontWeight.bold),), 
              Text(StringData.register.split(" ")[1],style: TextStyle(color: AppColors.getWhiteColor,fontSize: width*.1,fontWeight: FontWeight.bold),),
              ])),

         
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin:const  EdgeInsets.only(left: 35, right: 35),
                    child: Column(
                      children: [
                        Fields(
                            hintText: StringData.firstName,
                            controller: textEditingControllerfirstName),
                        SizedBox(
                          height: height*.02,
                        ),
                        Fields(
                            hintText: StringData.lastName,
                            controller: textEditingControllerLasttName),
                        SizedBox(
                          height: height*.02,
                        ),
                        Fields(
                            hintText: StringData.email,
                            controller: textEditingControllerMail),
                        SizedBox(
                          height: height*.02,
                        ),
                        Fields(
                            hintText: StringData.password,
                            controller: textEditingControllerPassword),
                            SizedBox(
                          height: height*.05,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text(
                              StringData.signUp,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 27,
                                  fontWeight: FontWeight.w700),
                            ),

                            //Button register 
                            CircleAvatar(
                              radius: 40,
                              backgroundColor:const  Color(0xff4c505b),
                              child: IconButton(
                                  color: Colors.white,
                                  onPressed: () {
                                    setState(() {
                                      account.firstName=textEditingControllerfirstName.text;
                                      account.lastName=textEditingControllerLasttName.text;
                                      account.email=textEditingControllerMail.text;
                                      account.password=textEditingControllerPassword.text;

                                      ContactDataBase.createAccount(account).then((value){
                                        if(value!=-1){
                                          Navigator.pushNamed(context, 'login');
                                        }else{
                                          print(value);
                                        }
                                      });
                                    });
                                    Navigator.pushNamed(context, 'login');
                                  },
                                  icon:const  Icon(
                                    Icons.arrow_forward,
                                  )),
                            )
                          ],
                        ),
                       SizedBox(
                          height: height*.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, 'login');
                                // Navigator.of(context).push(_createRoute());
                              },
                              style: const ButtonStyle(),
                              child:Text(
                                StringData.login,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ), 
                  //SizedBox(height: height*.1,)
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
