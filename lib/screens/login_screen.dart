import 'package:flutter/material.dart';
import 'package:loginstudent/screens/student_data_screen.dart';
import 'package:provider/provider.dart';
import '../providers/student_provider.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController uidController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  bool isLoading = false;
  bool isError = false;
  String selectedRole = 'Parent';

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
                'EduSchool App',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'An App for parents to have the maximum information about their child and school activities',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: 'MainFont',
                  fontWeight: FontWeight.w600
                ),
              ),
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 90,
                backgroundColor: Colors.white,
                child: Image.asset("assets/logo1.png")
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: <Widget>[
                    const Text(
                      'Login To Continue',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                          fontFamily: 'MainFont'
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        _showRoleSelectionDialog();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.person),
                            const SizedBox(width: 10),
                            Text(selectedRole,style: const TextStyle(
                              fontFamily: "MainFont"
                            ),),
                            const Spacer(),
                            const Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),
                   const SizedBox(height: 10),
                    TextField(
                      controller: uidController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.phone),
                        labelText: 'Enter Login ID',
                        labelStyle: const TextStyle(
                            fontFamily: "MainFont"
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: passController,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        labelText: 'Enter your password',
                        labelStyle: const TextStyle(
                          fontFamily: "MainFont"
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        //suffixIcon: Icon(Icons.visibility),
                      ),
                    ),
                    const SizedBox(height: 20),
                    isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                          isError = false;
                        });

                        String uID = uidController.text;
                        String uPass = passController.text;

                        if (await Provider.of<StudentProvider>(context, listen: false).login(uID, uPass)) {
                          // Clear the text fields
                          uidController.clear();
                          passController.clear();

                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Logged in successfully')));
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MyHomePage()),
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
                          borderRadius: BorderRadius.circular(10), // rectangle shape with border radius
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                           child: const Padding(
                              padding:  EdgeInsets.symmetric(
                                     horizontal: 70, vertical: 5),
                            child: Text(
                                'Log In',
                                 style: TextStyle(
                                 color: Colors.white,
                                 fontSize: 16,
                                ),
                              ),
                            ),
                         ),
                         const SizedBox(height: 20),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: const BorderSide(color: Colors.black),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text(
                          'Change Institute',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (isError)
                     const  Text(
                        'Invalid Login ID or Password',
                        style: TextStyle(color: Colors.red),
                      ),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom))
            ],
          ),
        ),
      ),
    );
  }

  void _showRoleSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select ',style: TextStyle(
              fontFamily: "MainFont",
                  fontWeight: FontWeight.bold
          ),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Parent',style: TextStyle(
                  fontFamily: "MainFont",
                  fontSize: 16
                ),),
                onTap: () {
                  setState(() {
                    selectedRole = 'Parent';
                  });
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              ListTile(
                title: const Text('Teacher',style: TextStyle(
                    fontFamily: "MainFont",
                  fontSize: 16
                ),),
                onTap: () {
                  setState(() {
                    selectedRole = 'Teacher';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
