import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uac_vote2/api/auth_api.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var matricule = "";
  var password = "";
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          children: [
            const SizedBox(
              height: 56,
            ),
            const Text(
              "Vote UAC",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Connectez-vous",
            ),
            const SizedBox(
              height: 60,
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  matricule = value;
                });
              },
              decoration: const InputDecoration(
                  label: Text("Matricule"),
                  hintText: "EX: #982019",
                  prefixIcon: Icon(CupertinoIcons.number),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(),
                  disabledBorder: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              decoration: const InputDecoration(
                  label: Text("Password"),
                  hintText: "EX: 1234",
                  prefixIcon: Icon(CupertinoIcons.lock),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(),
                  disabledBorder: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 80,
            ),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      // BlocProvider.of<LoginBloc>(context).add(LoginElectorEvent(matricule, password));
                      var elector =
                          await AuthApi().createAccount(matricule, password);
                      if (elector != null) {
                        Navigator.of(context).pushNamed("vote_president");
                        //BlocProvider.of<LoginBloc>(context).add(LoginElectorEvent());
                      }
                      setState(() {
                        isLoading = false;
                      });
                    },
                    child: const Text("Connexion"),
                  )
          ],
        ),
      ),
    );
  }
}
