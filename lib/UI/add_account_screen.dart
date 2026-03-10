import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../models/accounts.dart';

class AddAccountScreen extends StatefulWidget {
  @override
  _AddAccountScreenState createState() => _AddAccountScreenState();
}

class _AddAccountScreenState extends State<AddAccountScreen> {

  final typeController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future saveAccount() async {
    final account = Account(
      accountType: typeController.text,
      username: usernameController.text,
      password: passwordController.text,
    );

    await DatabaseHelper.instance.insertAccount(account.toMap());

    Navigator.pop(context); // quay lại màn Home
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thêm thông tin tài khoản"),
      ),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: typeController,
              decoration: InputDecoration(
                labelText: "Loại tài khoản",
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
              onPressed: saveAccount,
              child: Text("Lưu"),
            )

          ],
        ),
      ),
    );
  }
}