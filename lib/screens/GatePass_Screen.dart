import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../Widgets/HeadProfiles.dart';
import 'package:http/http.dart' as http;

class GatePass extends StatefulWidget {
  const GatePass({super.key});

  @override
  State<GatePass> createState() => _AlbumsState();
}

class _AlbumsState extends State<GatePass> {
  Future<List<dynamic>> _fetchGatePassData() async {
    final response = await http.get(Uri.parse('https://ssapi.influxinfotech.in/ssapi/GetVisitorPasses?iCode=INFLUX&studentID=1618'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data; // Directly returning the list
    } else {
      throw Exception('Failed to load data');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Gate Pass",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        backgroundColor: Colors.red,
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){

          }, icon: const Icon(Icons.person),
            color: Colors.white,)
        ],
      ),
      backgroundColor: Colors.white,
      body:
      FutureBuilder<List<dynamic>>(
        future: _fetchGatePassData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Data Available'));
          } else {
            return Column(
              children: [
                // Add your widgets here at the beginning
                const HeadProfile(),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final visitorPass = snapshot.data![index];
                      return Card(
                        margin: const EdgeInsets.all(15.0),
                        elevation: 25.0,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              visitorPass['NoticeDocPath'] != null && visitorPass['NoticeDocPath'].isNotEmpty
                                  ? Image.network(
                                    'https://ssapi.influxinfotech.in/${visitorPass['NoticeDocPath']}',
                                     height: 200,
                                     width: double.infinity,
                                     fit: BoxFit.cover,
                                     errorBuilder: (context, error, stackTrace) {
                                   return Image.asset(
                                    'assets/MySchool2.png',
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  );
                                },
                              )
                                  : Image.asset(
                                'assets/MySchool2.png',
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                'Title: ${visitorPass['NoticeTitle'] ?? 'No Title'}',
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              //const SizedBox(height: 5.0),
                              Text(
                                'Name: ${visitorPass['personName'] ?? 'No Name'}',
                                style: const TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                              //const SizedBox(height: 10.0),
                              Text(
                                'Detail: ${visitorPass['personDetail'] ?? 'No Detail'}',
                                style: const TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                              //const SizedBox(height: 10.0),
                              Text(
                                'Remark: ${visitorPass['personRemark'] ?? 'No Remark'}',
                                style: const TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                              //const SizedBox(height: 10.0),
                              Text(
                                'Date: ${visitorPass['NoticeDate'] ?? 'No Date'}',
                                  style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
