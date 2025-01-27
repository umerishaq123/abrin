
import 'package:abrin_app_new/BookMark/bookMarkScreen.dart';
import 'package:abrin_app_new/Bottom%20bar/curvedBottomvar.dart';
import 'package:abrin_app_new/Bussinesses/AddNewBusiness/AddNewBussiness.dart';
import 'package:abrin_app_new/Bussinesses/bussinessModel.dart';
import 'package:abrin_app_new/Events/EventsScreen.dart';
import 'package:abrin_app_new/Home/ReviewBusiness/BottomSheet.dart';
import 'package:abrin_app_new/Home/ReviewBusiness/ReviewScreen.dart';
import 'package:abrin_app_new/Home/business/businessDataHandler.dart';
import 'package:abrin_app_new/Home/business/customRatings.dart';
import 'package:abrin_app_new/Notifiction/NotificationScreen.dart';
import 'package:abrin_app_new/Search/searchBusiness.dart';
import 'package:abrin_app_new/aouth/accountScreen.dart';
import 'package:abrin_app_new/aouth/login.dart';
import 'package:abrin_app_new/componets/customCategories.dart';
import 'package:abrin_app_new/componets/modelCategories.dart';
import 'package:abrin_app_new/listOfselectedCategories.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final List<Categorys> categories;
  const HomeScreen({required this.categories, super.key});

  bool isLoggedIn() {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: BottomNavBar(
        initialPage: 0, // Home page index
        pages: [
          _buildHomeContent(context),
          const Searchbusiness(),
          EventListScreen(),
          BookmarkedScreen(),
          isLoggedIn() ? AccountScreen() : LoginPage(),
        ],
      ),
    );
  }

  Widget _buildHomeContent(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              color: Colors.blue,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          " abirin",
                          style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      //   GestureDetector(
                      //     onTap: () {
                      //       Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => NotificationScreen()),
                      //       );
                      //     },
                      //     child: const Icon(
                      //       Icons.notification_add_rounded,
                      //       color: Colors.white,
                      //       size: 32,
                      //     ),
                      //   )
                      ],
                    ),
                  ),
                   Positioned(
                    top: 62,
                    left: 28,
                    right: 8,
                    child: Text(
                      "Trouvez une entreprise ou un service près de chez vous",
                      style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                  Positioned(
                      bottom: 7,
                      left: 30,
                      right: 30,
                      child: Container(
                          height: 45,
                          width: double.infinity,
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                                borderSide: const BorderSide(
                                    color: Colors.transparent),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                                borderSide: const BorderSide(
                                    color: Colors.transparent),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                                borderSide: const BorderSide(
                                    color: Colors.transparent),
                              ),
                              prefixIcon: const Padding(
                                padding: EdgeInsets.only(
                                    bottom: 10, top: 10, left: 10),
                                child: Image(
                                  height: 30,
                                  width: 30,
                                  image: AssetImage(
                                      "assets/images/iconsearch.jpeg"),
                                ),
                              ),
                              hintStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 121, 120, 120),
                                fontSize: 14,
                                fontFamily: "Montserrat",
                              ),
                              hintText:
                                  "Rechercher une entreprise ou des services",
                              filled: true,
                              fillColor: Colors.white,
                              errorStyle: const TextStyle(
                                height: 0.07,
                                color: Colors.red,
                              ),
                            ),
                          ))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Catégories",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const Text(
                    "Qu'est-ce qui vous intéresse?",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 126,
                    width: double.infinity,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LISTCA(
                                            title: category.text.toString(),
                                            iconPath: category.icon.toString(),
                                          )),
                                );
                              },
                              child: CustomCategory(
                                  imagePath: category.icon.toString(),
                                  text: category.text.toString()));
                        }),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: Divider(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Entreprises à découvrir",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  const Text(
                    "Découvrez nos recommandations d'entreprises à découvrir",
                    style: TextStyle(
                        fontSize: 16, color: Colors.black, height: 1.2),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _buildBusinessList(context),
                  const Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: Divider(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20),
                        child: Column(
                          children: [
                            const Text(
                              "Inscrivez une entreprise ",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            const Text(
                              "Ajoutez une entreprise dans Abirin",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(159, 246, 243, 243),
                                  height: 1.2),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.white),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const AddNewBusinessScreen()),
                                      );
                                    },
                                    child: const Text(
                                      " Comencer ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w500),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBusinessList(BuildContext context) {
    return FutureBuilder<List<Business>>(
      future: BusinessService().fetchBusinesses(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No approved businesses found'));
        } else {
          final approvedBusinesses =
              snapshot.data!.where((business) => business.isApproved).toList();
          return SizedBox(
            height: 300,
            width: double.infinity,
            child: ListView.builder(
              itemCount: approvedBusinesses.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final business = approvedBusinesses[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReviewsScreen(
                          customRating: CustomRating(
                            coverPicture: business.coverPicture,
                            type: business.category,
                            name: business.name,
                            address: business.location,
                            rating: business.rating,
                            description: business.description,
                            isVerified: business.isVerified,
                            profilePicture: business.profilePicture,
                          ),
                          bottomModel: BottomModel(
                            title: business.name,
                            image: business.coverPicture,
                            message: business.category,
                            time: business.name,
                          ),
                          businessId: business.id,
                        ),
                      ),
                    );
                  },
                  child: CustomRating(
                    coverPicture: business.coverPicture,
                    type: business.category,
                    name: business.name,
                    address: business.location,
                    rating: business.rating,
                    description: business.description,
                    isVerified: business.isVerified,
                    profilePicture: business.profilePicture,
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}



