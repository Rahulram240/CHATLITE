import 'package:flutter/material.dart';
import 'package:p1/services/auth/auth_service.dart';
import 'package:p1/components/my_button.dart';
import 'package:p1/components/my_textfield.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();

  final void Function()? onTap;

  LoginPage({super.key, this.onTap});

  void login(BuildContext context) async {
    final authService = AuthService();

    try{
      await authService.signInWithEmailPassword(emailController.text, pwController.text);
    } 
    catch(e){
      showDialog(
        context: context, 
        builder: (context)=> AlertDialog(
          title:Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.message,
            size: 60,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 25),
          Text(
            "HEY THERE SEND SOME MSG",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 25),
          MyTextField(
            hintText: "Email",
            obscureText: false,
            controller: emailController, focusNode: null,
          ),
          const SizedBox(height: 10),
          MyTextField(
            hintText: "Password",
            obscureText: true,
            controller: pwController, focusNode: null,
          ),
          const SizedBox(height: 10),
          MyButton(
            text: "LOGIN",
            onTap: ()=> login(context),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "If not signed in ,",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  "REGISTER NOW",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
