import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:house_rental_app/Constants.dart';
import 'package:house_rental_app/Profile-Service/Views/shared/ProfileHeader.dart';

class ProfileDetailScrenn extends StatelessWidget {
  const ProfileDetailScrenn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileHeader(
              margin: 0,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              height: 1,
              color: Colors.black.withOpacity(0.1),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Column(
                children: [
                  ProfileDetailTextContainer(
                    first: "Phone",
                    second: "9560775711",
                  ),
                  ProfileDetailTextContainer(
                    first: "Age",
                    second: "25",
                  ),
                  ProfileDetailTextContainer(
                    first: "Gender",
                    second: "Female",
                  ),
                  ProfileDetailTextContainer(
                    first: "Marital status",
                    second: "Not Married",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileDetailTextContainer extends StatelessWidget {
  final String first;
  final String second;
  const ProfileDetailTextContainer(
      {super.key, required this.first, required this.second});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(15),
      child: Row(
        children: [
          Text(
            "$first: ",
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Text(
            second,
            style: const TextStyle(letterSpacing: 1.2),
          )
        ],
      ),
    );
  }
}
