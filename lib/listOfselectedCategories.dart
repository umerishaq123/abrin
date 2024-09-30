// import 'package:flutter/material.dart';

// class LISTCA extends StatefulWidget {
//   final String title;
//   final String iconPath;

//   LISTCA({required this.title, required this.iconPath});

//   @override
//   State<LISTCA> createState() => _LISTCAState();
// }

// class _LISTCAState extends State<LISTCA> {

// bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _fetchAllBusinesses();
//   }

//   Future<void> _fetchAllBusinesses() async {
//     setState(() {
//       _isLoading = true;
//     });
//     try {
//       final businesses = await BusinessServicesearch().fetchBusinesses();
//       setState(() {
//         _allitems = businesses
//             .map((business) => LocalBusinessCategory(
//                   businessName: business.name,
//                   imagePath:
//                       business.coverPicture ?? 'assets/images/default.png',
//                   category: business.category,
//                   location: business.location,
//                   rating: business.rating,
//                 ))
//             .toList();
//       });
//     } catch (e) {
//       print('Error fetching businesses: $e');
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.only(left: 20, right: 18, top: 40),
//             child: Stack(
//               children: [
//                 Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Image.asset(
//                           widget.iconPath,
//                           width: 45,
//                           height: 45,
//                           color: Colors.blue,
//                         ),
//                         SizedBox(
//                           width: 20,
//                         ),
//                         Container(
//                           width: MediaQuery.of(context).size.width * 0.6,
//                           child: Text(
//                             widget.title,
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                                 fontSize: 24,
//                                 height: 1.2,
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.blue),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 30),
//                     TextField(
//                       decoration: InputDecoration(
//                         labelText: 'Search...',
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15)),
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.blue,
//                           foregroundColor: Colors.white),
//                       child: Text('Search'),
//                       onPressed: () {},
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height / 5),
//                     Center(
//                       child: Column(
//                         children: [
//                           Image.asset(
//                             width: 60,
//                             height: 60,
//                             color: Colors.blue,
//                             widget.iconPath,
//                           ),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           Text(
//                             'No results available',
//                             style: TextStyle(color: Colors.black, fontSize: 16),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:abrin_app_new/Search/Service.dart';
// import 'package:abrin_app_new/Search/business_detail.dart';
// import 'package:abrin_app_new/Search/localBusinesscategory.dart';
// import 'package:flutter/material.dart';

// class LISTCA extends StatefulWidget {
//   final String title;
//   final String iconPath;

//   LISTCA({required this.title, required this.iconPath});

//   @override
//   State<LISTCA> createState() => _LISTCAState();
// }

// class _LISTCAState extends State<LISTCA> {
//   bool _isLoading = false;
//   List<LocalBusinessCategory> _allitems = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchAllBusinesses();
//   }

//   Future<void> _fetchAllBusinesses() async {
//     setState(() {
//       _isLoading = true;
//     });
//     try {
//       final businesses = await BusinessServicesearch().fetchBusinesses();
//       final filteredBusinesses = businesses.where((business) {
//         return business.category.toLowerCase() == widget.title.toLowerCase();
//       }).toList();

