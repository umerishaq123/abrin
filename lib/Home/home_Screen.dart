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
import 'package:abrin_app_new/RetriveToken.dart';
import 'package:abrin_app_new/Search/searchBusiness.dart';
import 'package:abrin_app_new/aouth/accountScreen.dart';
import 'package:abrin_app_new/aouth/component/session_handling_provider.dart';
import 'package:abrin_app_new/aouth/login.dart';
import 'package:abrin_app_new/aouth/signup.dart';
import 'package:abrin_app_new/componets/customCategories.dart';
import 'package:abrin_app_new/componets/modelCategories.dart';
import 'package:abrin_app_new/listOfselectedCategories.dart';
import 'package:abrin_app_new/utilis/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final List<Categorys> categories;
  const HomeScreen({required this.categories, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = '';
  // TextEditingController searchcontroller=TextEditingController();
  List<Business> allBusinesses = [];
  List<Business> filteredBusinesses = [];
  bool isLoading = false;
  final FocusNode _focusNode = FocusNode();
  final GlobalKey<BottomNavBarState> bottomNavBarKey =
      GlobalKey<BottomNavBarState>();

  @override
  void initState() {
    super.initState();
    _fetchBusinesses();
    final viewModel =
        Provider.of<SessionHandlingViewModel>(context, listen: false);
    viewModel.fetchToken();
  }

  Future<void> _fetchBusinesses() async {
    setState(() {
      isLoading = true; // Start loading
    });
    try {
      final businesses = await BusinessService().fetchBusinesses();
 if (!mounted) return;
      setState(() {
        allBusinesses = businesses;
        filteredBusinesses = businesses;
      });
    } catch (e) {
      print('Error fetching businesses: $e');
    } finally {
      if (!mounted) return;
      setState(() {
        isLoading = false; // Stop loading
      });
    }
  }

  void _updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
      filteredBusinesses = allBusinesses
          .where((business) =>
              business.name.toLowerCase().contains(query.toLowerCase()) ||
              business.category.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  bool isLoggedIn() {
    return true;
  }

  @override
  void dispose() {
    _focusNode.dispose(); // Don't forget to dispose the FocusNode
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Consumer<SessionHandlingViewModel>(
        builder: (context, viewModel, child) {
          final bool loggedIn = viewModel.token != null;
          print("::: the token is hare:${viewModel.getToken()}");
          print("the toke is exist or not :${loggedIn}");
          return BottomNavBar(
            key: bottomNavBarKey,
            initialPage: 0, // Home page index
            pages: [
              _buildHomeContent(context, viewModel, widget.categories),
              const Searchbusiness(),
              EventListScreen(),
              BookmarkedScreen(),
              loggedIn
                  ? AccountScreen()
                  : LoginPage(
                      islogin: false,
                    ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHomeContent(BuildContext context,
      SessionHandlingViewModel viewModel, List<Categorys> categories) {
    // print("::: the all bussines is :${filteredBusinesses[0].category}");
    return GestureDetector(
      onTap: (){
        Utils.dismissKeyboard(context);
      },
      child: RefreshIndicator(
        onRefresh: _fetchBusinesses,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height:MediaQuery.of(context).size.height*0.19,
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
                        left: 23,
                        right: 8,
                        child: Text(
                          "Trouvez une entreprise ou un service près de chez vous",
                          style: TextStyle(
                              fontSize: 14,
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
                            child: GestureDetector(
                              onTap: () {
                                // Access the BottomNavBarState and change the page index
                                print("::: presses");
                                final bottomNavBarState =
                                    bottomNavBarKey.currentState;
                                if (bottomNavBarState != null) {
                                  print("::: not null");
                                  bottomNavBarState
                                      .setPage(1); // Change to the search screen
                                } else {
                                  print("::: BottomNavBarState is null");
                                }
                              },
                              child: AbsorbPointer(
                                // Prevents user input
                                child: TextFormField(
                                  focusNode: _focusNode,
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
                                ),
                              ),
                            ),
                          )),
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
                            itemCount: widget.categories.length,
                            itemBuilder: (context, index) {
                              final category = widget.categories[index];
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LISTCA(
                                                title: category.text.toString(),
                                                iconPath:
                                                    category.icon.toString(),
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
                        "Découvrez nos recommandations d'entreprises ",
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
                                  "Ajoutez une entreprise dans abirin",
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
                                        onPressed: () async {
                                          print(
                                              "::: the token is :${viewModel.getToken()}");
                                          final bool loggedIn =
                                              await viewModel.getToken() != null;
                                          if (loggedIn) {
                                            // User is logged in, navigate to add new business screen
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AddNewBusinessScreen(
                                                  categories: categories,
                                                ),
                                              ),
                                            );
                                          } else {
                                            Utils.snackBar(
                                                "s'il vous plaît, inscrivez-vous d'abord !",
                                                context);
                                            // User is not logged in, navigate to signup screen
                                            Future.delayed(Duration(seconds: 3),
                                                () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      SignupPage(), // Replace with your Signup screen widget
                                                ),
                                              );
                                            });
                                          }
                                        },
                                        child: Text(
                                          // child: Text(viewModel.getToken() != null ? 'Add Business' : 'Sign Up'),
      
                                          " Commencer ",
      
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
        ),
      ),
    );
  }

  Future<String?> _getToken() async {
    return await SessionHandlingViewModel().getToken();
  }

  Widget _buildBusinessList(BuildContext context) {
    // final highlightedBusinesses = filteredBusinesses.where((business) => business.isHighlighted).toList();
    final highlightedBusinesses = filteredBusinesses
        .where((business) => business.isHighlighted ?? false)
        .toList();

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      width: double.infinity,
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : highlightedBusinesses.isEmpty
              ? Center(
                  child: Text(
                    "Aucune entreprise trouvée", // French for "No businesses found"
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                )
              : ListView.builder(
                  itemCount: highlightedBusinesses.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    // print("::: the filter businuses are :${filteredBusinesses[index]}");
                    final business = highlightedBusinesses[index];
                    print(":::: the businus id:${business.id}");

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
                                // rating: business.rating,
                                description: business.description,
                                isVerified: business.isVerified,
                                profilePicture: business.profilePicture,
                                phone: business.phone,
                                website: business.website,
                                socialMedia: business.socialMedia,
                                email: business.email,
                                id: business.id,
                                city: '${business.city}',
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
                        // rating: business.rating,
                        description: business.description,
                        isVerified: business.isVerified,
                        profilePicture: business.profilePicture,
                        phone: business.phone,
                        website: business.website,
                        socialMedia: business.socialMedia,
                        email: business.email,
                        id: business.id, city: '${business.city}',
                      ),
                    );
                  },
                ),
    );
  }
}
