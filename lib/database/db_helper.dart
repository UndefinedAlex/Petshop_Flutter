import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseHelper {
  static const _databaseName = 'b12_petshop.db';
  static const _databaseVersion = 1;

  // Table names and columns for the 'users' table
  static const tableUser = 'users';
  static const columnUserId = 'id';
  static const columnUsername = 'username';
  static const columnRole = 'role';
  static const columnRfidUid = 'rfid_uid';
  static const columnPassword = 'password';
  static const columnCreatedAt = 'created_at';
  static const columnUpdatedAt = 'updated_at';

  // Table names and columns for the 'products' table
  static const tableProduct = 'products';
  static const columnProductId = 'id';
  static const columnBatchIdFK = 'batch_id';
  static const columnUserIdFK = 'user_id'; // Foreign Key
  static const columnProductName = 'name';
  static const columnCategory = 'category';
  static const columnBarcode = 'barcode';
  static const columnUnit = 'unit';
  static const columnProductCreatedAt = 'created_at';
  static const columnProductUpdatedAt = 'updated_at';

  // Table names and columns for the 'batches' table
  static const tableBatch = 'batches';
  static const columnBatchId = 'id';
  static const columnExpDate = 'exp_date';
  static const columnQuantityBatch = 'quantity';
  static const columnBatchStatus = 'status';
  static const columnCostPrice = 'cost_price';
  static const columnRetailPrice = 'retail_price';
  static const columnLocation = 'location';
  static const columnBatchCreatedAt = 'created_at';

  // Table names and columns for the 'transactions' table
  static const tableTransaction = 'transactions';
  static const columnTransactionId = 'id';
  static const columnTransactionUserIdFK = 'user_id'; // Foreign Key
  static const columnTransactionDate = 'transaction_date';
  static const columnTotalAmount = 'total_amount';
  static const columnPaymentMethod = 'payment_method';
  static const columnTransactionCreatedAt = 'created_at';

  // Table names and columns for the 'transaction_items' table
  static const tableTransactionItems = 'transaction_items';
  static const columnTransactionItemId = 'id';
  static const columnTransactionIdFK = 'transaction_id'; // Foreign Key
  static const columnProductIdFK = 'product_id'; // Foreign Key
  static const columnQuantityItems = 'quantity';
  static const columnPricePerUnit = 'price_per_unit';
  static const columnSubtotal = 'subtotal';
  static const columnTransactionItemCreatedAt = 'created_at';

  // Table names and columns for the 'discounts' table
  static const tableDiscount = 'discounts';
  static const columnDiscountId = 'id';
  static const columnDiscountType = 'discount_type';
  static const columnDiscountValue = 'discount_value';
  static const columnStartDate = 'start_date';
  static const columnEndDate = 'end_date';
  static const columnDiscountProductIdFK = 'product_id'; // Foreign Key
  static const columnDiscountTransactionIdFK = 'transaction_id'; // Foreign Key
  static const columnDiscountCreatedAt = 'created_at';
  static const columnDiscountUpdatedAt = 'updated_at';

  // Table names and columns for the 'activity_log' table
  static const tableActivityLog = 'activity_log';
  static const columnActivityLogId = 'id';
  static const columnActionType = 'action_type';
  static const columnEntityType = 'entity_type';
  static const columnEntityId = 'entity_id';
  static const columnActivityLogUserIdFK = 'user_id'; // Foreign Key
  static const columnDescription = 'description';
  static const columnDidAt = 'did_at';

  static Database? _database;

  // Singleton pattern to ensure only one instance of the database
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  // Open or create the database
  _initDatabase() async {
    // Get the path to the database location
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);

    // Open the database and enable foreign key support
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  // Enable foreign key support and create tables
  Future<void> _onCreate(Database db, int version) async {
    // Enable foreign key constraints in SQLite
    await db.execute('PRAGMA foreign_keys = ON;');

    // Create the 'users' table
    await db.execute('''
      CREATE TABLE $tableUser (
        $columnUserId TEXT PRIMARY KEY,
        $columnUsername TEXT NOT NULL,
        $columnRole TEXT NOT NULL,
        $columnRfidUid TEXT NOT NULL,
        $columnPassword TEXT NOT NULL,
        $columnCreatedAt INTEGER NOT NULL,
        $columnUpdatedAt INTEGER NOT NULL
      );
    ''');

    // Create the 'batches' table
    await db.execute('''
      CREATE TABLE $tableBatch (
        $columnBatchId TEXT PRIMARY KEY,
        $columnExpDate INTEGER NOT NULL,
        $columnQuantityBatch INTEGER NOT NULL,
        $columnBatchStatus TEXT NOT NULL,
        $columnCostPrice REAL NOT NULL,
        $columnRetailPrice REAL NOT NULL,
        $columnLocation TEXT NOT NULL,
        $columnBatchCreatedAt INTEGER NOT NULL
      );
    ''');

    // Create the 'products' table
    await db.execute('''
      CREATE TABLE $tableProduct (
        $columnProductId TEXT PRIMARY KEY,
        $columnBatchIdFK TEXT,
        $columnUserIdFK TEXT,
        $columnProductName TEXT NOT NULL,
        $columnCategory TEXT NOT NULL,
        $columnBarcode TEXT NOT NULL,
        $columnUnit TEXT NOT NULL,
        $columnProductCreatedAt INTEGER NOT NULL,
        $columnProductUpdatedAt INTEGER NOT NULL,
        FOREIGN KEY($columnBatchIdFK) REFERENCES $tableBatch($columnBatchId),
        FOREIGN KEY($columnUserIdFK) REFERENCES $tableUser($columnUserId)
      );
    ''');

    // Create the 'transactions' table
    await db.execute('''
      CREATE TABLE $tableTransaction (
        $columnTransactionId TEXT PRIMARY KEY,
        $columnTransactionUserIdFK TEXT,
        $columnTransactionDate INTEGER NOT NULL,
        $columnTotalAmount REAL NOT NULL,
        $columnPaymentMethod TEXT NOT NULL,
        $columnTransactionCreatedAt INTEGER NOT NULL,
        FOREIGN KEY($columnTransactionUserIdFK) REFERENCES $tableUser($columnUserId)
      );
    ''');

    // Create the 'transaction_items' table
    await db.execute('''
      CREATE TABLE $tableTransactionItems (
        $columnTransactionItemId TEXT PRIMARY KEY,
        $columnTransactionIdFK TEXT,
        $columnProductIdFK TEXT,
        $columnQuantityItems INTEGER NOT NULL,
        $columnPricePerUnit REAL NOT NULL,
        $columnSubtotal REAL NOT NULL,
        $columnTransactionItemCreatedAt INTEGER NOT NULL,
        FOREIGN KEY($columnTransactionIdFK) REFERENCES $tableTransaction($columnTransactionId),
        FOREIGN KEY($columnProductIdFK) REFERENCES $tableProduct($columnProductId)
      );
    ''');

    // Create the 'discounts' table
    await db.execute('''
      CREATE TABLE $tableDiscount (
        $columnDiscountId TEXT PRIMARY KEY,
        $columnDiscountType TEXT NOT NULL,
        $columnDiscountValue REAL NOT NULL,
        $columnStartDate INTEGER NOT NULL,
        $columnEndDate INTEGER NOT NULL,
        $columnDiscountProductIdFK TEXT,
        $columnDiscountTransactionIdFK TEXT,
        $columnDiscountCreatedAt INTEGER NOT NULL,
        $columnDiscountUpdatedAt INTEGER NOT NULL,
        FOREIGN KEY($columnDiscountProductIdFK) REFERENCES $tableProduct($columnProductId),
        FOREIGN KEY($columnDiscountTransactionIdFK) REFERENCES $tableTransaction($columnTransactionId)
      );
    ''');

    // Create the 'activity_log' table
    await db.execute('''
      CREATE TABLE $tableActivityLog (
        $columnActivityLogId TEXT PRIMARY KEY,
        $columnActionType TEXT NOT NULL,
        $columnEntityType TEXT NOT NULL,
        $columnEntityId TEXT NOT NULL,
        $columnActivityLogUserIdFK TEXT,
        $columnDescription TEXT NOT NULL,
        $columnDidAt INTEGER NOT NULL,
        FOREIGN KEY($columnActivityLogUserIdFK) REFERENCES $tableUser($columnUserId)
      );
    ''');
  }
}