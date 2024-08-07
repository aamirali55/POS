

import 'dart:io';

class OrderManagement {
  Map<int, List<Map<String, dynamic>>> orders = {};
  final Map<String, double> menuPrices = {
    'Chicken Corn Soup': 499.0,
    'HOT & Sour Soup': 599.0,
    'Cream of Chicken Mushroom Soup': 699.0,
    'Special Soup': 799.0,
    'French Fries': 299.0,
    'Honey Wings': 599.0,
    'Dynamite Chicken': 699.0,
    'Dynamite Prawns': 799.0,
    'Loaded Fries': 499.0,
    'Nachos': 599.0,
    'BBQ Boties': 999.0,
    'Chicken Fried rice': 899.0,
    'Chicken & Mutton Karahi': 1499.0,
    'Ice Cream': 399.0,
    'Kulfi': 299.0,
    'Lava Cake': 599.0,
    'Mineral Water': 199.0,
    'Mint Lemonade': 399.0,
    'Pina Colada': 499.0,
    'Ice Cream Shake': 599.0
  };

  void clearScreen() {
    if (Platform.isWindows) {
      stdout.write('\x1B[2J\x1B[0;0H'); // Windows
    } else {
      stdout.write('\x1B[2J\x1B[0;0H'); // Unix-based systems
    }
  }

  void run() {
    clearScreen();
    while (true) {
      print("==================================");
      print("||        Cashier Screen        ||");
      print("==================================");
      print('\n    ***************************');
      print("    ||     1. New Order      ||");
      print("    ||     2. Old Order      ||");
      print("    ||     3. Print Bill     ||");
      print("    ||     4. Payment        ||");
      print("    ||     5. Exit           ||");
      print('    ***************************');
      stdout.write("\n\n     Enter your choice: ");
      int choice = int.parse(stdin.readLineSync() ?? '0');

      switch (choice) {
        case 1:
          clearScreen();
          newOrder();
          break;
        case 2:
          oldOrder();
          break;
        case 3:
          printBill();
          break;
        case 4:
          payment();
          break;
        case 5:
          print("Exiting...");
          return;
        default:
          print("Invalid choice. Please try again.");
      }
    }
  }

  void newOrder() {
    stdout.write("\n\n     Enter Table Number:");
    int tableNumber = int.parse(stdin.readLineSync() ?? '0');
    orders.putIfAbsent(tableNumber, () => []);
    selectMenu(tableNumber);
  }

  void oldOrder() {
    stdout.write("\n\n     Enter Table Number:");
    int tableNumber = int.parse(stdin.readLineSync() ?? '0');
    if (orders.containsKey(tableNumber)) {
      print("Orders for Table $tableNumber:");
      orders[tableNumber]!.forEach((item) {
        print("${item['name']}: RS ${item['price'].toStringAsFixed(2)}");
      });
    } else {
      print("No orders found for Table $tableNumber.");
    }
  }

  void printBill() {
    stdout.write("\n\n     Enter Table Number:");
    int tableNumber = int.parse(stdin.readLineSync() ?? '0');
    if (orders.containsKey(tableNumber)) {
      double subtotal =
          orders[tableNumber]!.fold(0, (sum, item) => sum + item['price']);
      double gst = subtotal * 0.15;
      double total = subtotal + gst;
      clearScreen();
      print(
          "       =============================================================");
      print(
          "                         Bill for table $tableNumber:               ");
      print(
          "       =============================================================");
      orders[tableNumber]!.forEach((item) {
        print(
            "         ${item['name']}: RS ${item['price'].toStringAsFixed(2)}");
      });
      print("         Subtotal: RS ${subtotal.toStringAsFixed(2)}");
      print("         GST (15%): RS ${gst.toStringAsFixed(2)}");
      print(
          "       =============================================================");
      print("                          Total: RS ${total.toStringAsFixed(2)}");
      print(
          "       =============================================================");
    } else {
      print("No orders found for Table $tableNumber.");
    }
  }

  void payment() {
    print("Enter Table Number:");
    int tableNumber = int.parse(stdin.readLineSync() ?? '0');
    if (!orders.containsKey(tableNumber)) {
      print("No orders found for table $tableNumber.");
      return;
    }

    double subtotal =
        orders[tableNumber]!.fold(0, (sum, item) => sum + item['price']);
    double gst = subtotal * 0.15;
    double total = subtotal + gst;
    clearScreen();
    print(
        "       =============================================================");
    print(
        "                         Bill for table $tableNumber:               ");
    print(
        "       =============================================================");
    orders[tableNumber]!.forEach((item) {
      print("         ${item['name']}: RS ${item['price'].toStringAsFixed(2)}");
    });
    print("         Subtotal: RS ${subtotal.toStringAsFixed(2)}");
    print("         GST (15%): RS ${gst.toStringAsFixed(2)}");
    print(
        "       =============================================================");
    print("                          Total: RS ${total.toStringAsFixed(2)}");
    print(
        "       =============================================================");

    print("Select Payment Method:");
    print("1. Cash");
    print("2. Credit Card");
    int paymentChoice = int.parse(stdin.readLineSync() ?? '0');

    switch (paymentChoice) {
      case 1:
        print("Payment made with Cash");
        print("Enter amount given by customer (in rupees):");
        double amountGiven = double.parse(stdin.readLineSync() ?? '0');
        if (amountGiven < total) {
          print("Amount given is less than the total bill. Please try again.");
        } else {
          double cashBack = amountGiven - total;
          print("Cash Back Amount: ₹${cashBack.toStringAsFixed(2)}");
        }
        break;
      case 2:
        print("Payment made with Credit Card");

        break;
      default:
        print("Invalid choice. Please try again.");
    }

    orders.remove(tableNumber);
  }

