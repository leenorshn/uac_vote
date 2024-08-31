import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uac_vote2/api/vote_api.dart';
import 'package:uac_vote2/blocs/bulletin/bulletin_bloc.dart';
import 'package:uac_vote2/blocs/login/login_bloc.dart';
import 'package:uac_vote2/components/CandidatTile.dart';
import 'package:uac_vote2/screens/vote_president_screen.dart';

class BilletinVoteScreen extends StatelessWidget {
  const BilletinVoteScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      appBar: AppBar(
        title: const Text("Bulletin de vote"),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<LoginBloc, LoginState>(
        bloc: BlocProvider.of<LoginBloc>(context)..add(LoadUserEvent()),
        builder: (context, stat) {
          if (stat is UserIsLoading) {
            return const LinearProgressIndicator();
          } else if (stat is UserLoaded) {
            return BlocBuilder<BulletinBloc, BulletinState>(
              builder: (context, state) {
                if (state is BulletinLoadedSuccess) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        BulletinTile(candidat: state.data[0]),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child:
                                      BulletinRowTile(candidat: state.data[1])),
                              Expanded(
                                  child:
                                      BulletinRowTile(candidat: state.data[2])),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  fixedSize: const Size(150, 44),
                                  backgroundColor: Colors.pink,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              VotePresidentScreen()),
                                      (route) => false);
                                },
                                child: const Text("Annuler"),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  fixedSize: const Size(200, 44),
                                  backgroundColor: const Color(0xFF21CE99),
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                ),
                                onPressed: () async {
                                  /// effectuer 3 processus de votes
                                  /// 1 president
                                  await VoteApi()
                                      .addVote(state.data[0], stat.user);
                                  // /// 2 vice president
                                  await VoteApi()
                                      .addVote(state.data[1], stat.user);
                                  //
                                  // /// 3 delegue
                                  await VoteApi()
                                      .addVote(state.data[2], stat.user);

                                  /// app
                                  await VoteApi()
                                      .updateVoteOnClient(stat.user.id);
                                  BlocProvider.of<BulletinBloc>(context)
                                      .add(VideBulletinEvent());
                                  Navigator.of(context)
                                      .pushNamed("main_screen");
                                },
                                child: const Text("Terminer"),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }
                return Container();
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