//       setState(() {
//         _allitems = filteredBusinesses
//             .map((business) => LocalBusinessCategory(
//                   businessName: business.name,
//                   imagePath:
//                       business.coverPicture ?? 'assets/images/default.png',
//                   category: business.category,
//                   location: business.location,
//                   rating: business.rating,
//                 ))
//             .toList();
//       });
//     } catch (e) {
//       print('Error fetching businesses: $e');
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.only(left: 20, right: 18, top: 40),
//             child: Stack(
//               children: [
//                 Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Image.asset(
//                           widget.iconPath,
//                           width: 45,
//                           height: 45,
//                           color: Colors.blue,
//                         ),
//                         SizedBox(
//                           width: 20,
//                         ),
//                         Container(
//                           width: MediaQuery.of(context).size.width * 0.6,
//                           child: Text(
//                             widget.title,
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                                 fontSize: 24,
//                                 height: 1.2,
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.blue),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 30),
//                     TextField(
//                       decoration: InputDecoration(
//                         labelText: 'Search...',
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15)),
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.blue,
//                           foregroundColor: Colors.white),
//                       child: Text('Search'),
//                       onPressed: () {},
//                     ),
//                     _isLoading
//                         ? Center(child: CircularProgressIndicator())
//                         : _allitems.isEmpty
//                             ? Column(
//                                 children: [
//                                   Image.asset(
//                                     widget.iconPath,
//                                     width: 60,
//                                     height: 60,
//                                     color: Colors.blue,
//                                   ),
//                                   SizedBox(
//                                     height: 20,
//                                   ),
//                                   Text(
//                                     'No results available',
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 16),
//                                   ),
//                                 ],
//                               )
//                             : ListView.separated(
//                                 shrinkWrap: true,
//                                 physics: NeverScrollableScrollPhysics(),
//                                 itemCount: _allitems.length,
//                                 separatorBuilder: (context, index) => Divider(
//                                   color: Colors.grey,
//                                 ),
//                                 itemBuilder: (context, index) {
//                                   final businescategory = _allitems[index];
//                                   return ListTile(
//                                     leading: Container(
//                                       height: 100,
//                                       child: Image.network(
//                                         businescategory.imagePath,
//                                         width: 80,
//                                         height: 100,
//                                         fit: BoxFit.fill,
//                                       ),
//                                     ),
//                                     title: SingleChildScrollView(
//                                         scrollDirection: Axis.horizontal,
//                                         child: Text(
//                                             businescategory.businessName)),
//                                     subtitle: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(businescategory.category),
//                                         SingleChildScrollView(
//                                             scrollDirection: Axis.horizontal,
//                                             child: Text(
//                                                 businescategory.location)),
//                                       ],
//                                     ),
//                                     onTap: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) => BusinessDetail(
//                                               business: businescategory),
//                                         ),
//                                       );
//                                     },
//                                   );
//                                 },
//                               ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:abrin_app_new/Bussinesses/bussinessModel.dart';
// import 'package:abrin_app_new/Home/ReviewBusiness/BottomSheet.dart';
// import 'package:abrin_app_new/Home/ReviewBusiness/ReviewScreen.dart';
// import 'package:abrin_app_new/Home/business/businessDataHandler.dart';
// import 'package:abrin_app_new/Home/business/customRatings.dart';
// import 'package:abrin_app_new/Search/Service.dart';
// import 'package:abrin_app_new/Search/business_detail.dart';
// import 'package:abrin_app_new/Search/localBusinesscategory.dart';
// import 'package:flutter/material.dart';

// class LISTCA extends StatefulWidget {
//   final String title;
//   final String iconPath;
//   final List<Business> business;

//   LISTCA({required this.title, required this.iconPath, required this.business});

//   @override
//   State<LISTCA> createState() => _LISTCAState();
// }

// class _LISTCAState extends State<LISTCA> {
//   TextEditingController _searchController = TextEditingController();
//   List<Business> _allitems = [];
//   List<Business> _searchResults = [];
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _fetchAllBusinesses();
//     _searchController.addListener(() {
//       _performSearch(_searchController.text);
//     });
//   }

//   Future<void> _fetchAllBusinesses() async {
//     setState(() {
//       _isLoading = true;
//     });
//     try {
//       final businesses = await BusinessService().fetchBusinesses();
//       final filteredBusinesses = businesses.where((business) {
//         return business.category.toLowerCase() == widget.title.toLowerCase();
//       }).toList();

