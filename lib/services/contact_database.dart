import 'package:gestion_contact1/constants/db_const.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sql;

import '../models/account_model.dart';
import '../models/personne.dart';

/* We implemente on this file the differents functions to setup our database */
class ContactDataBase {
 static final List <Personne> allPersonne=[];

  static Future <List <Personne>> get pers async {
  getAllPersonne();
    return allPersonne;
  }

  static Future <sql.Database> _initDB() async {
    /*This function is used to initialize the database 
  Parametter:the path of the file of database
   */
    // final dbPath = await sql.getDatabasesPath();
    //String path = join(dbPath, filePath);
    return await sql.openDatabase(DbConst.db_name, version: 1,
        onCreate: (sql.Database database, int version) async {
      await _createDB(database);
    });
  }

  static Future<void> _createDB(sql.Database db) async {
    /* This function help to create the database withe their Tables*/
    //Creation account table
    await db.execute(""" CREATE TABLE ${DbConst.account} (
    ${AcountFields.id}  ${DbConst.idType},
    ${AcountFields.firstName} ${DbConst.textType}, 
    ${AcountFields.lastName}  ${DbConst.textType}, 
    ${AcountFields.email}  ${DbConst.textType}, 
    ${AcountFields.password}  ${DbConst.textType}) 
    """);

    //Creation personne account
    await db.execute("""CREATE TABLE ${DbConst.personne} (
      ${PersonneFields.id} ${DbConst.idType},
      ${PersonneFields.phone} ${DbConst.textType},
      ${PersonneFields.adress} ${DbConst.textType},
      ${PersonneFields.firstName}  ${DbConst.textType},
      ${PersonneFields.lastName}  ${DbConst.textType},
      ${PersonneFields.birthday}  ${DbConst.textType},
      ${PersonneFields.imageUrl}  ${DbConst.textType},
      ${PersonneFields.gender}  ${DbConst.textType},
      ${PersonneFields.quote}  ${DbConst.textType},
      ${PersonneFields.mail}  ${DbConst.textType}
    )""");
  }

/*static Future <void> addColumnToTable()async{
  final db=ContactDataBase._initDB();
  final data={};
}*/

  static Future<int> createAccount(Account acount) async {
    /*
    The function was implementeto create a new acount 
 parametter: Object type account
 return: A copy of the account with it id which generate by the database
 */
    try {
      sql.Database db = await ContactDataBase._initDB();
      final id = await db.insert(DbConst.account, acount.tojson());
      return id;
    } catch (e) {
      print(e);
      print("xdcfvgbhnj,k;l:m");
      return -1;
    }
  }

  static Future <bool> login(String mail, String password) async {
    /*
    The function is to login in the application
    Parametter:{mail:string,password:string}
    */
    try {
      sql.Database db = await ContactDataBase._initDB();

      final maps = await db.query(DbConst.account, columns: [
        AcountFields.email,
        AcountFields.password,
        AcountFields.id
      ]);

      for (int i = 0; i < maps.length; i++) {
        if (maps[i]["email"] == mail && maps[i]["password"] == password) {
          return true;
        }
      }

      return false;
    } catch (e) {
      return false;
    }
  }

//The methode for Personne/contact CRUD

  static Future <int> createPersonne(Personne personne) async {
/*This function is implement to create a new Personne/contact 
setting: Personne Object
return: itn: id
*/
    try{
    sql.Database db = await ContactDataBase._initDB();
    print(personne.tojson(personne));
    final id = await db.insert(DbConst.personne, personne.tojson(personne));
    print("L'identifiant du contact crée est $id");
    return id;
    }catch (e){
      print(e);
      return -1;
    }
  }


  static  Future<List<Map<String, dynamic>>> getAllPersonne() async {
    /*This functions is use to get all contacts from database 
    stting:Not parametter
    return:List of contact/personne
    */
   try{
     sql.Database db = await ContactDataBase._initDB();
    final resultat=await db.query(DbConst.personne, orderBy: "id",);
    for (int i=0;i<resultat.length;i++){
      print(resultat[i]);
      allPersonne.add(Personne.toMap(resultat[i]));
    }
    return resultat;
   }catch (e){
      print("ereruhzbkzbhknb kn $e");
    return [];
  
   }
  }

  static Future <Personne> getOnePersonne(int id)async {
    /* The is use for get Personne from his id
    setting: {id:int,}
    return: Personne Object
    */
    try{
      sql.Database db= await ContactDataBase._initDB();
     final maps=await db.query(DbConst.personne,where: "id = ?",whereArgs: [id],limit: 1);
     return Personne.toMap(maps.first);
    }catch (e){
      print(e);
      rethrow;
    }
  }

static Future <int> updatePersonne(Personne data) async{
  /* The function is use to update the contact/Personne information
  setting: {Personne Object}
  return int;
  */
  try{
    sql.Database db =await  ContactDataBase._initDB();
  final result=db.update(DbConst.personne, data.tojson(data),where: "id = ?",whereArgs: [data.id]);
  return result;
  }catch (e){
    print(e);
    return -1;
  }
}


/*
static Future <void> updateOnePersonne(int id) async{
  /* The function is use to delete the contact/Personne information
  setting: {int id}
  return int;
  */
  try{
  sql.Database db =await  ContactDataBase._initDB();
  final result=db.delete(DbConst.personne,where: "id = ?",whereArgs: [id]);
  }catch(e){
    print(e);
  }

  
}*/

static Future <int> deletePersonne(int id)async{
 try{
   final db= await ContactDataBase._initDB();
   await db.delete(DbConst.personne,where: "id = ?",whereArgs: [id]);
  print("L'identifiant du contact suprimé est $id ");
  return id;
 }catch (e){
  print(e);
  return -1;
 }
}


  Future close() async {
    //This function is use for close the database .It take any parametter
    final db = await ContactDataBase._initDB();
    db.close();
  }
}
