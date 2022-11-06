import 'package:bnsp_mobile/home.dart';
import 'package:bnsp_mobile/services/authentication_service.dart';
import 'package:bnsp_mobile/signup_page.dart';
import 'package:bnsp_mobile/widgets/widgets.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  void showSnackBar(String title) {
    final snackbar = SnackBar(
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  var emailIdController = TextEditingController();
  var passwordController = TextEditingController();
  bool _isObscure = true;
  bool _isObscure2 = true;

  Widget _buildLogin() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          TextFormField(
            controller: emailIdController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  icon: Icon(
                      _isObscure ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  }),
              filled: true,
              fillColor: Color.fromRGBO(220, 240, 241, 67),
              hintText: 'Email',
              hintStyle: GoogleFonts.kameron(
                fontSize: 12,
              ),
              enabled: true,
              contentPadding:
                  const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 15.0),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    new BorderSide(color: Color.fromRGBO(220, 240, 241, 67)),
                borderRadius: new BorderRadius.circular(10),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide:
                    new BorderSide(color: Color.fromRGBO(220, 240, 241, 67)),
                borderRadius: new BorderRadius.circular(10),
              ),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  icon: Icon(
                      _isObscure ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  }),
              filled: true,
              fillColor: Color.fromRGBO(220, 240, 241, 67),
              hintText: 'Password',
              hintStyle: GoogleFonts.kameron(
                fontSize: 12,
              ),
              enabled: true,
              contentPadding:
                  const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 15.0),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    new BorderSide(color: Color.fromRGBO(220, 240, 241, 67)),
                borderRadius: new BorderRadius.circular(10),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide:
                    new BorderSide(color: Color.fromRGBO(220, 240, 241, 67)),
                borderRadius: new BorderRadius.circular(10),
              ),
            ),
            validator: (value) {
              RegExp regex = new RegExp(r'^.{6,}$');
              if (value!.isEmpty) {
                return "Password cannot be empty";
              }
              if (!regex.hasMatch(value)) {
                return ("please enter valid password min. 6 character");
              } else {
                return null;
              }
            },
            onChanged: (value) {},
          ),
          SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () async {
              // network connectivity
              var connectivityResult = await Connectivity().checkConnectivity();
              if (connectivityResult != ConnectivityResult.mobile &&
                  connectivityResult != ConnectivityResult.wifi) {
                showSnackBar('No Internet connectivity');
                return;
              }

              if (!emailIdController.text.contains('@')) {
                showSnackBar('Please provide a valid email address');
              }

              if (passwordController.text.length < 6) {
                showSnackBar('Please provide a password of length more than 6');
              }
              BuildContext dialogContext;
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  dialogContext = context;
                  return CircularProgressIndicator(
                    backgroundColor: Colors.redAccent,
                    valueColor: AlwaysStoppedAnimation(Colors.green),
                    strokeWidth: 10,
                  );
                },
              );
              context
                  .read<AuthenticationService>()
                  .signIn(
                    email: emailIdController.text.trim(),
                    password: passwordController.text.trim(),
                  )
                  .then((value) => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return HomePage();
                        }),
                      ));
              Navigator.pop(context);
            },
            child: CustomButton(
              text: 'Login',
            ),
          ),
          Text("\nDon't have any account?"),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return SignUpPage();
                }),
              );
            },
            child: Text(
              'SignUp here',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(top: 130),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'hopOn',
                  style: TextStyle(
                    fontSize: 60,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'MuseoModerno',
                    // color: Colors.white,
                  ),
                ),
                SizedBox(height: 80),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailIdController,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              icon: Icon(_isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              }),
                          filled: true,
                          fillColor: Color.fromRGBO(220, 240, 241, 67),
                          hintText: 'Email',
                          hintStyle: GoogleFonts.kameron(
                            fontSize: 12,
                          ),
                          enabled: true,
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 15.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: new BorderSide(
                                color: Color.fromRGBO(220, 240, 241, 67)),
                            borderRadius: new BorderRadius.circular(10),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: new BorderSide(
                                color: Color.fromRGBO(220, 240, 241, 67)),
                            borderRadius: new BorderRadius.circular(10),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              icon: Icon(_isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              }),
                          filled: true,
                          fillColor: Color.fromRGBO(220, 240, 241, 67),
                          hintText: 'Password',
                          hintStyle: GoogleFonts.kameron(
                            fontSize: 12,
                          ),
                          enabled: true,
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 15.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: new BorderSide(
                                color: Color.fromRGBO(220, 240, 241, 67)),
                            borderRadius: new BorderRadius.circular(10),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: new BorderSide(
                                color: Color.fromRGBO(220, 240, 241, 67)),
                            borderRadius: new BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          RegExp regex = new RegExp(r'^.{6,}$');
                          if (value!.isEmpty) {
                            return "Password cannot be empty";
                          }
                          if (!regex.hasMatch(value)) {
                            return ("please enter valid password min. 6 character");
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {},
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () async {
                          // network connectivity
                          var connectivityResult =
                              await Connectivity().checkConnectivity();
                          if (connectivityResult != ConnectivityResult.mobile &&
                              connectivityResult != ConnectivityResult.wifi) {
                            showSnackBar('No Internet connectivity');
                            return;
                          }

                          if (!emailIdController.text.contains('@')) {
                            showSnackBar(
                                'Please provide a valid email address');
                          }

                          if (passwordController.text.length < 6) {
                            showSnackBar(
                                'Please provide a password of length more than 6');
                          }
                          BuildContext dialogContext;
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              dialogContext = context;
                              return ProgressDialog(
                                status: 'Logging you in...',
                              );
                            },
                          );
                          context
                              .read<AuthenticationService>()
                              .signIn(
                                email: emailIdController.text.trim(),
                                password: passwordController.text.trim(),
                              )
                              .then((value) => Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return HomePage();
                                    }),
                                  ));
                          Navigator.pop(context);
                        },
                        child: CustomButton(
                          text: 'Login',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return SignUpPage();
                            }),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have any account?\t",
                              style: TextStyle(fontSize: 10),
                            ),
                            Text(
                              'SignUp here',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
