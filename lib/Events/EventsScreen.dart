
import 'package:abrin_app_new/Events/ApiHandlerForEvents.dart';
import 'package:abrin_app_new/Events/addeventsmodel.dart';
import 'package:abrin_app_new/Events/addyourEvents.dart';
import 'package:abrin_app_new/Events/eventDetail.dart';
import 'package:flutter/material.dart';

class EventListScreen extends StatefulWidget {
  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  final ApiService apiService = ApiService();
  late Future<List<Event>> events;

  @override
  void initState() {
    super.initState();
    events = apiService.getAllEvents();
  }

  void toggleHighlight(Event event) async {
    try {
      if (event.highlighted) {
        await apiService.unhighlightEvent(event.id);
      } else {
        await apiService.highlightEvent(event.id);
      }
      setState(() {
        event.highlighted = !event.highlighted;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update event highlight status')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Des événements pour vous',
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
        ),
      ),
      body: FutureBuilder<List<Event>>(
        future: events,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Échec du chargement des événements'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'Aucun événement trouvé',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final event = snapshot.data![index];
              return Padding(
                padding: const EdgeInsets.all(12),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Eventdetail(event: event),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: event.highlighted
                            ? Colors.yellow
                            : Color.fromARGB(0, 26, 24, 24),
                        width: 2,
                      ),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Image.network(
                            event.image,
                            height: 95,
                            width: 90,
                            fit: BoxFit.fill,
                            errorBuilder: (context, error, stackTrace) {
                              print(event.image);
                              return Icon(Icons.error, size: 100);
                            },
                          ),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(event.name),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      toggleHighlight(event);
                                    },
                                    child: Icon(
                                      event.highlighted
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: event.highlighted
                                          ? Colors.yellow
                                          : const Color.fromARGB(255, 70, 68, 68),
                                    ),
                                  ),
                                ],
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(event.description),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(event.location),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text('Date: ${event.date}'),
                              ),
                              Text(
                                'temps: ${event.time}',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 36,
          width: MediaQuery.of(context).size.width - 140,
          decoration: BoxDecoration(),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddEventScreen()),
              );
            },
            backgroundColor: Colors.blue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Text(
              " Ajouter un évènement ",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
