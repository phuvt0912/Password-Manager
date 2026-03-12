import 'package:flutter/material.dart';
import 'package:password_manager/UI/add_account_screen.dart';
import '../database/db_helper.dart';
import '../models/accounts.dart';
import 'edit_account_screen.dart';
import '../database/sharepref_helper.dart';

class HomeScreen extends StatefulWidget {
  bool isDarkMode = false;
  Future<void> Function(bool) onThemeChanged;

  HomeScreen({required this.isDarkMode, required this.onThemeChanged});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Account> accounts = [];
  @override
  void initState() {
    super.initState();
    loadThemeState();
    loadAccounts();

  }


  Future loadAccounts() async {
    final data = await DatabaseHelper.instance.getAccounts();
    List<Account> datas = [];

    for (var item in data) {
      datas.add(Account.fromMap(item));
    }
    setState(() {
      accounts = datas;
    });
  }

  Future<void> loadThemeState() async {
    bool themeState = await Shareprefshelper.getThemeState();
    setState(() {
      widget.isDarkMode = themeState;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quản lý mật khẩu"),
        actions: [
          Switch(value: widget.isDarkMode, onChanged: widget.onThemeChanged)
        ],
      ),

      body: accounts.isEmpty
    ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/frieren.png",
              width: 200,
            ),
            SizedBox(height: 20),
            Text(
              "Chưa có tài khoản nào",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            )
          ],
        ),
      )
          :
       ListView.builder(
        itemCount: accounts.length,
        itemBuilder: (context, index) {

          final account = accounts[index];
          return ListTile(
            title: Text(account.accountType),
            subtitle: Text(account.username),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () async {

                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditAccountScreen(account: account),
                      ),
                    );

                    loadAccounts();

                  },
                ),

                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    await DatabaseHelper.instance.deleteAccount(account.id!);
                    loadAccounts();
                  },
                )
              ],
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {

          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddAccountScreen(),
            ),
          );

          loadAccounts();

        },
        child: Icon(Icons.add),
      ),
    );
  }
}