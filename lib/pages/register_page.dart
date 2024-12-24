import 'package:flutter/material.dart';
import 'package:p1/services/auth/auth_service.dart';
import 'package:p1/components/my_button.dart';
import 'package:p1/components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final TextEditingController conformController = TextEditingController();
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  void register(BuildContext context) {
    final _auth = AuthService();
    if(pwController.text == conformController.text){
      try{
      _auth.signUpWithEmailPassword(
      emailController.text,
      pwController.text,
    );
      }catch(e){
        showDialog(
        context: context, 
        builder: (context)=> AlertDialog(
          title:Text('Error: ${e.toString()}'),
        ),
      );
      }
    }
     else{
     showDialog(
        context: context, 
        builder: (context)=> const AlertDialog(
          title:Text("Passwords don't match"),
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
            "CREATE YOUR ACC HERE",
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
          MyTextField(
            hintText: "Confirm Password",
            obscureText: true,
            controller: conformController, focusNode: null,
          ),
          const SizedBox(height: 10),
          MyButton(
            text: "REGISTER",
            onTap: () => register(context),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "If Already have an acc ,",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  "LOGIN NOW",
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
