import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "https://wallpaperaccess.com/full/84248.png"),
                    )),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          const Color.fromARGB(172, 72, 173, 255),
                          const Color.fromARGB(122, 68, 137, 255)
                        ])),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                              ""),
                          RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      fontSize: 24), // Default text style
                                  children: [
                                TextSpan(
                                  text: 'CODE',
                                  style: TextStyle(
                                      color: Color(0xFFf5821f),
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: 'MINERS',
                                  style: TextStyle(
                                      color: const Color(0xFF222947),
                                      fontWeight: FontWeight.bold),
                                ),
                              ]))
                        ],
                      ),
                      // Text("data\n datah jikoihu\n sdcyuni")
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
