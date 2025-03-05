import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart'; // Import image picker
import 'dart:io'; // To handle the image file

import '../../../core/constant/images.dart';
import '../../../core/error/failures.dart';
import '../../../core/router/app_router.dart';
import '../../../domain/usecases/user/sign_up_usecase.dart';
import '../../blocs/cart/cart_bloc.dart';
import '../../blocs/user/user_bloc.dart';
import '../../widgets/input_form_button.dart';
import '../../widgets/input_text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  XFile? _image; // Store the selected image
  final ImagePicker _picker = ImagePicker();

  // Function to show the options dialog
  Future<void> _showImageSourceDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Image Source'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                try {
                  // Pick an image from the gallery
                  final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      _image = pickedFile;
                    });
                  }
                } catch (e) {
                  EasyLoading.showError('Failed to pick image: $e');
                }
              },
              child: const Text('Gallery'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                try {
                  // Pick an image from the camera
                  final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    setState(() {
                      _image = pickedFile;
                    });
                  }
                } catch (e) {
                  EasyLoading.showError('Failed to pick image: $e');
                }
              },
              child: const Text('Camera'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        EasyLoading.dismiss();
        if (state is UserLoading) {
          EasyLoading.show(status: 'Loading...');
        } else if (state is UserLogged) {
          context.read<CartBloc>().add(const GetCart());
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRouter.home,
            ModalRoute.withName(''),
          );
        } else if (state is UserLoggedFail) {
          if (state.failure is CredentialFailure) {
            EasyLoading.showError("Username/Password Wrong!");
          } else {
            EasyLoading.showError("Error");
          }
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                        height: 80,
                        child: Image.asset(
                          kAppLogo,
                          color: Colors.black,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Please use your e-mail address to create a new account",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    // Image picker above input fields
                    GestureDetector(
                      onTap: _showImageSourceDialog, // Open the dialog
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: _image == null
                            ? const Icon(
                                Icons.camera_alt,
                                color: Colors.black54,
                                size: 40,
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  File(_image!.path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Form Fields below the image picker
                    InputTextFormField(
                      controller: firstNameController,
                      hint: 'First Name',
                      textInputAction: TextInputAction.next,
                      validation: (String? val) {
                        if (val == null || val.isEmpty) {
                          return 'This field can\'t be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    InputTextFormField(
                      controller: lastNameController,
                      hint: 'Last Name',
                      textInputAction: TextInputAction.next,
                      validation: (String? val) {
                        if (val == null || val.isEmpty) {
                          return 'This field can\'t be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    InputTextFormField(
                      controller: emailController,
                      hint: 'Email',
                      textInputAction: TextInputAction.next,
                      validation: (String? val) {
                        if (val == null || val.isEmpty) {
                          return 'This field can\'t be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    InputTextFormField(
                      controller: passwordController,
                      hint: 'Password',
                      textInputAction: TextInputAction.next,
                      isSecureField: true,
                      validation: (String? val) {
                        if (val == null || val.isEmpty) {
                          return 'This field can\'t be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    InputTextFormField(
                      controller: confirmPasswordController,
                      hint: 'Confirm Password',
                      isSecureField: true,
                      textInputAction: TextInputAction.go,
                      validation: (String? val) {
                        if (val == null || val.isEmpty) {
                          return 'This field can\'t be empty';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) {
                        if (_formKey.currentState!.validate()) {
                          if (passwordController.text !=
                              confirmPasswordController.text) {
                          } else {
                            context.read<UserBloc>().add(SignUpUser(SignUpParams(
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                            )));
                          }
                        }
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    InputFormButton(
                      color: Colors.black87,
                      onClick: () {
                        if (_formKey.currentState!.validate()) {
                          if (passwordController.text !=
                              confirmPasswordController.text) {
                          } else {
                            context.read<UserBloc>().add(SignUpUser(SignUpParams(
                                  firstName: firstNameController.text,
                                  lastName: lastNameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                )));
                          }
                        }
                      },
                      titleText: 'Sign Up',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InputFormButton(
                      color: Colors.black87,
                      onClick: () {
                        Navigator.of(context).pop();
                      },
                      titleText: 'Back',
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
