import 'package:acegases_hms/Utils/contants.dart';
import 'package:acegases_hms/appcache.dart/appcache.dart';
import 'package:acegases_hms/controller/auth/login_controller.dart';
import 'package:acegases_hms/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:
          Consumer<LoginController>(builder: (context, loginController, child) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.paddingOf(context).bottom,
            top: MediaQuery.paddingOf(context).top,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.deepPurple.shade700,
                  Colors.deepPurple.shade500,
                  Colors.deepPurple.shade400,
                  Colors.deepPurple.shade200,
                  Colors.deepPurple.shade100
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.05, 0.2, 0.3, 0.4, 0.5]),
          ),
          width: screenWidth,
          height: screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(
                flex: 1,
              ),
              Container(
                // margin: EdgeInsets.only(bottom: 50),
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4),
                child: Image.asset(
                  Constants.assetImages + 'appicon/ac.png',
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              Container(
                width: screenWidth,
                margin: const EdgeInsets.symmetric(horizontal: 16),

                // decoration: BoxDecoration(
                //     gradient: LinearGradient(
                //         colors: [Colors.deepPurple.shade200, Colors.red.shade100],
                //         begin: Alignment.topLeft,
                //         end: Alignment.bottomRight),
                //     color: Colors.white,
                //     border: Border.all(color: Colors.black45, width: 3),
                //     borderRadius: BorderRadius.circular(24)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Welcome Back,",
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      // margin: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(18)),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.phone,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: loginController.mobile,
                              onChanged: (value) =>
                                  loginController.validatePhone(value),
                              decoration: InputDecoration(
                                  hintText: "Phone No",
                                  hintStyle: TextStyle(color: Colors.white38),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.zero),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    loginController.mobileErr != null
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(12, 4, 0, 12),
                            child: Text(
                              loginController.mobileErr! + "*",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.red.shade500),
                            ),
                          )
                        : const SizedBox(
                            height: 12,
                          ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      // margin: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(18)),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.key,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: loginController.password,
                              onChanged: (value) =>
                                  loginController.validatePass(value),
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: "Password ",
                                  hintStyle: TextStyle(color: Colors.white38),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.zero),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    loginController.passErr != null
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 4),
                            child: Text(
                              loginController.passErr! + "*",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.red.shade500),
                            ),
                          )
                        : const SizedBox(
                            height: 4,
                          ),
                    // InkWell(
                    //   onTap: () {},
                    //   child: const Padding(
                    //     padding: EdgeInsets.all(4.0),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.end,
                    //       children: [
                    //         Text(
                    //           "Forgot Password ?",
                    //           style: TextStyle(
                    //               fontSize: 14,
                    //               fontWeight: FontWeight.w900,
                    //               color: Colors.white60),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            loginController.getUserLogin(context).then((e) {
                              if (e) {
                                loginController.clearController();
                                Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    AppRoutes.ptiPmSelectionScreenRoute,
                                    (route) => false,
                                    arguments: false);
                              }
                            });
                          },
                          child: const Text(
                            "LOG IN",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(
                flex: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text(
                      "${Appcache.packageInfo.version} (${Appcache.packageInfo.buildNumber})",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Powered By",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                        Image.asset(
                          Constants.assetImages + "android12Splash.png",
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover,
                        ),
                        const Text(
                          "Gussmann Integrated Solution",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
