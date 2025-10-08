import 'package:flutter/material.dart';
import 'events_details.dart';

class Coordinator {
  final String name;
  final String phone;
  Coordinator({required this.name, required this.phone});
}
class Event {
  final String name;
  final String venue;
  final String image;
  Event({required this.name, required this.venue, required this.image});
}
final List<Event> eventsList = [
  Event(
    name: 'Poster Presentation',
    venue: 'Billgates Bhavan',
    image: 'https://slidemodel.com/wp-content/uploads/01-poster-presentation-cover.png',
  ),
  Event(
    name: 'Mind Buzzer',
    venue: 'CV Raman Bhavan',
    image: 'data:image/jpeg;base64,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',
  ),
  Event(
    name: 'Paper Presentation',
    venue: 'Ramanujan Bhavan',
    image: 'https://images.unsplash.com/photo-1519125323398-c3a59338.jpg?auto=format&fit=crop&w=500&q=80',
  ),
  Event(
    name: 'QUIZ',
    venue: 'Cotton Bhavan',
    image: '2wCEAAkGBxISEhUQEBIVFRUVFRUYFRUWFRoVFRcVFhUWGBUVFxYYHSggGB8lGxUVITEhJSkrLi8uFx8zODMtNygtLisBCgoKDg0OGhAQGy0lHiUtLS0tLS0tLS0rLS8uLS0tLS0tLS0tLSstLi0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLf',
  ),
  Event(
    name: 'Project Presentation',
    venue: 'James Watt Bhavan',
    image: 'data:image/jpeg;base64,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',
  ),
];
class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text('Events'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topLeft,
            radius: 1.25,
            colors: [Color.fromARGB(255, 11, 1, 53),Color.fromARGB(255, 12, 2, 62),],
            stops: [0.3, 1],
          ),
        ),
        child: SafeArea(
          child: Scrollbar(
            thumbVisibility: true,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemCount: eventsList.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final event = eventsList[index];
                return _AnimatedEventCard(event: event);
              },
            ),
          ),
        ),
      ),
    );
  }
}
class _AnimatedEventCard extends StatefulWidget {
  final Event event;
  const _AnimatedEventCard({super.key, required this.event});
  @override
  State<_AnimatedEventCard> createState() => _AnimatedEventCardState();
}
class _AnimatedEventCardState extends State<_AnimatedEventCard> {
  bool _isHoveredCard = false;
  bool _isHoveredVenue = false;
  bool _isHoveredName = false;

  @override
  Widget build(BuildContext context) {
    final event = widget.event;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => EventDetailsScreen(event: event),
          ),
        );
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHoveredCard = true),
        onExit: (_) => setState(() => _isHoveredCard = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: _isHoveredCard
                    ? Colors.purpleAccent
                    : Colors.purpleAccent.withOpacity(0.36),
                offset: const Offset(0, 10),
                blurRadius: _isHoveredCard ? 26 : 10,
              )
            ],
            border: Border.all(
              color: _isHoveredCard ? Colors.purple : Colors.purpleAccent,
              width: 1.2,
            ),
          ),
          transform: Matrix4.identity()..scale(_isHoveredCard ? 1.025 : 1.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  event.image,
                  height: 130,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 130,
                    color: Colors.grey[900],
                    child: const Icon(Icons.broken_image,
                        size: 60, color: Colors.white54),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              MouseRegion(
                onEnter: (_) => setState(() => _isHoveredName = true),
                onExit: (_) => setState(() => _isHoveredName = false),
                child: Text(
                  event.name,
                  style: TextStyle(
                    color: _isHoveredName ? Colors.purple : Colors.white,
                    fontSize: _isHoveredName ? 20 : 16,
                    fontWeight:
                        _isHoveredName ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              MouseRegion(
                onEnter: (_) => setState(() => _isHoveredVenue = true),
                onExit: (_) => setState(() => _isHoveredVenue = false),
                child: Text(
                  event.venue,
                  style: TextStyle(
                    color: _isHoveredVenue ? Colors.purpleAccent : Colors.white70,
                    fontSize: 14,
                    fontWeight:
                        _isHoveredVenue ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
              const SizedBox(height:12),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purpleAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  onPressed: (){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Registered for ${event.name}')),
                    );
                  },
                  child: const Text("Register"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
