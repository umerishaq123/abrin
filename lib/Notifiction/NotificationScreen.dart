import 'dart:async';
import 'dart:convert';


import 'package:abrin_app_new/Notifiction/modelForNotification.dart';
import 'package:abrin_app_new/Notifiction/notificationDataWidget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationModel> _notifications = [];
  bool _isLoading = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _fetchNotifications();
    _startTimeout();
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> _fetchNotifications() async {
    final token = await getToken();
    if (token == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final response = await https.get(
      Uri.parse('https://srv562456.hstgr.cloud/api/business/notifications'),
      headers: {
        'Authorization': '$token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> notificationData = json.decode(response.body);
      setState(() {
        _notifications = notificationData
            .map((data) => NotificationModel.fromJson(data))
            .toList();
        _isLoading = false;
      });
      _timer?.cancel(); // Cancel the timer if data is loaded successfully
    } else {
      // Handle error
      print('Failed to load notifications');
      setState(() {
        _isLoading = false;
      });
      _timer?.cancel(); // Cancel the timer if data loading failed
    }
  }

  Future<void> _markAsRead(String notificationId) async {
    final token = await getToken();
    if (token == null) {
      return;
    }

    final response = await https.put(
      Uri.parse(
          'https://srv562456.hstgr.cloud/api/business/notifications/$notificationId/read'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Successfully marked as read, now update UI
      setState(() {
        _notifications
            .removeWhere((notification) => notification.id == notificationId);
      });
    } else {
      // Handle error
      print('Failed to mark notification as read');
    }
  }

  void _startTimeout() {
    _timer = Timer(Duration(seconds: 30), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        centerTitle: true,
        title: Text(
          'Notification',
          style: TextStyle(
              fontSize: 26,
              fontFamily: 'Main',
              letterSpacing: 1.5,
              fontWeight: FontWeight.w700,
              color: Colors.blue),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : _notifications.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Image.asset(
                                'assets/images/notificationNotFound.jfif',
                                width: 200,
                                height: 200),
                          ),
                          SizedBox(height: 24),
                          Text(
                            'Aucune notification pour l\'instant !',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      reverse: true,
                      itemCount: _notifications.length,
                      itemBuilder: (context, index) {
                        return Notificationdata(
                          notification: _notifications[index],
                          onMarkAsRead: _markAsRead,
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
