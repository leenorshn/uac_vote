import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uac_vote2/blocs/President/president_bloc.dart';
import 'package:uac_vote2/blocs/VicePresident/vice_president_bloc.dart';
import 'package:uac_vote2/blocs/delegue/delegue_bloc.dart';
import 'package:uac_vote2/components/result_component.dart';
import 'package:uac_vote2/screens/vote_president_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 24,
            ),
            const Text(
              "Resultat",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            BlocBuilder<PresidentBloc, PresidentState>(
              builder: (context, state) {
                if (state is PresidentLoadedSuccess) {
                  return ResultComponent(
                    title: "President",
                    candidats: state.candidats,
                    electors: 500,
                  );
                }
                return const ResultComponent(
                    title: "President", candidats: [], electors: 0);
              },
            ),
            BlocBuilder<VicePresidentBloc, VicePresidentState>(
              builder: (context, state) {
                if (state is VicePresidentLoadedSuccess) {
                  return ResultComponent(
                      title: "Vice-President",
                      candidats: state.data,
                      electors: 500);
                }
                return const ResultComponent(
                    title: "Vice-President", candidats: [], electors: 0);
              },
            ),
            BlocBuilder<DelegueBloc, DelegueState>(
              builder: (context, state) {
                if (state is DelegueLoadedSuccess) {
                  return ResultComponent(
                    title: "Delegue",
                    candidats: state.candidats,
                    electors: 30,
                  );
                }
                return const ResultComponent(
                    title: "Delegue", candidats: [], electors: 0);
              },
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const VotePresidentScreen()));
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.black,
                ),
                child: Text("Aller voter"),
              ),
            ),
            const SizedBox(
              height: 56,
            ),
          ],
        ),
      ),
    );
  }
}
