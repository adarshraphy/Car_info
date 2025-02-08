import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vehicles/utils/app_colors.dart';
import 'homepage.dart';

class Welcomepage extends StatefulWidget {
  const Welcomepage({super.key});

  @override
  State<Welcomepage> createState() => _WelcomepageState();
}

class _WelcomepageState extends State<Welcomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Lottie.asset('assets/animation/welcomepage.json',
                  width: MediaQuery.of(context).size.width),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              color: AppColors.primary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        Text(
                          "Welcome to Car Info App!",
                          style: TextStyle(
                              color: AppColors.primarytextcolor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        SizedBox(height: 15,),
                        Text(
                          "This app displays a list of cars with their fuel efficiency and age. Vehicles are color-coded based on their environmental impact: green for vehicles that are fuel-efficient (15 km/l or more) and 5 years old or less, amber for fuel-efficient vehicles (15 km/l or more) but older than 5 years, and red for vehicles that are not fuel-efficient or older than 5 years with poor fuel efficiency.",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.secondarytextcolor),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Homepage()),
                );
              },
              child: CircleAvatar(
                backgroundColor:AppColors.buttoncolor,
                radius: 25,
                child: Icon(Icons.arrow_forward_sharp,color: AppColors.primarytextcolor,),
              ),
            )
          ],
        ),
      ),
    );
  }
}
