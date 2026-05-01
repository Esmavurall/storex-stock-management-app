import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB("stk_app.db");
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE customers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        phone TEXT,
        password TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE orders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        customerEmail TEXT NOT NULL,
        customerName TEXT NOT NULL,
        totalPrice REAL NOT NULL,
        paymentMethod TEXT NOT NULL,
        date TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE order_items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        orderId INTEGER NOT NULL,
        productName TEXT NOT NULL,
        quantity INTEGER NOT NULL,
        price REAL NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        category TEXT NOT NULL,
        stock INTEGER NOT NULL,
        critical INTEGER NOT NULL,
        price REAL NOT NULL
      )
    ''');
  }

  Future<int> insertCustomer({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    final db = await instance.database;

    return await db.insert("customers", {
      "name": name,
      "email": email,
      "phone": phone,
      "password": password,
    });
  }

  Future<Map<String, dynamic>?> loginCustomer({
    required String email,
    required String password,
  }) async {
    final db = await instance.database;

    final result = await db.query(
      "customers",
      where: "email = ? AND password = ?",
      whereArgs: [email, password],
    );

    if (result.isNotEmpty) {
      return result.first;
    }

    return null;
  }

  Future<List<Map<String, dynamic>>> getAllCustomers() async {
    final db = await instance.database;

    return await db.query(
      "customers",
      orderBy: "id DESC",
    );
  }

  Future<int> insertOrder({
    required String customerEmail,
    required String customerName,
    required double totalPrice,
    required String paymentMethod,
    required String date,
    required List<Map<String, dynamic>> items,
  }) async {
    final db = await instance.database;

    final orderId = await db.insert("orders", {
      "customerEmail": customerEmail,
      "customerName": customerName,
      "totalPrice": totalPrice,
      "paymentMethod": paymentMethod,
      "date": date,
    });

    for (var item in items) {
      await db.insert("order_items", {
        "orderId": orderId,
        "productName": item["productName"],
        "quantity": item["quantity"],
        "price": item["price"],
      });
    }

    return orderId;
  }

  Future<List<Map<String, dynamic>>> getOrdersByCustomer(
    String customerEmail,
  ) async {
    final db = await instance.database;

    return await db.query(
      "orders",
      where: "customerEmail = ?",
      whereArgs: [customerEmail],
      orderBy: "id DESC",
    );
  }
  Future<List<Map<String, dynamic>>> getAllOrders() async {
  final db = await instance.database;

  return await db.query(
    "orders",
    orderBy: "id DESC",
  );
}

  Future<List<Map<String, dynamic>>> getOrderItems(int orderId) async {
    final db = await instance.database;

    return await db.query(
      "order_items",
      where: "orderId = ?",
      whereArgs: [orderId],
    );
  }
}