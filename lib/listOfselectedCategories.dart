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





import 'package:abrin_app_new/Search/Service.dart';
import 'package:abrin_app_new/Search/business_detail.dart';
import 'package:abrin_app_new/Search/localBusinesscategory.dart';
import 'package:flutter/material.dart';

class LISTCA extends StatefulWidget {
  final String title;
  final String iconPath;

  LISTCA({required this.title, required this.iconPath});

  @override
  State<LISTCA> createState() => _LISTCAState();
}

class _LISTCAState extends State<LISTCA> {
  TextEditingController _searchController = TextEditingController();
  List<LocalBusinessCategory> _allitems = [];
  List<LocalBusinessCategory> _searchResults = [];
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
      final businesses = await BusinessServicesearch().fetchBusinesses();
      final filteredBusinesses = businesses.where((business) {
        return business.category.toLowerCase() == widget.title.toLowerCase();
      }).toList();

      setState(() {
        _allitems = filteredBusinesses
            .map((business) => LocalBusinessCategory(
                  businessName: business.name,
                  imagePath:
                      business.coverPicture ?? 'assets/images/default.png',
                  category: business.category,
                  location: business.location,
                  rating: business.rating,
                ))
            .toList();
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
              item.businessName.toLowerCase().contains(query.toLowerCase()) ||
              item.location.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                              final businescategory = _searchResults[index];
                              return ListTile(
                                leading: Container(
                                  height: 100,
                                  child: Image.network(
                                    businescategory.imagePath,
                                    width: 80,
                                    height: 100,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                title: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(businescategory.businessName),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(businescategory.category),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Text(businescategory.location),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BusinessDetail(
                                          business: businescategory),
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
