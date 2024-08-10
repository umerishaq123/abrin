
import 'package:abrin_app_new/Home/ReviewBusiness/HASFR.dart';
import 'package:flutter/material.dart';

class BottomModel {
  final String title;
  final String image;
  final String message;
  final String time;

  BottomModel({
    required this.title,
    required this.image,
    required this.message,
    required this.time,
  });
}

class BottomSheetContent extends StatefulWidget {
  final BottomReview bottomReview;
  BottomSheetContent({required this.bottomReview});

  @override
  _BottomSheetContentState createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  final TextEditingController _textController = TextEditingController();
  int _overallRating = 0;
  int _serviceRating = 0;
  int _hospitalityRating = 0;
  int _pricingRating = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                GestureDetector(
                  onTap: () {
                    // Collect data and pass to the main screen
                    final newReview = BottomReview(
                      title: 'New Review',
                      image: 'assets/images/profile.jpg',
                      message: _textController.text,
                      time: 'Just now',
                      messicon: 'assets/images/profile.jpg',
                      Rating: _overallRating.toString(),
                    );
                    Navigator.pop(context, newReview);
                  },
                  child: Container(
                    height: 30,
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blue),
                    child: Center(
                      child: Text(
                        'Publier',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Divider(thickness: 1),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(widget.bottomReview.image,
                  
                  ),
                  radius: 24,
                ),
                SizedBox(width: 8),
                Text(
                  widget.bottomReview.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Divider(thickness: 1),
            SizedBox(height: 10),
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Ecrivez votre avis ici...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text('Overall', style: TextStyle(fontWeight: FontWeight.bold)),
            StarRating(
              onRatingChanged: (rating) {
                setState(() {
                  _overallRating = rating;
                });
              },
            ),
            const SizedBox(height: 10),
            Text('Service', style: TextStyle(fontWeight: FontWeight.bold)),
            StarRating(
              onRatingChanged: (rating) {
                setState(() {
                  _serviceRating = rating;
                });
              },
            ),
            SizedBox(height: 10),
            Text('Hospitality', style: TextStyle(fontWeight: FontWeight.bold)),
            StarRating(
              onRatingChanged: (rating) {
                setState(() {
                  _hospitalityRating = rating;
                });
              },
            ),
            SizedBox(height: 10),
            Text('Pricing', style: TextStyle(fontWeight: FontWeight.bold)),
            StarRating(
              onRatingChanged: (rating) {
                setState(() {
                  _pricingRating = rating;
                });
              },
            ),
            SizedBox(height: 10),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     TextButton.icon(
            //       onPressed: () {
            //         // Action for attaching images
            //       },
            //       icon: Icon(Icons.attach_file),
            //       label: Text('Joindre des images'),
            //     ),
            //     ElevatedButton(
            //       onPressed: () {
            //         // Collect data and pass to the main screen
            //         final newReview = BottomReview(
            //           title: 'New Review',
            //           image: 'assets/images/profile.jpg',
            //           message: _textController.text,
            //           time: 'Just now',
            //           messicon: 'assets/images/profile.jpg',
            //           Rating: _overallRating.toString(),
            //         );
            //         Navigator.pop(context, newReview);
            //       },
            //       child: Text('Publier'),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

class StarRating extends StatefulWidget {
  final ValueChanged<int> onRatingChanged;

  StarRating({required this.onRatingChanged});

  @override
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width * 0.7,
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(5, (index) {
          return IconButton(
            icon: Icon(
              index < _rating ? Icons.star : Icons.star_border,
              color: Colors.blue,
            ),
            onPressed: () {
              setState(() {
                _rating = index + 1;
              });
              widget.onRatingChanged(_rating);
            },
          );
        }),
      ),
    );
  }
}