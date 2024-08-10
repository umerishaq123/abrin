import 'package:abrin_app_new/Events/addeventsmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Eventdetail extends StatefulWidget {
  final Event event;
  Eventdetail({super.key, required this.event});

  @override
  State<Eventdetail> createState() => _EventdetailState();
}

class _EventdetailState extends State<Eventdetail> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
          title: Text('Détail de l’événement',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: height * 0.25,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/appIcon.png')),
                    // image: DecorationImage(
                    //   image: NetworkImage(widget.customRating.coverPicture),
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                ),
                Positioned(
                  bottom: -50,
                  left: width / 2 - 50,
                  child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(widget.event.image),
                      )),
                )
              ],
            ),
            SizedBox(
              height: height * 0.09,
            ),
            Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(10),
              height: height * 0.33,
              width: width * 0.99,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 10,
                  ),
                ],
                border: Border.all(
                  color: Color.fromARGB(255, 204, 204, 204),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: height * 0.1,
                    width: width * 0.9,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white,
                          blurRadius: 10,
                        ),
                      ],
                      border: Border.all(
                        color: Color.fromARGB(255, 204, 204, 204),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.event.description ?? ''),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Divider(),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    height: height * 0.13,
                    width: width * 0.9,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white,
                          blurRadius: 10,
                        ),
                      ],
                      border: Border.all(
                        color: Color.fromARGB(255, 204, 204, 204),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text.rich(TextSpan(children: [
                                                              TextSpan(
                                                                text: 'Emplacement: ',
                                                                style: TextStyle(
                                                                  fontWeight: FontWeight.bold,
                                                                  color: Colors.black,
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text: widget.event.location ?? '',
                                                                style: TextStyle(
                                                                  color: Colors.grey,
                                                                ),
                                                              ),
                                                            ])),
                            )
                          ],
                        ),
                        SizedBox(height: height * 0.01),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text.rich(TextSpan(children: [
                                  TextSpan(
                                    text: 'Date: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: widget.event.date,
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ]))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text.rich(TextSpan(children: [
                                  TextSpan(
                                    text: 'Heure: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: widget.event.time,
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ]))
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
