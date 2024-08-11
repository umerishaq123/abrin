import 'package:abrin_app_new/Events/addeventsmodel.dart';
import 'package:abrin_app_new/Home/ReviewBusiness/images_viewer_screen.dart';
import 'package:abrin_app_new/Search/localBusinesscategory.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BusinessDetail extends StatefulWidget {
  final LocalBusinessCategory business;
  BusinessDetail({
    super.key,
    required this.business,
  });

  @override
  State<BusinessDetail> createState() => _BusinessDetailState();
}

class _BusinessDetailState extends State<BusinessDetail> {
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
          title: Text(
            widget.business.businessName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
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
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ImageScreen(
                                imagePath: widget.business.imagePath,
                              ),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              NetworkImage(widget.business.imagePath),
                        ),
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
              height: height * 0.35,
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
                    'Category',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: height * 0.07,
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
                      child: Text(widget.business.category),
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
                    height: height * 0.18,
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text.rich(TextSpan(children: [
                                const TextSpan(
                                  text: 'Emplacement: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: widget.business.location,
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ])),
                            )
                          ],
                        ),
                        Divider(),
                        SizedBox(height: height*0.01,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          const Text('Rating:   ',   style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                          ),
                          
                          ],
                        ),
                        SizedBox(height: height*0.01,),
                          Container(
                             height: height * 0.04,
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
                      borderRadius: BorderRadius.circular(5),
                    ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RatingBar(
                                    size: 16,
                                    filledIcon: Icons.star,
                                    filledColor: Color.fromARGB(255, 243, 180, 33),
                                    emptyColor:
                                        const Color.fromARGB(255, 222, 219, 219),
                                    emptyIcon: Icons.star,
                                    onRatingChanged: (value) => debugPrint('$value'),
                                    initialRating: widget.business.rating,
                                    maxRating: 5,
                                  ),
                              ],
                            ),
                          ),
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
