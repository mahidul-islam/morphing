import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morphing/app/bloc/notification/notification_bloc.dart';
import 'package:morphing/app/pages/home/model/home_model.dart';
import 'package:morphing/app/pages/login/bloc/login_bloc.dart';
import 'package:morphing/app/routes/routes.dart';
import 'package:morphing/shared/util/loader.dart';

class LoginUI extends StatefulWidget {
  @override
  _LoginUIState createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  late LoginBloc _bloc;

  @override
  void initState() {
    _bloc = LoginBloc();
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: BlocProvider<LoginBloc>(
          create: (BuildContext context) => _bloc,
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (BuildContext context, LoginState state) {},
            builder: (BuildContext context, LoginState state) {
              return RefreshIndicator(
                onRefresh: () async {
                  // _bloc.homeReload();
                },
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: Container(
                        height: 150,
                        child: Center(
                          child: Text('Login Page'),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
