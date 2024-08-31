import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            SizedBox(
              height: 56,
            ),
            const Text(
              "UAC-Vote",
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "Bienvenu a notre systeme de vote",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w400,
              ),
            ),
            Image.asset(
              "images/bnb.jpeg",
              height: 250,
            ),
            const Spacer(),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed("login_screen");
              },
              style: ElevatedButton.styleFrom(
                //minimumSize: Size(width, height)
                minimumSize: const Size.fromHeight(56),
                shape: const StadiumBorder(),
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
              child: const Text("Connexion"),
            ),
            const SizedBox(
              height: 32,
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pushNamed("calendriel_screen");
              },
              style: ElevatedButton.styleFrom(
                //minimumSize: Size(width, height)
                minimumSize: const Size.fromHeight(56),
                shape: const StadiumBorder(),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text("Voir Calendrier"),
            ),
            const SizedBox(
              height: 32,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed("main_screen");
              },
              style: OutlinedButton.styleFrom(
                //minimumSize: Size(width, height)
                minimumSize: const Size.fromHeight(56),
                shape: const StadiumBorder(
                    side: BorderSide(
                  color: Colors.black,
                )),
                //backgroundColor: Colors.blue,
                foregroundColor: Colors.black,
              ),
              child: const Text("Voir resultat"),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