//       setState(() {
//         setState(() {
//           _allitems = filteredBusinesses; // Directly use Business objects
//           _searchResults = _allitems; // Initialize with filtered items
//         });
//         _searchResults = _allitems; // Initialize with filtered items
//       });
//     } catch (e) {
//       print('Error fetching businesses: $e');
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   // void _performSearch(String query) {
//   //   if (query.isEmpty) {
//   //     setState(() {
//   //       _searchResults = _allitems;
//   //     });
//   //     return;
//   //   }
//   //   setState(() {
//   //     _searchResults = _allitems
//   //         .where((item) =>
//   //             item.businessName.toLowerCase().contains(query.toLowerCase()) ||
//   //             item.location.toLowerCase().contains(query.toLowerCase()))
//   //         .toList();
//   //   });
//   // }
//   void _performSearch(String query) {
//     if (query.isEmpty) {
//       setState(() {
//         _searchResults = _allitems;
//       });
//       return;
//     }
//     setState(() {
//       _searchResults = _allitems
//           .where((item) =>
//               item.name.toLowerCase().contains(query.toLowerCase()) ||
//               item.location.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.only(left: 20, right: 18, top: 40),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image.asset(
//                       widget.iconPath,
//                       width: 45,
//                       height: 45,
//                       color: Colors.blue,
//                     ),
//                     SizedBox(width: 20),
//                     Container(
//                       width: MediaQuery.of(context).size.width * 0.6,
//                       child: Text(
//                         widget.title,
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                             fontSize: 24,
//                             height: 1.2,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.blue),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 30),
//                 TextField(
//                   controller: _searchController,
//                   decoration: InputDecoration(
//                     labelText: 'Search...',
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15)),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                       foregroundColor: Colors.white),
//                   child: Text('Search'),
//                   onPressed: () {
//                     _performSearch(_searchController.text);
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 _isLoading
//                     ? CircularProgressIndicator()
//                     : _searchResults.isEmpty
//                         ? Center(
//                             child: Column(
//                               children: [
//                                 Image.asset(
//                                   width: 60,
//                                   height: 60,
//                                   color: Colors.blue,
//                                   widget.iconPath,
//                                 ),
//                                 SizedBox(height: 20),
//                                 Text(
//                                   'No results available',
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 16),
//                                 ),
//                               ],
//                             ),
//                           )
//                         : ListView.separated(
//                             shrinkWrap: true,
//                             physics: NeverScrollableScrollPhysics(),
//                             itemCount: _searchResults.length,
//                             separatorBuilder: (context, index) => Divider(),
//                             itemBuilder: (context, index) {
//                               final businescategory = _searchResults[index];
//                               return ListTile(
//                                 leading: Container(
//                                   height: 100,
//                                   child: Image.network(
//                                     businescategory.profilePicture,
//                                     width: 80,
//                                     height: 100,
//                                     fit: BoxFit.fill,
//                                   ),
//                                 ),
//                                 title: SingleChildScrollView(
//                                   scrollDirection: Axis.horizontal,
//                                   child: Text(businescategory.name),
//                                 ),
//                                 subtitle: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(businescategory.category),
//                                     SingleChildScrollView(
//                                       scrollDirection: Axis.horizontal,
//                                       child: Text(businescategory.location),
//                                     ),
//                                   ],
//                                 ),
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => ReviewsScreen(
//                                         customRating: CustomRating(
//                                             coverPicture:
//                                                 businescategory.coverPicture,
//                                             type: businescategory.category,
//                                             name: businescategory.name,
//                                             address: businescategory.location,
//                                             rating: businescategory.rating,
//                                             description:
//                                                 businescategory.description,
//                                             profilePicture:
//                                                 businescategory.profilePicture,
//                                             isVerified:
//                                                 businescategory.isVerified,
//                                             phone: businescategory.phone,
//                                             website: businescategory.website,
//                                             socialMedia:
//                                                 businescategory.socialMedia,
//                                             email: businescategory.email,
//                                             id: businescategory.id),
//                                         bottomModel: BottomModel(
//                                             title: businescategory.name,
//                                             image: businescategory.coverPicture,
//                                             message: businescategory.category,
//                                             time: businescategory.name),
//                                         businessId: businescategory.id,
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               );
//                             },
//                           ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:abrin_app_new/Bussinesses/bussinessModel.dart';
import 'package:abrin_app_new/Home/ReviewBusiness/BottomSheet.dart';
import 'package:abrin_app_new/Home/ReviewBusiness/ReviewScreen.dart';
import 'package:abrin_app_new/Home/business/businessDataHandler.dart';
import 'package:abrin_app_new/Home/business/customRatings.dart';
import 'package:abrin_app_new/Search/Service.dart';
import 'package:abrin_app_new/Search/business_detail.dart';
import 'package:abrin_app_new/Search/localBusinesscategory.dart';

class LISTCA extends StatefulWidget {
  final String title;
  final String iconPath;
  // final List<Business> business;

  LISTCA({required this.title, required this.iconPath, });

