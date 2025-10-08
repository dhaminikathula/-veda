import 'package:flutter/material.dart';
import 'events_screen.dart'; 

class EventDetailsScreen extends StatelessWidget {
  final Event event;
  const EventDetailsScreen({super.key, required this.event});

  static final Map<String, Map<String, dynamic>> eventDetailsMap = {
    'Poster Presentation': {
      'description':
          'Showcase your research contributions with well-designed posters. Teams of 2 prepare and present innovative ideas.',
      'teamSize': 2,
      'coordinators': [
        {'name': 'Alice', 'phone': '9876543210'},
        {'name': 'Bob', 'phone': '9765432101'},
      ],
    },
    'Mind Buzzer': {
      'description':
          'An exciting quiz testing your knowledge and quick thinking skills. Teams should be 3 people who are well-versed.',
      'teamSize': 3,
      'coordinators': [
        {'name': 'Carol', 'phone': '9834123456'},
        {'name': 'Dave', 'phone': '9845237641'},
      ],
    },
    'Paper Presentation': {
      'description':
          'Individuals prepare and deliver technical and research-based papers on current topics.',
      'teamSize': 1,
      'coordinators': [
        {'name': 'Eve', 'phone': '9998765432'},
      ],
    },
    'QUIZ': {
      'description':
          'A classic quiz competition covering general knowledge and technology. Teams of 2 are expected.',
      'teamSize': 2,
      'coordinators': [
        {'name': 'Frank', 'phone': '9807654321'},
        {'name': 'Grace', 'phone': '9812345678'},
      ],
    },
    'Project Presentation': {
      'description':
          'Teams of 4 exhibit projects explaining their idea, methodology, and impact to judges.',
      'teamSize': 4,
      'coordinators': [
        {'name': 'Heidi', 'phone': '9871234560'},
      ],
    },
  };

  @override
  Widget build(BuildContext context) {
    final details = eventDetailsMap[event.name];

    if (details == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(event.name),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.black,
        body: const Center(
          child: Text(
            'Details not available for this event',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      );
    }

    final coordinators = (details['coordinators'] as List<dynamic>)
        .map((c) => Coordinator(name: c['name'], phone: c['phone']))
        .toList();

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(event.name),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Title and image immediately below the AppBar
            ClipRRect(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
              child: Image.network(
                event.image,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                  Container(
                    height: 220,
                    color: Colors.grey[900],
                    child: const Icon(Icons.broken_image, size: 60, color: Colors.white54),
                  ),
              ),
            ),
            Expanded(
              child: _DetailsSection(
                event: event,
                description: details['description'],
                teamSize: details['teamSize'],
                coordinators: coordinators,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailsSection extends StatefulWidget {
  final Event event;
  final String description;
  final int teamSize;
  final List<Coordinator> coordinators;

  const _DetailsSection({
    super.key,
    required this.event,
    required this.description,
    required this.teamSize,
    required this.coordinators,
  });

  @override
  State<_DetailsSection> createState() => _DetailsSectionState();
}

class _DetailsSectionState extends State<_DetailsSection> {
  bool _hoverVenue = false;
  bool _hoverDesc = false;
  bool _hoverTeam = false;
  int? _hoverCoordIndex;
  int? _hoverCoordPhone;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) =>
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
          child: ListView(
            children: [
              // Venue row with mouse highlight
              MouseRegion(
                onEnter: (_) => setState(() => _hoverVenue = true),
                onExit: (_) => setState(() => _hoverVenue = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  decoration: BoxDecoration(
                    color: _hoverVenue ? Colors.purpleAccent.withOpacity(0.13) : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                  child: Row(
                    children: [
                      Icon(Icons.location_on, color: _hoverVenue ? Colors.purpleAccent : Colors.white70, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        widget.event.venue,
                        style: TextStyle(
                          color: _hoverVenue ? Colors.purpleAccent : Colors.white70,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Description highlight
              MouseRegion(
                onEnter: (_) => setState(() => _hoverDesc = true),
                onExit: (_) => setState(() => _hoverDesc = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  decoration: BoxDecoration(
                    color: _hoverDesc ? Colors.purpleAccent.withOpacity(0.1) : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  child: Text(
                    widget.description,
                    style: TextStyle(
                      color: _hoverDesc ? Colors.purpleAccent : Colors.white70,
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 22),

              // Team size row with highlight
              MouseRegion(
                onEnter: (_) => setState(() => _hoverTeam = true),
                onExit: (_) => setState(() => _hoverTeam = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  decoration: BoxDecoration(
                    color: _hoverTeam ? Colors.purpleAccent.withOpacity(0.13) : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  child: Row(
                    children: [
                      Icon(Icons.group, color: _hoverTeam ? Colors.purpleAccent : Colors.white70, size: 22),
                      const SizedBox(width: 10),
                      Text(
                        'Team Size: ${widget.teamSize}',
                        style: TextStyle(
                          color: _hoverTeam ? Colors.purpleAccent : Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 26),

              // Coordinators with mouse highlight on name/phone
              const Text(
                'Coordinators',
                style: TextStyle(
                  color: Colors.purpleAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              ...List.generate(widget.coordinators.length, (i) {
                final c = widget.coordinators[i];
                final isHoverName = _hoverCoordIndex == i;
                final isHoverPhone = _hoverCoordPhone == i;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Icon(Icons.person, color: isHoverName ? Colors.purpleAccent : Colors.white70, size: 20),
                      const SizedBox(width: 8),
                      MouseRegion(
                        onEnter: (_) => setState(() => _hoverCoordIndex = i),
                        onExit: (_) => setState(() => _hoverCoordIndex = null),
                        child: Text(
                          c.name,
                          style: TextStyle(
                            color: isHoverName ? Colors.purpleAccent : Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Icon(Icons.phone, color: isHoverPhone ? Colors.purpleAccent : Colors.white54, size: 19),
                      const SizedBox(width: 8),
                      MouseRegion(
                        onEnter: (_) => setState(() => _hoverCoordPhone = i),
                        onExit: (_) => setState(() => _hoverCoordPhone = null),
                        child: Text(
                          c.phone,
                          style: TextStyle(
                            color: isHoverPhone ? Colors.purpleAccent : Colors.white,
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),

              SizedBox(height: constraints.maxHeight * 0.08),

              Align(
                alignment: Alignment.bottomRight,
                child: MouseRegion(
                  onEnter: (_) => setState(() => _hoverTeam = true),
                  onExit: (_) => setState(() => _hoverTeam = false),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _hoverTeam ? Colors.purpleAccent : Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Registered for ${widget.event.name}')),
                      );
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
