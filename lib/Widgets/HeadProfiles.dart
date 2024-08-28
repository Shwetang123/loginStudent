import 'package:flutter/material.dart';
class HeadProfile extends StatelessWidget {
  const HeadProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25)),
        color: Colors.red,
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const SizedBox(width: 15,),
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 48,
            child: Image.asset("assets/logo1.png"),
          ),
          const SizedBox(
            width: 16,
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Student-1618",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontFamily: "MainFont"
                ),
              ),
              Text(
                "III-A",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontFamily: "MainFont"
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
