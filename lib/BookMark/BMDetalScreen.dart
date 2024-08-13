import 'package:abrin_app_new/BookMark/BMProvider.dart';
import 'package:abrin_app_new/BookMark/fetchfav_bussines_model.dart';
import 'package:abrin_app_new/Events/addeventsmodel.dart';
import 'package:abrin_app_new/Home/ReviewBusiness/images_viewer_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class BMDC extends StatefulWidget {
  final FetchFavruitBussineses business;

  const BMDC({Key? key, required this.business}) : super(key: key);

  @override
  State<BMDC> createState() => _BMDCState();
}

class _BMDCState extends State<BMDC> {
  @override
  Widget build(BuildContext context) {
    final bookmarkProvider = Provider.of<BookmarkProvider>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.business.name),
          actions: [
            IconButton(
              icon: Icon(
                bookmarkProvider.bookmarkedBusinesses
                        .any((b) => b.id == widget.business.id)
                    ? Icons.bookmark
                    : Icons.bookmark_border,
              ),
              onPressed: () {
                if (bookmarkProvider.bookmarkedBusinesses
                    .any((b) => b.id == widget.business.id)) {
                  // print("::: the bussines id in BM:${business.id}");
                  bookmarkProvider.removeBookmark(widget.business.id);
                } else {
                  bookmarkProvider.addtoFav(businessId: widget.business.id.toString());
                }
              },
            ),
          ],
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
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.business.coverPicture)),
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
                                imagePath: widget.business.profilePicture,
                              ),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              NetworkImage(widget.business.profilePicture),
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
                      child: Text(widget.business.description ?? ''),
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
                                  text: widget.business.location ?? '',
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
                                    text: 'Category: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: widget.business.category,
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
