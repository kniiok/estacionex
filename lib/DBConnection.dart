import 'package:mongo_dart/mongo_dart.dart';

class Database {
  static final Database _instance = Database._internal();
  Db _db= Db(
        'mongodb://sistemas_distribuidos:j2CTTKqbZaNyQqsd@150.230.80.1:27017/mqtt_auth');

  factory Database() {
    return _instance;
  }

  Database._internal() {
    if (_db == null){
    _db = Db(
        'mongodb://sistemas_distribuidos:j2CTTKqbZaNyQqsd@150.230.80.1:27017/mqtt_auth');
    }
        
  }

  Future<void> openConnection() async {
    await _db.open();
    print('OK Connected');
  }

  Future<void> closeConnection() async {
    await _db.close();
    print('Erro disconnected');
  }

  getDbState() {
    return _db.state;
    
  }

  getCollection(){
    return _db.collection('users');
  }

  isConnected(){
    return _db.isConnected;
  }

  DbCollection get users => _db.collection('users');
}
