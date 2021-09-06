import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morphing/app/bloc/notification/notification_bloc.dart';
import 'package:morphing/app/pages/home/model/home_model.dart';
import 'package:morphing/app/pages/register/bloc/register_bloc.dart';
import 'package:morphing/app/routes/routes.dart';
import 'package:morphing/shared/util/loader.dart';

class RegisterUI extends StatefulWidget {
  @override
  _RegisterUIState createState() => _RegisterUIState();
}

class _RegisterUIState extends State<RegisterUI> {
  late RegisterBloc _bloc;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passController;
  late TextEditingController _passConfirmController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passController = TextEditingController();
    _passConfirmController = TextEditingController();

    _bloc = RegisterBloc();
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
        child: BlocProvider<RegisterBloc>(
          create: (BuildContext context) => _bloc,
          child: BlocConsumer<RegisterBloc, RegisterState>(
            listener: (BuildContext context, RegisterState state) {
              if (state is RegisterErrorState) {
                BlocProvider.of<NotificationBloc>(context)
                    .add(ErrorNotificationEvent(state.error));
              } else if (state is RegisterSuccessState) {
                // TODO : Navigate to profile
              }
            },
            builder: (BuildContext context, RegisterState state) {
              if (state is RegisterLoadingState) {
                return Loader.circular();
              }
              return CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Container(
                      height: 150,
                      child: Center(
                        child: Text('Register Page'),
                      ),
                    ),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _emailField(),
                          _nameField(),
                          _passField(),
                          _passConfirmField(),
                          SizedBox(height: 50),
                          _createAccountButton(),
                          SizedBox(height: 50),
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _emailField() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: TextField(
        controller: _emailController,
        decoration: InputDecoration(
          hintText: 'E - MAIL',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 1, color: Colors.blueGrey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 2, color: Colors.blueGrey),
          ),
        ),
      ),
    );
  }

  Widget _nameField() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: TextField(
        controller: _nameController,
        decoration: InputDecoration(
          hintText: 'NAME',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 1, color: Colors.blueGrey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 2, color: Colors.blueGrey),
          ),
        ),
      ),
    );
  }

  Widget _passField() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: TextField(
        controller: _passController,
        decoration: InputDecoration(
          hintText: 'PASSWORD',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 1, color: Colors.blueGrey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 2, color: Colors.blueGrey),
          ),
        ),
      ),
    );
  }

  Widget _passConfirmField() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: TextField(
        controller: _passConfirmController,
        decoration: InputDecoration(
          hintText: 'CONFIRM PASSWORD',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 1, color: Colors.blueGrey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 2, color: Colors.blueGrey),
          ),
        ),
      ),
    );
  }

  Widget _createAccountButton() {
    return Container(
      child: RawMaterialButton(
        onPressed: () {
          _bloc.add(
            RegisterDoneTappedEvent(
              name: _nameController.text,
              passwordConfirm: _passConfirmController.text,
              email: _emailController.text,
              password: _passController.text,
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Create Account',
            ),
          ],
        ),
      ),
      margin: const EdgeInsets.all(16),
      height: 56,
      decoration: BoxDecoration(
        color: Colors.amberAccent,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
