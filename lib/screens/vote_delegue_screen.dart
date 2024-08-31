import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uac_vote2/blocs/delegue/delegue_bloc.dart';
import 'package:uac_vote2/components/CandidatTile.dart';
import 'package:uac_vote2/models/candidat.dart';
import 'package:uac_vote2/screens/billetet_vote_screen.dart';

import '../blocs/bulletin/bulletin_bloc.dart';
import '../components/DialogTile.dart';

class VoteDelegueScreen extends StatelessWidget {
  const VoteDelegueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Column(
        children: [
          const SizedBox(
            height: 64,
          ),
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.blue.shade900,
            child: const Text(
              "3",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Text(
            "Vote déleguée",
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
            child: BlocBuilder<DelegueBloc, DelegueState>(
              builder: (context, state) {
                if (state is DelegueLoadedSuccess) {
                  return ListView.builder(
                    itemCount: state.candidats.length,
                    itemBuilder: (context, index) {
                      var t = state.candidats[index];
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
                                      const BilletinVoteScreen(),
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
