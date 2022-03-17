import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trainingproject_sqlflite/model/note.dart';


class NotesDatabase{
  //a global field, which is our instance... basically calling private constructor
  static final NotesDatabase instance = NotesDatabase._init();

  //new field for our database
  static Database? _database;

  //private constructor
  NotesDatabase._init();

  //new database created... if !null return database, else create new
  Future<Database> get database async {
    if(_database != null) return _database!;
    _database = await _initDB('notes.db'); //notes.db   ->where our database is stored
    return _database!;
  }

  //new method where we get our file pass, storing data in our file storage system
  Future<Database> _initDB(String filepath) async {
    final dbPath = await getDatabasesPath();

    //new path object
    final path = join(dbPath, filepath);
    
    //to open our database... initialise version and DataBase schema (_createDB method_
    return await openDatabase(path, version: 1, onCreate: _createDB);
    //if you later want to update your schema or want to include other fields, or other datatables
    //if version is changed for schema... it will called desired method like upgrade
    //return await openDatabase(path, version: 2, onCreate: _createDB, onUpgrade...);

  }

  //new method to create our database
  Future _createDB(Database db, int version) async{

    //type of data in cloumns
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    //database execute method... define all the column names..schemas
    await db.execute('''Create Table $tableNotes (
    ${NoteFields.id} $idType, 
    ${NoteFields.isImportant} $boolType, 
    ${NoteFields.number} $integerType,
    ${NoteFields.title} $textType,
    ${NoteFields.description} $textType,
    ${NoteFields.time} $textType
    )''');
  }

  //crude methods... create, read, update and delete

  //create method
  Future<Note> create(Note note) async{

    //getting refrence to our database
    final db = await instance.database;

    //calling insert method in table... converting data into map, .toJson()
    final id = await db.insert(tableNotes, note.toJson());
    return note.copy(id: id);
    
  }
  //read method
  Future<Note?> readNote(int id) async{
    final db = await instance.database;
    final maps = await db.query(
      tableNotes,
      columns: NoteFields.values,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty){
      return Note.fromJson(maps.first);
    }
    else {
      throw Exception('ID $id not found');
    }
  }

  //to read multiple notes... read all nodes method...return list of node
  Future<List<Note>> readAllNotes() async {
    final db = await instance.database;

    final orderBy = '${NoteFields.time} ASC';

    final result = await db.query(tableNotes, orderBy: orderBy);

    return result.map((json) => Note.fromJson(json)).toList();
  }

  //update method
  Future<int> update(Note note) async {
    final db = await instance.database;

    return db.update(
      tableNotes,
      note.toJson(),
      where: '${NoteFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  //delete method
  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableNotes,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );
  }


  //new method for closing our database
  Future close()async{
    //accessing our database which we have created before
    final db = await instance.database;
    db.close();
  }

}