  void selectMenu(int tableNumber) {
    clearScreen();
    while (true) {
      print("==================================");
      print("||        Select Menu           ||");
      print("==================================");
      print('\n   ***************************');
      print("   ||  1. Soup & Salad      ||");
      print("   ||  2. Starter           ||");
      print("   ||  3. Main Course       ||");
      print("   ||  4. Dessert           ||");
      print("   ||  5. Beverages         ||");
      print("   ||  6. Back to Main Menu ||");
      print('   ***************************');
      stdout.write("\n\n     Enter your choice: ");
      int menuChoice = int.parse(stdin.readLineSync() ?? '0');

      if (menuChoice == 6) break;

      selectItems(tableNumber, menuChoice);
    }
  }

  void selectItems(int tableNumber, int menuChoice) {
    String menuType;

    switch (menuChoice) {
      case 1:
        menuType = "Soup & Salad";
        break;
      case 2:
        menuType = "Starter";
        break;
      case 3:
        menuType = "Main Course";
        break;
      case 4:
        menuType = "Dessert";
        break;
      case 5:
        menuType = "Beverages";
        break;
      default:
        print("Invalid choice. Please try again.");
        return;
    }

    while (true) {
      print("Select $menuType:");
      printMenu(menuType);
      stdout.write("\n\n     Enter your choice (or 0 to go back):");
      int itemChoice = int.parse(stdin.readLineSync() ?? '0');

      if (itemChoice == 0) {
        clearScreen();
        break;
      }

      String item = getMenuItem(menuType, itemChoice);
      double price = menuPrices[item] ?? 0.0;

      if (item.isNotEmpty) {
        orders[tableNumber]!.add({'name': item, 'price': price});
        stdout.write("\n\n     $item added to table $tableNumber");
      } else {
        print("Invalid choice. Please try again.");
      }

      stdout.write("\n\n     Press Enter to continue...");
      stdin.readLineSync();
    }
  }

  void printMenu(String menuType) {
    clearScreen();
    switch (menuType) {
      case "Soup & Salad":
        print("       ==================================");
        print("       ||        Soup & Salad          ||");
        print("       ==================================");
        print('\n     **************************************');
        print("     || 1. Chicken Corn Soup             ||");
        print("     || 2. HOT & Sour Soup               ||");
        print("     || 3. Cream of Chicken Mushroom Soup||");
        print("     || 4. Special Soup                  ||");
        print('     **************************************');
        break;
      case "Starter":
        print("       ==================================");
        print("       ||           Starter            ||");
        print("       ==================================");
        print('\n     **************************************');
        print("     || 1. French Fries                  ||");
        print("     || 2. Honey Wings                   ||");
        print("     || 3. Dynamite Chicken              ||");
        print("     || 4. Dynamite Prawns               ||");
        print("     || 5. Loaded Fries                  ||");
        print("     || 6. Nachos                        ||");
        print('     **************************************');
        break;
      case "Main Course":
        print("       ==================================");
        print("       ||          Main Course         ||");
        print("       ==================================");
        print('\n     **************************************');
        print("     || 1. BBQ Boties                    ||");
        print("     || 2. Chicken Fried rice            ||");
        print("     || 3. Chicken & Mutton Karahi       ||");
        print('     **************************************');
        break;
      case "Dessert":
        print("       ==================================");
        print("       ||          Dessert             ||");
        print("       ==================================");
        print('\n     **************************************');
        print("     || 1. Ice Cream                     ||");
        print("     || 2. Kulfi                         ||");
        print("     || 3. Lava Cake                     ||");
        print('     **************************************');
        break;
      case "Beverages":
        print("       ==================================");
        print("       ||          Beverages           ||");
        print("       ==================================");
        print('\n     **************************************');
        print("     || 1. Mineral Water                 ||");
        print("     || 2. Mint Lemonade                 ||");
        print("     || 3. Pina Colada                   ||");
        print("     || 4. Ice Cream Shake               ||");
        print('     **************************************');
        break;
    }
  }

  String getMenuItem(String menuType, int itemChoice) {
    Map<int, String> items = {};
    switch (menuType) {
      case "Soup & Salad":
        items = {
          1: 'Chicken Corn Soup',
          2: 'HOT & Sour Soup',
          3: 'Cream of Chicken Mushroom Soup',
          4: 'Special Soup'
        };
        break;
      case "Starter":
        items = {
          1: 'French Fries',
          2: 'Honey Wings',
          3: 'Dynamite Chicken',
          4: 'Dynamite Prawns',
          5: 'Loaded Fries',
          6: 'Nachos'
        };
        break;
      case "Main Course":
        items = {
          1: 'BBQ Boties',
          2: 'Chicken Fried rice',
          3: 'Chicken & Mutton Karahi'
        };
        break;
      case "Dessert":
        items = {1: 'Ice Cream', 2: 'Kulfi', 3: 'Lava Cake'};
        break;
      case "Beverages":
        items = {
          1: 'Mineral Water',
          2: 'Mint Lemonade',
          3: 'Pina Colada',
          4: 'Ice Cream Shake'
        };
        break;
    }
    return items[itemChoice] ?? '';
  }
}
