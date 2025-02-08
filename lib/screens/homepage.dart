import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vehicles/utils/app_colors.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Map<String, dynamic>> vehicles = [];

  Future<void> fetchVehicles() async {
    FirebaseFirestore.instance
        .collection('vehicles')
        .get()
        .then((QuerySnapshot snapshot) {
      vehicles.clear();
      snapshot.docs.forEach((doc) {
        vehicles.add(doc.data() as Map<String, dynamic>);
      });
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    fetchVehicles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        surfaceTintColor: AppColors.secondary,
        title: Text(
          "Car Lists",
          style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.primarytextcolor),
        ),
        backgroundColor: AppColors.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
        child: vehicles.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: vehicles.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> vehicle = vehicles[index];

            double mileage = vehicle['Mileage'] != null ? double.tryParse(vehicle['Mileage'].toString()) ?? 0 : 0;
            int age = vehicle['Age'] != null ? int.tryParse(vehicle['Age'].toString()) ?? 0 : 0;

            Color borderColor;
            if (mileage >= 15 && age <= 5) {
              borderColor = Colors.green;
            } else if (mileage >= 15 && age > 5) {
              borderColor = Colors.amber;
            } else {
              borderColor = Colors.red;
            }

            return Container(
              width: MediaQuery.of(context).size.width,
              height: 115,
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: borderColor, width: 3),
              ),
              margin: EdgeInsets.only(bottom: 15),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          color: AppColors.secondary,
                          height: 80,
                          width: MediaQuery.of(context).size.width/2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                vehicle['Model'],
                                style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.primarytextcolor),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Mileage: ",
                                    style: TextStyle(color: AppColors.secondarytextcolor),
                                  ),
                                  Text(vehicle['Mileage'],style: TextStyle(color:AppColors.primarytextcolor ),)
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Age: ",
                                    style: TextStyle(color: AppColors.secondarytextcolor),
                                  ),
                                  Text(vehicle['Age'],style: TextStyle(color: AppColors.primarytextcolor),)
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              height: 80,
                              width: MediaQuery.of(context).size.width/3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.secondary,
                                image: DecorationImage(
                                  image: NetworkImage(vehicle['Image']),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
