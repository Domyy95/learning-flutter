import 'package:bloc_pattern/app_routes.dart';
import 'package:bloc_pattern/constant.dart';
import 'package:bloc_pattern/cubit/auth_cubit.dart';
import 'package:bloc_pattern/screens/home.dart';
import 'package:bloc_pattern/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  final formKey = GlobalKey<FormBuilderState>();
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: GestureDetector(
          onTap: () => Focus.of(context).unfocus(),
          child: Scaffold(
              body: BlocConsumer<AuthCubit, AuthState>()(
            listener: (state, context) {
              if (state is AuthLoginError) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text(state.errorMessage!)));
              }

              if (state is AuthLoginSuccess) {
                formKey.currentState!.fields!.clear();
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => home()));
              }
            },
            builder: (state, context) => _buildLoginScreen(),
          )),
        ));
  }

  Widget _buildLoginScreen() {
    return SafeArea(
        child: FormBuilder(
      key: formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Center(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Image(
              image: AssetImage('assets/logo.png'),
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: FormBuilderTextField(
                  textInputAction: TextInputAction.next,
                  name: "email",
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.email(context,
                        errorText: "Enter a valid email address")
                  ]),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    prefixIcon: const Icon(Icons.email),
                    hintText: "Enter Email",
                    hintStyle: kHintStyle,
                    fillColor: Colors.grey,
                    filled: true,
                    enabledBorder: kOutlikeBorder,
                    focusedBorder: kOutlikeBorder,
                    errorBorder: kOutlineErrorBorder,
                    focusedErrorBorder: kOutlineErrorBorder,
                  )),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: FormBuilderTextField(
                  textInputAction: TextInputAction.done,
                  name: "password",
                  obscureText: isObscure,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      prefixIcon: const Icon(Icons.lock),
                      hintText: "Enter Password",
                      hintStyle: kHintStyle,
                      fillColor: Colors.grey,
                      filled: true,
                      enabledBorder: kOutlikeBorder,
                      focusedBorder: kOutlikeBorder,
                      errorBorder: kOutlineErrorBorder,
                      focusedErrorBorder: kOutlineErrorBorder,
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                        child: Icon(
                          isObscure
                              ? Icons.radio_button_off
                              : Icons.radio_button_checked,
                        ),
                      ))),
            ),
            const SizedBox(
              height: 25,
            ),
            LoginButton(onPressed: () async {
              if (formKey.currentState!.validate()) {
                final authCubit = BlocProvider.of<AuthCubit>(context);
                await authCubit.login(
                    formKey.currentState!.fields['email']!.value,
                    formKey.currentState!.fields['password']!.value);
              }
            }),
            TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, AppRoutes.forgotPassword),
                child: const Text('Forgot Password')),
            const Divider(height: 20, endIndent: 10, indent: 8),
            SizedBox(height: 20,),
            CustomButton(
                child: const Text("Create an Account"),
                onPressed: () => Navigator.pushNamed(context, AppRoutes.signup))
          ]),
        ),
      ),
    ));
  }

  Future<bool> _onWillPop(BuildContext context) async {
    bool shouldPop = false;
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Are you sure?'),
              content:
                  const Text('Do you want to disconnect device and go back?'),
              actions: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      // shouldPop is already false
                    },
                    child: const Text('No')),
                ElevatedButton(
                    onPressed: () async {
                      await disconnectFromDevice();
                      Navigator.of(context).pop();
                      shouldPop = true;
                    },
                    child: const Text('Yes')),
              ],
            ));
    return shouldPop;
  }
}

class LoginButton extends StatelessWidget {
  final Function onPressed;

  const LoginButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
        onPressed: onPressed,
        child: BlocConsumer<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is AuthLoginLoading) {
                return kLoaderBtn;
              } else {
                return const Text("Login");
              }
            },
            listener: (context, state) {}));
  }
}
