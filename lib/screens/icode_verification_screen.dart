import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/student_provider.dart';
import 'login_screen.dart';

class ICodeVerificationScreen extends StatefulWidget {
  const ICodeVerificationScreen({super.key});

  @override
  _ICodeVerificationScreenState createState() =>
      _ICodeVerificationScreenState();
}

class _ICodeVerificationScreenState extends State<ICodeVerificationScreen> {
  final List<TextEditingController> controllers = List.generate(
      6, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());
  bool isLoading = false;
  bool isError = false;

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  String getICode() {
    return controllers.map((controller) => controller.text).join();
  }

  void _handleTextChanged(String value, int index) {
    setState(() {
      if (value.isNotEmpty && index < 5) {
        FocusScope.of(context).requestFocus(focusNodes[index + 1]);
      } else if (value.isEmpty && index > 0) {
        FocusScope.of(context).requestFocus(focusNodes[index - 1]);
      }
      if (index < 5 && controllers[index].text.isNotEmpty) {
        focusNodes[index+1].hasFocus; // Unfocus the filled field
      }
    });
  }


  void _handleKeyPressed(RawKeyEvent event, int index) {
    if (event is RawKeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace) {
      if (controllers[index].text.isEmpty && index > 0) {
        setState(() {
          focusNodes[index - 1].requestFocus();
          // Re-enable the previous field if the current field is empty
          controllers[index - 1].text="";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.red,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Edu Influx School',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'MainFont',
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 13, right: 13, top: 20),
                child: const Text(
                  'An App for parents to have the maximum information about their child and school activities',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'MainFont'),
                ),
              ),
              const SizedBox(height: 20),
              CircleAvatar(
                  radius: 90,
                  backgroundColor: Colors.white,
                  child: Image.asset("assets/logo1.png")),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: <Widget>[
                    const Text(
                      'Enter Institute Code',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Please enter the institute code provided by your school to continue.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'MainFont'),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(6, (index) {
                        return SizedBox(
                          width: 50,
                          child: RawKeyboardListener(
                            focusNode: FocusNode(),
                            onKey: (event) => _handleKeyPressed(event, index),
                            child: TextField(
                              controller: controllers[index],
                              focusNode: focusNodes[index],
                              enabled: index == 5 ||
                                  controllers[index].text.isEmpty,
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              scrollPadding: const EdgeInsets.only(),
                              textCapitalization: TextCapitalization.characters,
                              decoration: const InputDecoration(
                                counterText: ' ',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)
                                ),
                                focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red), // Grey border when focused
                            ),
                              ),
                              onChanged: (value) =>
                                  _handleTextChanged(value, index),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 30),
                    isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                          onPressed: () async {
                          setState(() {
                              isLoading = true;
                              isError = false;
                          });

                          String iCode = getICode();

                          if (await Provider.of<StudentProvider>(context,
                              listen: false)
                              .verifyICode(iCode)) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                  content: Text(
                                                'Successfully',
                                   style: TextStyle(
                                  fontSize: 15, color: Colors.black),
                            ),
                            backgroundColor: Colors.white,
                             ));
                             Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                        } else {
                          setState(() {
                            isError = true;
                          });
                        }

                        setState(() {
                          isLoading = false;
                        });
                      },
                             style: ElevatedButton.styleFrom(
                               backgroundColor: Colors.red, // background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            15,
                          ), // rectangle shape with border radius
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 90, vertical: 15),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'MainFont'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (isError)
                      Column(
                        children: [
                          const Text(
                            'Something went wrong',
                            style: TextStyle(color: Colors.red),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                isError = false;
                              });
                            },
                            child: const Text(
                              'Retry',
                              style: TextStyle(
                                  fontFamily: 'MainFont',
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery
                          .of(context)
                          .viewInsets
                          .bottom))
            ],
          ),
        ),
      ),
    );
  }
}