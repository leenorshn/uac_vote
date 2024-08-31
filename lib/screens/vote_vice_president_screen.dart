import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uac_vote2/blocs/VicePresident/vice_president_bloc.dart';
import 'package:uac_vote2/components/CandidatTile.dart';
import 'package:uac_vote2/models/candidat.dart';
import 'package:uac_vote2/screens/vote_delegue_screen.dart';

import '../blocs/bulletin/bulletin_bloc.dart';
import '../components/DialogTile.dart';

class VoteVicePresidentScreen extends StatelessWidget {
  const VoteVicePresidentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade50,
      body: Column(
        children: [
          const SizedBox(
            height: 64,
          ),
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.blue.shade900,
            child: const Text(
              "2",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Text(
            "Vote Vice Presidentiel",
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "Veillez choisir votre candidat",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
          Expanded(
            child: BlocBuilder<VicePresidentBloc, VicePresidentState>(
              builder: (context, state) {
                if (state is VicePresidentLoadedSuccess) {
                  return ListView.builder(
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      var t = state.data[index];
                      return CandidatTile(
                        candidat: t,
                        onTap: () {
                          showDialogConfirmation(
                            context,
                            t,
                            () {
                              BlocProvider.of<BulletinBloc>(context)
                                  .add(AddVicePresidentInBulletinEvent(t));
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const VoteDelegueScreen(),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  void showDialogConfirmation(context, Candidat candidat, VoidCallback onTap) {
    showDialog(
        context: context,
        builder: (context) {
          return DialogTile(candidat: candidat, onTap: onTap);
        });
  }
}
