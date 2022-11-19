

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gestion_contact1/constants/colors.dart';
import 'package:gestion_contact1/constants/string.dart';
import 'package:gestion_contact1/constants/widgets.dart';
import 'package:gestion_contact1/models/personne.dart';
import 'package:gestion_contact1/screems/add_personnel.dart';
import 'package:gestion_contact1/screems/login_screem.dart';
import 'package:gestion_contact1/screems/personne_profil.dart';
import 'package:gestion_contact1/services/contact_database.dart';
import 'package:gestion_contact1/utils/app_text.dart';

enum Actions { share, delete, archive }

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _image;
  List<Map<String, dynamic>> _allPersonne = [];
  @override
  void initState() {
    super.initState();
    refreshListPersonne();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.getWhiteColor,
      body: SafeArea(
        child: Stack(clipBehavior: Clip.none, children: [
          CustomPaint(
            size: Size(width, height),
            painter: RPSCustomPainter3(),
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: width * .03),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height * .02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyLogin()));
                              },
                              icon: Icon(
                                Icons.logout_outlined,
                                color: AppColors.getBlueNightColor,
                                size: width * .1,
                              ))
                        ],
                      ),
                    ),
                    Container(
                      //This container contains the search bar of our screem
                      height: height * .08,
                      width: width,
                      decoration: BoxDecoration(
                          color: AppColors.getblueColor,
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                              //child: TextField(),
                              ),
                          Container(
                            decoration: BoxDecoration(
                                color: AppColors.getBlueNightColor,
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(30.0),
                                    bottomRight: Radius.circular(30.0))),
                            height: height * .08,
                            width: width * .15,
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.search,
                                  size: width * .1,
                                  color: AppColors.getWhiteColor,
                                )),
                          )
                        ],
                      ),
                    ), //The end of the search bar

                    SizedBox(
                      height: height * .02,
                    ),
                    Text(
                      StringData.all_contact,
                      style: const TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                  ],
                ),
              ),
              Expanded(
                  //In this widget we are going to implement the list of contact
                  child: SingleChildScrollView(
                child: Container(
                  margin:
                      EdgeInsets.only(left: width * .01, right: width * .01),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SlidableAutoCloseBehavior(
                        closeWhenOpened: true,
                        child: ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            clipBehavior: Clip.none,
                            itemCount: _allPersonne.length,
                            itemBuilder: (context, index) {
                              final user = Personne.toMap(_allPersonne[index]);
                              return Slidable(
                                  key: Key(user.lastName),
                                  startActionPane: ActionPane(
                                    dismissible: DismissiblePane(
                                      onDismissed: (() => _onDimissible(
                                          index, Actions.delete,
                                          id: user.id)),
                                    ),
                                    motion: const StretchMotion(),
                                    children: [
                                      SlidableAction(
                                          backgroundColor:
                                              AppColors.getGreenColor,
                                          icon: Icons.share,
                                          label: StringData.share,
                                          onPressed: (context) => _onDimissible(
                                              index, Actions.share,
                                              id: user.id)),
                                      SlidableAction(
                                          backgroundColor:
                                              AppColors.getblueColor,
                                          icon: Icons.archive,
                                          label: StringData.sms,
                                          onPressed: (context) => _onDimissible(
                                              index, Actions.archive,
                                              id: user.id))
                                    ],
                                  ),
                                  endActionPane: ActionPane(
                                    dismissible: DismissiblePane(
                                      onDismissed: (() => _onDimissible(
                                          index, Actions.delete,
                                          id: user.id)),
                                    ),
                                    motion: BehindMotion(),
                                    children: [
                                      SlidableAction(
                                        label: StringData.delete,
                                        backgroundColor: AppColors.getRedColor,
                                        icon: Icons.delete,
                                        onPressed: (context) => _onDimissible(
                                            index, Actions.delete,
                                            id: user.id),
                                      )
                                    ],
                                  ),
                                  child: buildPersonneListTile(user,width: width * .25));
                            }),
                      )
                    ],
                  ),
                ),
              )),
            ],
          )
        ]),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.getBlueNightColor,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddPersonScreem()));
        },
        child: const Icon(
          Icons.add,
          size: 40.0,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget buildPersonneListTile(Personne user,{double width=100}) {
    /*This method is use to build the personneListTile
    setting: Object Personne
    */
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 2, color: AppColors.getGreyColor),
        borderRadius: BorderRadius.circular(25),
      ),
      child: ListTile(
        dense: false,
        isThreeLine: false,
        contentPadding: const EdgeInsets.all(5.0),
        title: Text(
          "${user.lastName} ${user.firstName}",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        subtitle: AppText(user.quote,color: AppColors.getGreyColor,),
        leading:user.imageUrl.isNotEmpty
            ? ClipRRect(
              clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.circular(100.0),
                child: Image.file( 
                  File(user.imageUrl),
                  fit: BoxFit.cover,
                  width: width*.6,
                  height: width ,
                ))
            : CircleAvatar(
                radius: width*.5,
                backgroundImage: const AssetImage("assets\\images\\images.jpg"),
              ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PersonProfile(personne: user)));
          /* final slidable=Slidable.of(context);
          final isCLosed=slidable!.actionPaneType.value==ActionPaneType.none;
          if (isCLosed){
            slidable.openEndActionPane();
          }*/
        },
      ),
    );
  }

  void _onDimissible(int index, Actions action, {int id = -1}) {
    final user = Personne.toMap(_allPersonne[index]);
    setState(() {
      switch (action) {
        case Actions.delete:
          ContactDataBase.deletePersonne(id).then(
            (value) {
              if (value != -1) {
                _showSnackBar(
                    context,
                    '${user.lastName} ${user.firstName} is delete ',
                    AppColors.getRedColor);
                refreshListPersonne();
              } else {
                _showSnackBar(
                    context,
                    '${user.lastName} ${user.firstName} is not delete delete ',
                    AppColors.getRedColor);
              }
            },
          );
          _showSnackBar(
              context,
              '${user.lastName} ${user.firstName} is delete ',
              AppColors.getRedColor);
          break;
        case Actions.archive:
          _showSnackBar(
              context,
              '${user.lastName} ${user.firstName} is archieve ',
              AppColors.getblueColor);
          break;
        case Actions.share:
          _showSnackBar(
              context,
              '${user.lastName} ${user.firstName} is shared ',
              AppColors.getGreenColor);
          break;
      }
    });
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    //This methode is use for display message in the scaffold using snackbar
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: AppColors.getWhiteColor),
      ),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void refreshListPersonne() async {
    final data = await ContactDataBase.getAllPersonne();
    setState(() {
      _allPersonne = data;
    });
  }

  /*void setStateImageUrl(Personne pers)async {
  setState(() {
      _image=File(pers.imageUrl);
    });
  }*/
}
