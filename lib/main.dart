import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uac_vote2/api/auth_api.dart';
import 'package:uac_vote2/api/condidate_api.dart';
import 'package:uac_vote2/blocs/President/president_bloc.dart';
import 'package:uac_vote2/blocs/bulletin/bulletin_bloc.dart';
import 'package:uac_vote2/blocs/delegue/delegue_bloc.dart';
import 'package:uac_vote2/blocs/login/login_bloc.dart';
import 'package:uac_vote2/screens/login_screen.dart';
import 'package:uac_vote2/screens/main_screen.dart';
import 'package:uac_vote2/screens/vote_president_screen.dart';
import 'package:uac_vote2/screens/vote_vice_president_screen.dart';
import 'package:uac_vote2/screens/welcome_screen.dart';

import 'blocs/VicePresident/vice_president_bloc.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              PresidentBloc(CandidatApi())..add(LoadPresidentEvent()),
        ),
        BlocProvider(
          create: (context) => LoginBloc(AuthApi())..add(LoginElectorEvent()),
        ),
        BlocProvider(
          create: (context) =>
              DelegueBloc(CandidatApi())..add(LoadDelegueEvent()),
        ),
        BlocProvider(
          create: (context) =>
              VicePresidentBloc(CandidatApi())..add(LoadVicePresidentEvent()),
        ),
        BlocProvider(
          create: (context) => BulletinBloc()..add(LoadBulletinEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Vote UAC',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: false,
        ),
        home: const RootScreen(),
        navigatorKey: NavigationService.navigatorKey,
        routes: {
          "vote_president": (context) => const VotePresidentScreen(),
          "vote_vice_president": (context) => const VoteVicePresidentScreen(),
          "main_screen": (context) => const MainScreen(),
          "login_screen": (context) => const LoginScreen()
        },
      ),
    );
  }
}

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoginSuccess) {
          if (state.elector) {
            return const MainScreen();
          } else {
            return const WelcomeScreen();
          }
        }
        return const WelcomeScreen();
      },
    );
  }
}