  @override
  State<LISTCA> createState() => _LISTCAState();
}

class _LISTCAState extends State<LISTCA> {
  
  TextEditingController _searchController = TextEditingController();
  List<Business> _allitems = [];
  List<Business> _searchResults = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchAllBusinesses();
    _searchController.addListener(() {
      _performSearch(_searchController.text);
    });
  }

 Future<void> _fetchAllBusinesses() async {
  setState(() {
    _isLoading = true;
  });
  try {
    // Fetch all businesses from the API
    final businesses = await BusinessService().fetchBusinesses();
    
    // Filter businesses that match the specific category
    final filteredBusinesses = businesses.where((business) {
      // Ensure both category names are trimmed and lowercased
      return business.category.trim().toLowerCase() == widget.title.trim().toLowerCase();
    }).toList();

    setState(() {
      _allitems = filteredBusinesses; // Only businesses matching the title
      _searchResults = _allitems; // Initialize with filtered items
    });
  } catch (e) {
    print('Error fetching businesses: $e');
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}


  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = _allitems;
      });
      return;
    }
    setState(() {
      _searchResults = _allitems
          .where((item) =>
              item.name.toLowerCase().contains(query.toLowerCase()) ||
              item.location.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    print("::: the catagory name is :${widget.title}");
    if (_allitems.isNotEmpty) {
    print("::: The first business value we get is: ${_searchResults.length}");
  } else {
    print("::: No businesses available yet.");
  }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(leading: IconButton(onPressed: (){
        Navigator.pop(context);
      }, icon: Icon(Icons.arrow_back)),),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 18, top: 40),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      widget.iconPath,
                      width: 45,
                      height: 45,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 20),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        widget.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 24,
                            height: 1.2,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Search...',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white),
                  child: Text('Search'),
                  onPressed: () {
                    _performSearch(_searchController.text);
                  },
                ),
                SizedBox(height: 20),
                _isLoading
                    ? CircularProgressIndicator()
                    : _searchResults.isEmpty
                        ? Center(
                            child: Column(
                              children: [
                                Image.asset(
                                  width: 60,
                                  height: 60,
                                  color: Colors.blue,
                                  widget.iconPath,
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'No results available',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ],
                            ),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _searchResults.length,
                            separatorBuilder: (context, index) => Divider(),
                            itemBuilder: (context, index) {
                              final business = _searchResults[index];
                               print('::: the ctatgory from api is :${business.location}');
                              return ListTile(
                                leading: Container(
                                  height: 100,
                                  child: Image.network(
                                    business.profilePicture,
                                    width: 80,
                                    height: 100,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                title: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(business.name),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    
                                    Text(business.category),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Text(business.location),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ReviewsScreen(
                                        customRating: CustomRating(
                                            coverPicture:
                                                business.coverPicture,
                                            type: business.category,
                                            name: business.name,
                                            address: business.location,
                                            // rating: business.rating,
                                            description:
                                                business.description,
                                            profilePicture:
                                                business.profilePicture,
                                            isVerified:
                                                business.isVerified,
                                            phone: business.phone,
                                            website: business.website,
                                            socialMedia:
                                                business.socialMedia,
                                            email: business.email,
                                            id: business.id, city: '${business.city}',),
                                        bottomModel: BottomModel(
                                            title: business.name,
                                            image: business.coverPicture,
                                            message: business.category,
                                            time: business.name),
                                        businessId: business.id,
                                        
                                        
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:abrin_app_new/Bussinesses/bussinessModel.dart';
// import 'package:abrin_app_new/Home/ReviewBusiness/BottomSheet.dart';
// import 'package:abrin_app_new/Home/ReviewBusiness/ReviewScreen.dart';
// import 'package:abrin_app_new/Home/business/customRatings.dart';

// class LISTCA extends StatefulWidget {
//   final String title;
//   final String iconPath;
//   final List<Business> businesses;

//   LISTCA({required this.title, required this.iconPath, required this.businesses});

//   @override
//   State<LISTCA> createState() => _LISTCAState();
// }

// class _LISTCAState extends State<LISTCA> {
//   TextEditingController _searchController = TextEditingController();
//   List<Business> _allitems = [];
//   List<Business> _searchResults = [];
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();

//     // Filter the businesses based on the category and initialize _allitems
//     _allitems = widget.businesses
//         .where((business) => business.category.toLowerCase() == widget.title.toLowerCase().toString())
//         .toList();

//     // Check if _allitems is correctly populated
//     print(":::::Initial filtered businesses: ${_allitems.length}");

//     // Initialize _searchResults with the filtered businesses
//     _searchResults = List.from(_allitems);

//     // Add listener to the search controller
//     _searchController.addListener(() {
//       _performSearch(_searchController.text);
//     });
//   }

//   void _performSearch(String query) {
//     if (query.isEmpty) {
//       setState(() {
//         _searchResults = List.from(_allitems);
//       });
//     } else {
//       setState(() {
//         _searchResults = _allitems
//             .where((item) =>
//                 item.name.toLowerCase().contains(query.toLowerCase()) ||
//                 item.location.toLowerCase().contains(query.toLowerCase()))
//             .toList();
//       });
//     }

//     // Debugging: Print the search results
//     print(":::::Search query: $query");
//     print(":::::Filtered businesses count: ${_searchResults.length}");
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_searchResults.isEmpty) {
//       print(":::::No search results found.");
//     } else {
//       _searchResults.forEach((business) {
//         print(":::::Business Name: ${business.name}, Location: ${business.location}");
//       });
//     }

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.only(left: 20, right: 18, top: 40),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image.asset(
//                       widget.iconPath,
//                       width: 45,
//                       height: 45,
//                       color: Colors.blue,
//                     ),
//                     SizedBox(width: 20),
//                     Container(
//                       width: MediaQuery.of(context).size.width * 0.6,
//                       child: Text(
//                         widget.title,
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                           fontSize: 24,
//                           height: 1.2,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.blue,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 30),
//                 TextField(
//                   controller: _searchController,
//                   decoration: InputDecoration(
//                     labelText: 'Search...',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     foregroundColor: Colors.white,
//                   ),
//                   child: Text('Search'),
//                   onPressed: () {
//                     _performSearch(_searchController.text);
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 _isLoading
//                     ? CircularProgressIndicator()
//                     : _searchResults.isEmpty
//                         ? Center(
//                             child: Column(
//                               children: [
//                                 Image.asset(
//                                   width: 60,
//                                   height: 60,
//                                   color: Colors.blue,
//                                   widget.iconPath,
//                                 ),
//                                 SizedBox(height: 20),
//                                 Text(
//                                   'No results available',
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )
//                         : ListView.separated(
//                             shrinkWrap: true,
//                             physics: NeverScrollableScrollPhysics(),
//                             itemCount: _searchResults.length,
//                             separatorBuilder: (context, index) => Divider(),
//                             itemBuilder: (context, index) {
//                               final business = _searchResults[index];
//                               return ListTile(
//                                 leading: Container(
//                                   height: 100,
//                                   child: Image.network(
//                                     business.profilePicture,
//                                     width: 80,
//                                     height: 100,
//                                     fit: BoxFit.fill,
//                                   ),
//                                 ),
//                                 title: SingleChildScrollView(
//                                   scrollDirection: Axis.horizontal,
//                                   child: Text(business.name),
//                                 ),
//                                 subtitle: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(business.category),
//                                     SingleChildScrollView(
//                                       scrollDirection: Axis.horizontal,
//                                       child: Text(business.location),
//                                     ),
//                                   ],
//                                 ),
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => ReviewsScreen(
//                                         customRating: CustomRating(
//                                           coverPicture: business.coverPicture,
//                                           type: business.category,
//                                           name: business.name,
//                                           address: business.location,
//                                           description: business.description,
//                                           profilePicture: business.profilePicture,
//                                           isVerified: business.isVerified,
//                                           phone: business.phone,
//                                           website: business.website,
//                                           socialMedia: business.socialMedia,
//                                           id: business.id,
//                                         ),
//                                         bottomModel: BottomModel(
//                                           title: business.name,
//                                           image: business.coverPicture,
//                                           message: business.category,
//                                           time: business.name,
//                                         ),
//                                         businessId: business.id,
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               );
//                             },
//                           ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }