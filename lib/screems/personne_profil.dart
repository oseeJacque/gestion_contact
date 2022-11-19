import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gestion_contact1/constants/colors.dart';
import 'package:gestion_contact1/constants/string.dart';
import 'package:gestion_contact1/constants/widgets.dart';
import 'package:gestion_contact1/models/personne.dart';
import 'package:gestion_contact1/utils/app_input.dart';
import 'package:gestion_contact1/utils/app_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../services/contact_database.dart';

enum Gender { Man, Woman }

class PersonProfile extends StatefulWidget {
  final Personne personne;
  const PersonProfile({super.key, required this.personne});

  @override
  State<PersonProfile> createState() => _PersonProfileState();
}

class _PersonProfileState extends State<PersonProfile> {
  final ImagePicker _picker = ImagePicker();
   File? _image;
   String imageUrl="";
  late TextEditingController textEditingControllerfirstName;
  late TextEditingController textEditingControllerLasttName;
  late TextEditingController textEditingControllerAdress;
  late TextEditingController textEditingControllermail;
  late TextEditingController textEditingControllerGender;
  late TextEditingController textEditingControllerCitation;
  late TextEditingController textEditingControllerDate;
  late TextEditingController textEditingControllerPhone;
  bool readOnly = true;

  Gender _gender = Gender.Man;
  int gender =0 ;
  bool typeDevice = true;

  @override
  void initState() {
    // ignore: unrelated_type_equality_checks
    initGender();
    _image=File(widget.personne.imageUrl);
    textEditingControllerLasttName = TextEditingController(text: widget.personne.lastName);
    textEditingControllerfirstName =
        TextEditingController(text: widget.personne.firstName);
    textEditingControllerAdress =
        TextEditingController(text: widget.personne.adress);
    textEditingControllerCitation = TextEditingController(text: widget.personne.quote);
    textEditingControllerGender = TextEditingController(text: widget.personne.gender);
    textEditingControllermail = TextEditingController(text: widget.personne.mail);
    textEditingControllerDate = TextEditingController(text: widget.personne.birthday);
    textEditingControllerPhone = TextEditingController(text: widget.personne.phone);

    super.initState();
  }

