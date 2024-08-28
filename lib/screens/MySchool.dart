import 'package:flutter/material.dart';

class MySchool extends StatelessWidget {
  const MySchool({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "My School",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: "MainFont",
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            "assets/MySchool1.png",
                            height: 160,
                            width: 350,
                            fit: BoxFit.fill,
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            "assets/MySchool2.png",
                            height: 160,
                            width: 350,
                            fit: BoxFit.fill,
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            "assets/MySchool1.png",
                            height: 160,
                            width: 350,
                            fit: BoxFit.fill,
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset("assets/MySchool3.jpeg",width: 150,),
                      ),
                      const SizedBox(width: 10,),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset("assets/MySchool4.jpeg",width: 150,),
                      ),
                      const SizedBox(width: 10,),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset("assets/MySchool5.jpeg",width: 150,),
                      ),
                      const SizedBox(width: 10,),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset("assets/MySchool3.jpeg",width: 150,),
                      ),
                      const SizedBox(width: 10,),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset("assets/MySchool4.jpeg",width: 150,),
                      ),
                      const SizedBox(width: 10,),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset("assets/MySchool5.jpeg",width: 150,),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                          child: Image.asset("assets/MySchool2.png",width: 400,)),
                      const SizedBox(width: 10,),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset("assets/MySchool1.png",width: 400,)),
                      const SizedBox(width: 10,),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset("assets/MySchool2.png",width: 400,)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
