import 'package:abrin_app_new/Home/ReviewBusiness/BottomSheet.dart';
import 'package:abrin_app_new/Home/ReviewBusiness/HASFR.dart';
import 'package:abrin_app_new/Home/ReviewBusiness/images_viewer_screen.dart';
import 'package:abrin_app_new/Home/business/customRatings.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'package:permission_handler/permission_handler.dart';


class Category {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  Category({required this.icon, required this.label, required this.onTap});
}

class Category1 {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  Category1({required this.icon, required this.label, required this.onTap});
}

class Gallery {
  final String image;

  Gallery({required this.image});
}

class ReviewsScreen extends StatefulWidget {
  final CustomRating customRating;
  final BottomModel bottomModel;

  ReviewsScreen({
    super.key,
    required this.customRating,
    required this.bottomModel,
    required int businessId,
  });

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  int selectedIndex = -1;

  List<BottomReview> bottomReview = [
    BottomReview(
      title: 'Connectz',
      image: 'assets/Icons/icon profilecrd.jpg',
      message: 'some thing some thing i dont know',
      time: '2 hours ago',
      messicon: 'assets/Icons/icon profilecrd.jpg',
      Rating: '4.5',
    ),
    BottomReview(
      title: 'Connectz',
      image: 'assets/Icons/icon profilecrd.jpg',
      message: 'some thing some thing i dont know',
      time: '2 hours ago',
      messicon: 'assets/Icons/icon profilecrd.jpg',
      Rating: '4.5',
    ),
  ];

  

  final List<Category1> categories1 = [
    Category1(
      icon: Icons.shopping_bag,
      label: 'Shopping',
      onTap: () {
        launcher.launchUrl(
          Uri.parse('https://www.google.com/maps/place/Builtinsoft'),
          mode: launcher.LaunchMode.externalApplication,
        );
      },
    ),
  ];
  final List<Gallery> gallery = [
    Gallery(image: 'assets/Icons/icon profilecrd.jpg'),
  ];

  int _overallRating = 0;
  int _serviceRating = 0;
  int _hospitalityRating = 0;
  int _pricingRating = 0;
  bool _isFavorite = false;
 