  @override
  void dispose() {
    textEditingControllerLasttName.dispose();
    textEditingControllerfirstName.dispose();
    textEditingControllerAdress.dispose();
    textEditingControllerCitation.dispose();
    textEditingControllerGender.dispose();
    textEditingControllermail.dispose();
    textEditingControllerDate.dispose();
    textEditingControllerPhone.dispose();

    super.dispose();
  }
  void initGender(){
if(widget.personne.gender=="Man"){
  gender==1;
  _gender=Gender.Man;
} else{
  gender==0;
  _gender=Gender.Woman;
}
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.getWhiteColor,
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            width: width,
            height: height * .4,
            child: Stack(
              children: [
                Container(
                  //In this container we are only the top stack
                  width: width,
                  height: height * .25,
                  decoration: BoxDecoration(
                      color: AppColors.getWhiteColor,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0))),
                  child: Stack(
                    children: [
                      CustomPaint(
                        size: Size(width, height * .25),
                        painter: RPSCustomPainter4(),
                      ),
                      CustomPaint(
                        size: Size(width, height * .25),
                        painter: RPSCustomPainter5(),
                      ),
                      Positioned(
                        top: 10.0,
                        left: 10.0,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: AppColors.getWhiteColor,
                              size: width * .1,
                            )),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    //Here is the user picture
                    top: height * .15,
                    left: width * .3,
                    right: width * .3,
                    child: Container(
                      width: width * .4,
                      height: height * .2,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          _image!=null?
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100.0),
                            child: Image.file(_image!,fit: BoxFit.cover,width: width*.4,height: width*.4,))
                          :CircleAvatar(
                          radius: width * .3,
                          backgroundImage: const AssetImage("assets\\images\\images.jpg"),
                          ),
                          
                          Positioned(
                            bottom: 5.0,
                            right: 0.0,
                            child: IconButton(
                                onPressed: () {
                                  //showDialog();
                                  pickImage();
                                },
                                icon: Icon(
                                  Icons.camera_alt,
                                  size: width * .1,
                                  color: AppColors.getBlueNightColor,
                                )),
                          )
                        ],
                      ),
                    )),
                Positioned(
                    bottom: 0.0,
                    right: 10.0,
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            readOnly = false;
                          });
                        },
                        child: AppText(
                          StringData.modifier,
                          color: AppColors.getBlackColors,
                          size: 20.0,
                          decoration: TextDecoration.underline,
                        )))
              ],
            ),
          ),
          Expanded(
              //In this expanded we implement all Personne attributs
              child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: width * .03),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //First name
                  AppInput(
                      reeadOnly: readOnly,
                      hasSuffix: false,
                      label: StringData.firstName,
                      controller: textEditingControllerfirstName,
                      validator: (value) {}),
                  SizedBox(
                    height: height * .03,
                  ),

                  //Last name
                  AppInput(
                      label: StringData.lastName,
                      reeadOnly: readOnly,
                      hasSuffix: false,
                      controller: textEditingControllerLasttName,
                      validator: (value) {}),

                  SizedBox(
                    height: height * .03,
                  ),

                  //Email
                  AppInput(
                      label: StringData.email,
                      reeadOnly: readOnly,
                      hasSuffix: true,
                      suffixIcon: const IconButton(
                          onPressed: null, icon: Icon(Icons.mail)),
                      controller: textEditingControllermail,
                      validator: (value) {}),
                  SizedBox(
                    height: height * .03,
                  ),

                  //Phone Number
                  AppInput(
                      label: StringData.phone,
                      inputType: TextInputType.number,
                      reeadOnly: readOnly,
                      hasSuffix: true,
                      suffixIcon: const IconButton(
                          onPressed: null,
                          icon: Icon(Icons.phone_android_outlined)),
                      controller: textEditingControllerPhone,
                      validator: (value) {}),
                  SizedBox(
                    height: height * .03,
                  ),

                  //Day of birth
                  AppInput(
                      label: StringData.birth,
                      reeadOnly: true,
                      hasSuffix: true,
                      suffixIcon: IconButton(
                          onPressed: () async {
                            _showDatePicker();
                          },
                          icon: Icon(Icons.calendar_month)),
                      controller: textEditingControllerDate,
                      validator: (value) {}),
                  SizedBox(
                    height: height * .03,
                  ),

                  AppInput(
                      label: StringData.adress,
                      reeadOnly: readOnly,
                      hasSuffix: true,
                      suffixIcon: const IconButton(
                        icon: Icon(
                          Icons.location_on,
                        ),
                        onPressed: null,
                      ),
                      //hint: "oseesoke@gmail.com",
                      controller: textEditingControllermail,
                      validator: (value) {}),
                  SizedBox(
                    height: height * .03,
                  ),
                  //Quote/Citation
                  AppInput(
                      label: StringData.quote,
                      reeadOnly: readOnly,
                      hasSuffix: false,
                      //hint: "oseesoke@gmail.com",
                      controller: textEditingControllermail,
                      validator: (value) {}),

                  SizedBox(
                    height: height * .03,
                  ),

                  //Gender
                  Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: AppText(
                            StringData.gender,
                            color: AppColors.getblueColor,
                            size: 20.0,
                            weight: FontWeight.bold,
                          )),
                      Column(
                        children: [
                          ListTile(
                            leading: Radio(
                              value: Gender.Man,
                              groupValue: _gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = 0;
                                  _gender = value!;
                                });
                              },
                            ),
                            title: AppText(
                              StringData.man,
                              color: AppColors.getBlueNightColor,
                              size: 20.0,
                              weight: FontWeight.bold,
                            ),
                          ),
                          ListTile(
                            leading: Radio(
                              value: Gender.Woman,
                              groupValue: _gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = 1;
                                  _gender = value!;
                                  
                                });
                              },
                            ),
                            title: AppText(
                              StringData.women,
                              color: AppColors.getBlueNightColor,
                              size: 20.0,
                              weight: FontWeight.bold,
                            ),
                          )
                        ],
                      )
                    ],
                  ),

                  SizedBox(
                    height: height * .03,
                  ),
                  //Button of option "modify"
                  readOnly
                      ? const Text("")
                      : Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            onTap: (() {
                              setState(() {
                          widget.personne.firstName =
                              textEditingControllerfirstName.text;
                         widget.personne.lastName =
                              textEditingControllerLasttName.text;
                         widget.personne.mail = textEditingControllermail.text;
                         widget.personne.adress = textEditingControllerAdress.text;
                         widget.personne.birthday = textEditingControllerDate.text;
                         widget.personne.imageUrl = imageUrl;
                         widget.personne.quote = textEditingControllerCitation.text;
                          if (gender == 1) {
                           widget.personne.gender = "Man";
                          } else {
                           widget.personne.gender = "Woman";
                          }
                        });
                        ContactDataBase.updatePersonne(widget.personne).then((value){
                          if(value!=-1){
                            Navigator.pushNamed(context, "home");
                          }
                        });
                            }),
                            child: Container(
                              alignment: Alignment.center,
                              width: width * .3,
                              height: height * .06,
                              decoration: BoxDecoration(
                                  color: AppColors.getblueColor,
                                  borderRadius: BorderRadius.circular(20.0),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 3),
                                        color: AppColors.getBlueNightColor)
                                  ]),
                              child: AppText(
                                StringData.modifier,
                                color: AppColors.getWhiteColor,
                                size: 20.0,
                                weight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                  SizedBox(
                    height: height * .03,
                  ),
                  SizedBox(
                    height: height * .05,
                  ),
                ],
              ),
            ),
          ))
        ],
      )),
    );
  }

  Future<void> _showDatePicker() async {
    /* This fonction display the Date picker and  help to have the Person date
    setting:No setting for this function
     */

    DateTime? _pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(), //get today's date
        firstDate: DateTime(
            2000), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));
    if (_pickedDate != null) {
      setState(() {
        textEditingControllerDate.text =
            DateFormat(StringData.dateFormat).format(_pickedDate);
      });
    }
    {
      textEditingControllerDate.text = StringData.dateError;
    }
  }

   Future<void> pickImage() async {
     final image = await _picker.pickImage(
      source: typeDevice ? ImageSource.gallery : ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    setState(() {
      _image=File(image!.path);
     imageUrl=_image!.path;
    });
  }
}
