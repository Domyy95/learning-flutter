import 'package:bloc_pattern/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constant.dart';
import '../cubit/auth_cubit.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Focus.of(context).unfocus(),
      child: Scaffold(
          body: BlocConsumer<AuthCubit, AuthState>()(
        listener: (state, context) {
          if (state is AuthForgotPasswordError) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text(state.err!),
                backgroundColor: Colors.red,
              ));
          }

          if (state is AuthForgotPasswordSuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(const SnackBar(
                content: Text("Reset link has been sent to your email!"),
                backgroundColor: Colors.green,
                
              )
              );
              Navigator.of(context).pop();
          }
        },
        builder: (state, context) {
          if (state is AuthDefault) {
            return _buildForgotPasswordScreen();
          } else if (state is AuthForgotPasswordLoading) {
            return loader();
          } else if (state is AuthForgotPasswordSuccess) {
            return _buildForgotPasswordScreen();
          } else {
            return _buildForgotPasswordScreen();
          }
        },
      )),
    );
  }

  Widget _buildForgotPasswordScreen() {
    return SafeArea(
        child: FormBuilder(
      key: formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: BackButton(
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const Spacer(),
              const Image(
                image: AssetImage('assets/logo.png'),
                height: 100,
                width: 100,
              ),
              const Text("Forgot Password?", style: kHeadingStyle,),
              const SizedBox(height: 25,),
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
            const SizedBox(height: 25,),
            SendLinkButton(onPressed: 
            () async {
              if(formKey.currentState!.validate()) {
                final authCubit = BlocProvider.of<AuthCubit>(context);
                await authCubit.forgotPassword(formKey.currentState!.fields['email']!.value);
              }
            }),
            const Spacer(flex: 2,),

            ],
          ),
        ),
      ),
    ));
  }

  Widget loader() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class SendLinkButton extends StatelessWidget {
  final Function onPressed;
  const SendLinkButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(onPressed: onPressed, child: Text('Send Link'));
  }
}