   @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    final status = await Permission.phone.status;
    if (!status.isGranted) {
      await Permission.phone.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Category> categories = [
    Category(
      icon: Icons.directions,
      label: 'Direction',
      onTap: () {
        launcher.launchUrl(
          Uri.parse('https://www.google.com/'),
          mode: launcher.LaunchMode.externalApplication,
        );
      },
    ),
  Category(
        icon: Icons.call,
        label: 'Call Now',
        onTap: () async {
          print('Call Now button pressed');

          // Hardcoded phone number for testing
          final phoneNumber = '03127032001';
          print("::: the phone number is: $phoneNumber");

          if (phoneNumber.isNotEmpty) {
            final Uri phoneUri = Uri(
              scheme: 'tel',
              path: phoneNumber,
            );

            try {
              print("::: Attempting to launch: $phoneUri");
              if (await launcher.canLaunchUrl(phoneUri)) {
                await launcher.launchUrl(
                  phoneUri,
                  mode: launcher.LaunchMode.externalApplication,
                );
              } else {
                print('Cannot launch phone dialer. URL may not be valid.');
              }
            } catch (e) {
              print('Error launching URL: $e');
            }
          } else {
            print('Phone number is empty');
          }
        },
      ),
   Category(
  icon: Icons.screen_share_outlined,
  label: 'Website',
  onTap: () {
    final websiteUrl = widget.customRating.website;
    if (websiteUrl != null && websiteUrl.isNotEmpty) {
      // Ensure the URL starts with 'http://' or 'https://'
      final formattedUrl = websiteUrl.startsWith('http://') || websiteUrl.startsWith('https://')
          ? websiteUrl
          : 'https://$websiteUrl';

      final uri = Uri.parse(formattedUrl);
      launcher.launchUrl(
        uri,
        mode: launcher.LaunchMode.externalApplication,
      ).catchError((e) {
        // Handle the error if the URL cannot be launched
        print('Could not launch URL: $e');
      });
    } else {
      print('Website URL is not provided or invalid.');
    }
  },
)
,
  Category(
  icon: Icons.email,
  label: 'Email',
  onTap: () {
    final email = widget.customRating.email;
    if (email != null && email.isNotEmpty) {
      final emailUri = Uri(
        scheme: 'mailto',
        path: email,
      );

      launcher.launchUrl(
        emailUri,
        mode: launcher.LaunchMode.externalApplication,
      ).catchError((e) {
        // Handle the error if the email client cannot be launched
        print('Could not launch email client: $e');
      });
    } else {
      print('Email address is not provided or invalid.');
    }
  },
)
,
    Category(
      icon: Icons.bookmark,
      label: "Faviors",
      onTap: () {
        //bookmarkBusiness();
      },
    ),
    Category(icon: Icons.share, label: "Partager", 
        onTap: () {
        // Generate the shareable URL. Replace with your actual URL structure.
        final String businessProfileUrl = 'https://yourapp.com/business/${widget.customRating.id}';
        print(":::the url of biisnus is :${businessProfileUrl}");
        Share.share('Check out this business profile: $businessProfileUrl');
      }
    ),
    Category(icon: Icons.star_border, label: "Note", onTap: () {}),
  ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.zero,
        child: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          // title: const Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Icon(Icons.message),
          //     Text('Commentaires'),
          //   ],
          // ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.customRating.coverPicture),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -50,
                  left: MediaQuery.of(context).size.width / 2 - 50,
                  child: GestureDetector(
                    onTap: (){
                       Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ImageScreen(
                                          imagePath: widget
                                              .customRating.profilePicture,
                                        ),
                                      ),
                                    );
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            NetworkImage(widget.customRating.profilePicture),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.customRating.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Container(
                    height: 18,
                    width: 18,
                    child: Image.asset(
                      "assets/images/check.png",
                      fit: BoxFit.cover,
                    )),
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     RatingBar(
            //       size: 22,
            //       filledIcon: Icons.star,
            //       filledColor: Colors.blue,
            //       emptyColor: const Color.fromARGB(255, 222, 219, 219),
            //       emptyIcon: Icons.star,
            //       onRatingChanged: (value) => debugPrint('$value'),
            //       initialRating: widget.customRating.rating,
            //       maxRating: 5,
            //     )
            //   ],
            // ),
            // Text(
            //   '(${widget.customRating.rating})',
            // ),
            const SizedBox(
              height: 30,
            ),

            Container(
              height: 56,
              width: MediaQuery.of(context).size.width * 0.9,
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
              child:
                  ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return
                  Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: GestureDetector(
                  onTap: categories[index].onTap,
                  child: Center(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // InkWell(
                          //   onTap: (){
                          //       final String businessLink = 'https://example.com'; // Replace with your business link

                          //     Share.share(businessLink);
                          //   },
                          //   child: Container(
                          //     height: 40,
                          //     width: 100,
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(5),
                          //       border: Border.all(color: Colors.black),
                          //       color: selectedIndex == index
                          //           ? Colors.blue
                          //           : Colors.white,
                          //     ),
                          //     child: Row(
                          //       children: [
                          //         Icon(
                          //           Icons.share,
                          //           size: 20,
                          //           color: Colors.blue,
                          //         ),
                          //         const SizedBox(
                          //           width: 5,
                          //         ),
                          //         Text(
                          //           'Partager',
                          //           style: const TextStyle(
                          //             color: Colors.grey,
                          //             fontSize: 14,
                          //           ),
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          // // Container(
                          //       height: 40,
                          //       width: 140,
                          //       decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(5),
                          //         border: Border.all(color: Colors.black),
                          //       ),
                          //       child: const Row(
                          //         children: [
                          //           Icon(
                          //             Icons.facebook,
                          //             size: 26,
                          //             color: Colors.blue,
                          //           ),
                          //           SizedBox(
                          //             width: 5,
                          //           ),
                          //           Text(
                          //             'Social Account',
                          //             style: TextStyle(
                          //                 color: Colors.grey, fontSize: 14),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                
                            Container(
                              height: 40,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.black),
                                color: selectedIndex == index
                                    ? Colors.blue
                                    : Colors.white,
                              ),
                              child: Center(
                                child: Row(
                                  children: [
                                    Icon(
                                      categories[index].icon,
                                      size: 20,
                                      color: Colors.blue,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      categories[index].label,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
              }
              )
            ),
            const SizedBox(
              height: 12,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                height: 110,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.white,
                      blurRadius: 10,
                    ),
                  ],
                  border: Border.all(
                    color: Color.fromARGB(255, 227, 226, 226),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/Icons/profile.png',
                            height: 25,
                            width: 25,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          const Text(
                            'Réseaux sociaux',
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // ListView.builder(
                          //     itemCount: items.length,
                          //     itemBuilder: (context, index) {
                          //       return ListTile(
                          //         title: Text(items[index]),
                          //       );
                          //     })
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              child: 
                              Container(
                                height: 40,
                                width: 140,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.black),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.facebook,
                                      size: 26,
                                      color: Colors.blue,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Social Account',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 110,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(255, 227, 226, 226),
                  width: 1,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 10,
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.description,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text("Description",
                            style: TextStyle(
                              fontSize: 20,
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      widget.customRating.description,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                height: 90,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(255, 227, 226, 226),
                    width: 1,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.white,
                      blurRadius: 10,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.category,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            'Catégories',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories1.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: categories1[index].onTap,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border:
                                              Border.all(color: Colors.black),
                                          color: selectedIndex == index
                                              ? Colors.blue
                                              : Colors.white,
                                        ),
                                        child: Center(
                                          child: Row(
                                            children: [
                                              Icon(
                                                categories1[index].icon,
                                                size: 20,
                                                color: Colors.blue,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                categories1[index].label,
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                )),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(255, 227, 226, 226),
                  width: 1,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 10,
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(children: [
                      Icon(
                        Icons.browse_gallery,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 6),
                      Text("Galerie",
                          style: TextStyle(
                            fontSize: 20,
                          )),
                    ]),
                  ),
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: gallery.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 50,
                              width: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: Color.fromARGB(255, 176, 171, 171)),
                              ),
                              child: Row(children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ImageScreen(
                                          
                                          imagePath:
                                              widget.customRating.coverPicture,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Image.network(
                                    widget.customRating.coverPicture,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(Icons
                                          .error); // Display an error icon if image fails to load
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ImageScreen(
                                          imagePath: widget
                                              .customRating.profilePicture,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Image.network(
                                    widget.customRating.profilePicture,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(Icons
                                          .error); // Display an error icon if image fails to load
                                    },
                                  ),
                                ),
                              ]),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(255, 227, 226, 226),
                  width: 1,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 10,
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image(
                              image: AssetImage('assets/images/check.png'),
                              height: 15,
                              width: 15,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text("Ouvrez maintenant",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500)),
                          ],
                        ),
                        PopupMenuButton(
                            icon: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: Colors.black,
                                ),
                              ),
                              child: const Icon(
                                Icons.arrow_downward_rounded,
                                size: 15,
                              ),
                            ),
                            onSelected: (String result) {
                              // Handle the selected menu item
                              print('Selected: $result');
                            },
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<String>>[
                                  const PopupMenuItem<String>(
                                      child: Text('item1'), value: 'item1'),
                                  const PopupMenuItem<String>(
                                    value: 'Item 2',
                                    child: Text('Item 2'),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'Item 3',
                                    child: Text('Item 3'),
                                  ),
                                ]),
                      ],
                    ),
                    Positioned(
                      right: 8,
                      child: Text(
                        '${widget.customRating.address}',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => BottomSheetContent(
                      bottomReview: BottomReview(
                          title: 'Connectz',
                          image: 'assets/Icons/profile.png',
                          message: 'some thing some thing i dont know',
                          time: '2 hours ago',
                          messicon: 'assets/Icons/icon profilecrd.jpg',
                          Rating: '4.5')),
                );
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(255, 227, 226, 226),
                    width: 1,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.white,
                      blurRadius: 10,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Icon(
                          Icons.message_rounded,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "connectz some thing some thing i dont know",
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(255, 227, 226, 226),
                  width: 1,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 10,
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row(
                    //   children: [
                    //     CircleAvatar(
                    //       radius: 20,
                    //       backgroundImage: AssetImage(widget.bottomModel.image),
                    //     ),
                    //     const SizedBox(
                    //       width: 10,
                    //     ),
                    //     Column(
                    //       mainAxisAlignment: MainAxisAlignment.start,
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Text(
                    //           widget.bottomModel.title,
                    //           style: TextStyle(fontSize: 20),
                    //         ),
                    //         Text(
                    //           widget.bottomModel.time,
                    //           style: TextStyle(fontSize: 14),
                    //         ),
                    //       ],
                    //     ),
                    //     const SizedBox(
                    //       width: 10,
                    //     ),
                    //   ],
                    // ),
                    // Text(
                    //   widget.bottomModel.message,
                    //   style: const TextStyle(
                    //     fontSize: 20,
                    //   ),
                    //   overflow: TextOverflow.ellipsis,
                    // ),
                    const Text('Overall',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    StarRating(
                      onRatingChanged: (rating) {
                        setState(() {
                          _overallRating = rating;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    const Text('Service',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    StarRating(
                      onRatingChanged: (rating) {
                        setState(() {
                          _serviceRating = rating;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    const Text('Hospitality',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    StarRating(
                      onRatingChanged: (rating) {
                        setState(() {
                          _hospitalityRating = rating;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    const Text('Pricing',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    StarRating(
                      onRatingChanged: (rating) {
                        setState(() {
                          _pricingRating = rating;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                _isFavorite = !_isFavorite;
                              });
                            },
                            icon: Icon(
                              _isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: _isFavorite ? Colors.red : null,
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.messenger_outline_outlined)),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),

            // Container(
            //     height: 100,
            //     width: MediaQuery.of(context).size.width * 0.9,
            //     child: const Column(
            //       children: [
            //         Icon(
            //           Icons.message_rounded,
            //           size: 30,
            //           color: Colors.grey,
            //         ),
            //         SizedBox(
            //           height: 5,
            //         ),
            //         Text(
            //           "connectz ",
            //           style: TextStyle(fontSize: 14, color: Colors.grey),
            //         )
            //       ],
            //     ))
          ],
        ),
      ),
    );
  }
}
