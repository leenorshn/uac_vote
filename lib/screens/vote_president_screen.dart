import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uac_vote2/blocs/President/president_bloc.dart';
import 'package:uac_vote2/blocs/bulletin/bulletin_bloc.dart';
import 'package:uac_vote2/components/CandidatTile.dart';
import 'package:uac_vote2/components/DialogTile.dart';
import 'package:uac_vote2/models/candidat.dart';

class VotePresidentScreen extends StatelessWidget {
  const VotePresidentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      body: Column(
        children: [
          const SizedBox(
            height: 64,
          ),
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.blue.shade900,
            child: const Text(
              "1",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Text(
            "Vote Presidentiel",
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
            child: BlocBuilder<PresidentBloc, PresidentState>(
              builder: (context, state) {
                if (state is PresidentIsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is PresidentLoadedSuccess) {
                  return ListView.builder(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 24,
                      bottom: 90,
                    ),
                    itemCount: state.candidats.length,
                    itemBuilder: (context, index) {
                      var candidat = state.candidats[index];
                      return CandidatTile(
                          candidat: candidat,
                          onTap: () {
                            BlocProvider.of<BulletinBloc>(context)
                                .add(AddPresidentInBulletinEvent(candidat));
                            showDialogConfirmation(context, candidat, () {
                              Navigator.of(context)
                                  .pushNamed("vote_vice_president");
                            });
                          });
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
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
