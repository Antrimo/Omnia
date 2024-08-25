import 'package:flutter/material.dart';
import 'package:omnia/Resources/Theme/theme.dart';
import 'package:omnia/Screens/Events/sihform.dart';


class LatestEvent extends StatefulWidget {
  const LatestEvent({super.key});

  @override
  State<LatestEvent> createState() => _LatestEventState();
}

class _LatestEventState extends State<LatestEvent> {

  String upcomingImageUrl = "https://firebasestorage.googleapis.com/v0/b/omnia-acm.appspot.com/o/Upcoming%20Events%2FTechoween.png?alt=media&token=6972ace8-67b1-46ac-9ab4-541b141b816a";

  @override
  Widget build(BuildContext context) {
    return InkWell(
      
                                      onTap: () {
                                        // launchUrlString(registerUrl);
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const SihForm()));
                                      },
      child: Container(
                    height: 420,
                    width: 380,
                    decoration: BoxDecoration(
                      border: Border.all(color: itemColor),
                      borderRadius: BorderRadius.circular(10),
                      color: cardColor,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Container(
                              height: 320,
                              width: 340,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                                color: imagebackColor,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10.0),
                                          child: Image.asset(
                                            'assets/sih/Sihsquare.png',
                                            alignment: Alignment.center,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: double.infinity,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Smart India Hackathon",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                        ),
                                      ),
                                      Container(
                                        height: 22,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: itemColor),
                                          borderRadius: BorderRadius.circular(6),
                                          color: dateColor,
                                        ),
                                        child: const Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(1.0),
                                            child: Text(
                                              "Register",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "JUIT Internal Round.",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
    );
  }
}