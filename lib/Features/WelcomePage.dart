import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class WelcomaPage extends StatefulWidget {
  const WelcomaPage({super.key});

  @override
  State<WelcomaPage> createState() => _WelcomaPageState();
}

class _WelcomaPageState extends State<WelcomaPage> {
  List images = ["blood_one.png", "blood_two.jpg"];

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: PageView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: images.length,
          itemBuilder: (_, index) {
            return Container(
              // color: Colors.red,
              width: double.maxFinite,
              height: double.maxFinite,
              //child: Center(child: Text('hello')),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("asset/" + images[index]),
                      fit: BoxFit.cover)),
              child: Padding(
                padding: const EdgeInsets.only(top: 70, left: 10),
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(2, (indexDots) {
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              height: 5,
                              width: index == indexDots ? 15 : 5,
                              //color: Colors.red,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          );
                        }),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Container(
                              child: const Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Save',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 29),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('Life',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 29,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 60),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Donate',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 29),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text('Blood',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 29,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 510),
                        child: Text(
                          'Your small act can save someone life.',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.red,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
