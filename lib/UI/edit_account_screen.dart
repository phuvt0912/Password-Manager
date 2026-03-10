import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../models/accounts.dart';

class EditAccountScreen extends StatefulWidget {
  final Account account;
  EditAccountScreen({Key? key, required this.account}) : super(key: key);

  @override
  _EditAccountScreenState createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  final typeController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future updateAccount() async {
    final account = Account(
      accountType: typeController.text,
      username: usernameController.text,
      password: passwordController.text,
    );

    await DatabaseHelper.instance.updateAccount(account.toMap());

    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    typeController.text = widget.account.accountType;
    usernameController.text = widget.account.username;
    passwordController.text = widget.account.password;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chỉnh sửa thông tin tài khoản"),
      ),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: typeController,
              decoration: InputDecoration(
                labelText: "Loại tài khoản"
              ),
            ),

            SizedBox(height: 10),

            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: "Tên tài khoản",
              ),
            ),

            SizedBox(height: 10),

            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: "Mật khẩu",
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: updateAccount,
              child: Text("Lưu"),
            )

          ],
        ),
      ),
    );
  }
}