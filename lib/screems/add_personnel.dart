import 'package:flutter/material.dart';
import 'package:gestion_contact1/constants/colors.dart';
import 'package:gestion_contact1/constants/string.dart';
import 'package:gestion_contact1/constants/widgets.dart';
import 'package:gestion_contact1/models/personne.dart';
import 'package:gestion_contact1/services/contact_database.dart';
import 'package:gestion_contact1/utils/app_input.dart';
import 'package:gestion_contact1/utils/app_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'dart:async';

enum Gender { Man, Woman }

class AddPersonScreem extends StatefulWidget {
  const AddPersonScreem({
    super.key,
  });

  @override
  State<AddPersonScreem> createState() => _AddPersonScreemState();
}

class _AddPersonScreemState extends State<AddPersonScreem> {
  final ImagePicker _picker = ImagePicker();
  File? _image;

  late TextEditingController textEditingControllerfirstName;
  late TextEditingController textEditingControllerLasttName;
  late TextEditingController textEditingControllerAdress;
  late TextEditingController textEditingControllermail;
  late TextEditingController textEditingControllerGender;
  late TextEditingController textEditingControllerCitation;
  late TextEditingController textEditingControllerDate;
  late TextEditingController textEditingControllerPhone;
  late Personne personne;
  String imageUrl="";
  bool readOnly = false;
  bool typeDevice = true;

  Gender _gender = Gender.Man;
  int gender = 1;

  @override
  void initState() {
    textEditingControllerLasttName = TextEditingController();
    textEditingControllerfirstName = TextEditingController();
    textEditingControllerAdress = TextEditingController();
    textEditingControllerCitation = TextEditingController();
    textEditingControllerGender = TextEditingController();
    textEditingControllermail = TextEditingController();
    textEditingControllerDate = TextEditingController();
    textEditingControllerPhone = TextEditingController();
    personne = Personne(
      phone: "97028433",
        firstName: "",
        lastName: "",
        imageUrl: " ",
        birthday: "",
        adress: " ",
        mail: " ",
        gender: "",
        quote: "");

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
                            child: Image.file(_image!,width: width*.4,height: width*.4,fit: BoxFit.cover,))
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
                      hint: StringData.firstNameExample,
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
                      hint: StringData.lastNameExample,
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
                      hint: StringData.emailExemple,
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
                      hint: StringData.phoneExample,
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
                      hint: StringData.birthExample,
                      label: StringData.birth,
                      reeadOnly: true,
                      hasSuffix: true,
                      suffixIcon: IconButton(
                          onPressed: () async {
                            _showDatePicker();
                          },
                          icon: const Icon(Icons.calendar_month)),
                      controller: textEditingControllerDate,
                      validator: (value) {}),
                  SizedBox(
                    height: height * .03,
                  ),

                  //  Adress
                  AppInput(
                      hint: StringData.adress,
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
                      controller: textEditingControllerAdress,
                      validator: (value) {}),
                  SizedBox(
                    height: height * .03,
                  ),

                  //Quote/Citation
                  AppInput(
                      hint: StringData.quoteExample,
                      label: StringData.quote,
                      reeadOnly: readOnly,
                      hasSuffix: false,
                      //hint: "oseesoke@gmail.com",
                      controller: textEditingControllerCitation,
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
                  Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: (() {
                        setState(() {
                          personne.firstName =
                              textEditingControllerfirstName.text;
                          personne.lastName =
                              textEditingControllerLasttName.text;
                          personne.mail = textEditingControllermail.text;
                          personne.adress = textEditingControllerAdress.text;
                          personne.birthday = textEditingControllerDate.text;
                          personne.imageUrl = imageUrl;
                          personne.quote = textEditingControllerCitation.text;
                          if (gender == 1) {
                            personne.gender = "Man";
                          } else {
                            personne.gender = "Woman";
                          }
                        });
                        ContactDataBase.createPersonne(personne).then((value){
                          print(personne.tojson(personne));
                          if(value!=-1){
                            Navigator.pushNamed(context,"home");
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
                                  offset: const Offset(0, 3),
                                  color: AppColors.getBlueNightColor)
                            ]),
                        child: AppText(
                          StringData.add,
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

    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(), //get today's date
        firstDate: DateTime(
            2000), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));
    if (pickedDate != null) {
      setState(() {
        textEditingControllerDate.text =
            DateFormat(StringData.dateFormat).format(pickedDate!);
      });
    }else
    {
      textEditingControllerDate.text = StringData.dateError;
    }
  }

  /*void _radioSelected(String value) {
    if (value == StringData.women) {
      setState(() {
        gender == 1;
      });
    }
    {
      setState(() {
        gender == 0;
      });
    }
  }*/

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

  Widget showDialog(context(BuildContext context)) {
    return AlertDialog(
      backgroundColor: AppColors.getBlackColors,
      title: AppText(
        StringData.selectDevice,
        color: AppColors.getblueColor,
        size: 20.0,
        weight: FontWeight.bold,
      ),
      actions: [
        ListTile(
          leading: Icon(
            Icons.camera_alt,
            size: 40.0,
            color: AppColors.getblueColor,
          ),
          title: AppText(
            StringData.camera,
            size: 17.0,
            color: AppColors.getblueColor,
            weight: FontWeight.bold,
          ),
          onTap: (() {
            setState(() {
              typeDevice = true;
              print(typeDevice);
            });
          }),
        ),
        ListTile(
          leading: Icon(
            Icons.browse_gallery_outlined,
            size: 40.0,
            color: AppColors.getblueColor,
          ),
          title: AppText(
            StringData.gallery,
            size: 17.0,
            color: AppColors.getblueColor,
            weight: FontWeight.bold,
          ),
          onTap: (() {
            setState(() {
              typeDevice = false;
            });
          }),
        )
      ],
    );
  }
}
