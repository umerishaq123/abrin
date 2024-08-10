
import 'dart:convert';
import 'dart:io';

import 'package:abrin_app_new/Events/addeventsmodel.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://srv562456.hstgr.cloud/api/event';

  Future<List<Event>> getAllEvents() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/all'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((e) => Event.fromJson(e)).toList();
      } else {
        print(
            'Failed to load events: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to load events');
      }
    } catch (e) {
      print('An error occurred: $e');
      rethrow;
    }
  }

  Future<Event> getEventById(String eventId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$eventId'));

      if (response.statusCode == 200) {
        return Event.fromJson(json.decode(response.body));
      } else {
        print(
            'Failed to load event: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to load event');
      }
    } catch (e) {
      print('An error occurred: $e');
      rethrow;
    }
  }

  Future<http.Response> addEvent(String token, Event event) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse('$baseUrl/add'))
        ..headers['Authorization'] = '$token'
        ..fields['description'] = event.description
        ..fields['name'] = event.name
        ..fields['location'] = event.location
        ..fields['time'] = event.time
        ..fields['date'] = event.date;

      if (event.image.isNotEmpty) {
        request.files
            .add(await http.MultipartFile.fromPath('image', event.image));
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode != 200) {
        print('Failed to add event: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to add event');
      }

      return response;
    } catch (e) {
      print('An error occurred: $e');
      rethrow;
    }
  }

  Future<http.Response> updateEvent(
      String eventId, String token, Event updatedEvent) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/update/$eventId'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: '$token',
        },
        body: json.encode(updatedEvent.toJson()),
      );

      if (response.statusCode != 200) {
        print(
            'Failed to update event: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to update event');
      }

      return response;
    } catch (e) {
      print('An error occurred: $e');
      rethrow;
    }
  }


  Future<void> highlightEvent(String eventId) async {
    try {
      final response = await http.put(Uri.parse('https://srv562456.hstgr.cloud/api/i/admin/highlight/$eventId'));

      if (response.statusCode != 200) {
        print('Failed to highlight event: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to highlight event');
      }
    } catch (e) {
      print('An error occurred: $e');
      rethrow;
    }
  }

  Future<void> unhighlightEvent(String eventId) async {
    try {
      final response = await http.put(Uri.parse('https://srv562456.hstgr.cloud/api/i/admin/unhighlight/$eventId'));

      if (response.statusCode != 200) {
        print('Failed to unhighlight event: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to unhighlight event');
      }
    } catch (e) {
      print('An error occurred: $e');
      rethrow;
    }
  }
}
