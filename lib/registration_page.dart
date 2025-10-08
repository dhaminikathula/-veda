import 'package:flutter/material.dart';
import 'events_details.dart';
import 'events_screen.dart';
class Department {
  final String name;
  final String title;
  final String logo;
  final String image;
  Department({
    required this.name,
    required this.title,
    required this.logo,
    required this.image,
  });
}

final List<Department> dummyDepartments = [
  Department(
    name: 'CSE',
    title: 'Computer Science Engineering',
    logo: 'https://img.icons8.com/fluency/96/000000/computer.png',
    image:
        'https://images.unsplash.com/photo-1506744038136-46273834b3fb?fit=crop&w=500&q=80',
  ),
  Department(
    name: 'ECE',
    title: 'Electronics & Communication',
    logo: 'https://img.icons8.com/fluency/96/000000/electronics.png',
    image:
        'https://images.unsplash.com/photo-1464983953574-0892a716854b?fit=crop&w=500&q=80',
  ),
  Department(
    name: 'Mechanical',
    title: 'Mechanical Engineering',
    logo: 'https://img.icons8.com/fluency/96/000000/gear.png',
    image:
        'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?fit=crop&w=500&q=80',
  ),
  Department(
    name: 'Civil',
    title: 'Civil Engineering',
    logo: 'https://img.icons8.com/fluency/96/000000/foundation.png',
    image:
        'https://images.unsplash.com/photo-1416339306562-f3d12fefd36f?fit=crop&w=500&q=80',
  ),
  Department(
    name: 'IT',
    title: 'Information Technology',
    logo: 'https://img.icons8.com/fluency/96/000000/monitor.png',
    image:
        'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?fit=crop&w=500&q=80',
  ),
];
class DepartmentListScreen extends StatefulWidget {
  const DepartmentListScreen({super.key});

  @override
  State<DepartmentListScreen> createState() => _DepartmentListScreenState();
}

class _DepartmentListScreenState extends State<DepartmentListScreen>
    with TickerProviderStateMixin {
  List<Department> departments = dummyDepartments;
  List<Department> filteredDepartments = dummyDepartments;
  List<Department> favoriteDepartments = [];

  final TextEditingController _searchController = TextEditingController();
  final PageController _pageController = PageController(viewportFraction: 0.75);

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredDepartments = departments
          .where((d) =>
              d.title.toLowerCase().contains(query) ||
              d.name.toLowerCase().contains(query))
          .toList();
    });
  }

  void _toggleFavorite(Department dept) {
    setState(() {
      if (favoriteDepartments.contains(dept)) {
        favoriteDepartments.remove(dept);
      } else {
        favoriteDepartments.add(dept);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _buildHomePage(context),
    );
  }

  Widget _buildHomePage(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.topLeft,
          radius: 1.25,
          colors:[Color.fromARGB(255, 11, 1, 53),Color.fromARGB(255, 12, 2, 62),],
          stops: [0.4, 1],
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome to #VEDA',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TextField(
                    controller: _searchController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      icon: Icon(Icons.search, color: Colors.white70),
                      hintText: 'Search department',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Departments',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 120,
                  child: filteredDepartments.isEmpty
                      ? const Center(
                          child: Text(
                          'No departments found',
                          style: TextStyle(color: Colors.white70),
                        ))
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: filteredDepartments.length,
                          itemBuilder: (context, index) {
                            final dept = filteredDepartments[index];
                            return _AnimatedPopularCard(dept: dept);
                          },
                        ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Recommendations',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 320,
                  child: filteredDepartments.isEmpty
                      ? const Center(
                          child: Text(
                          'No departments found',
                          style: TextStyle(color: Colors.white70),
                        ))
                      : PageView.builder(
                          controller: _pageController,
                          itemCount: filteredDepartments.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final dept = filteredDepartments[index];
                            return AnimatedBuilder(
                              animation: _pageController,
                              builder: (context, child) {
                                double scale = 1;
                                if (_pageController.position.haveDimensions) {
                                  double page =
                                      _pageController.page ??
                                          _pageController.initialPage.toDouble();
                                  scale =
                                      (1 - (page - index).abs() * 0.2).clamp(0.8, 1.0);
                                }
                                return Transform.scale(
                                  scale: scale,
                                  child: _AnimatedDepartmentCard(
                                    dept: dept,
                                    isFavorite: favoriteDepartments.contains(dept),
                                    onFavoriteTap: () => _toggleFavorite(dept),
                                    onEventsTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const EventsScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedPopularCard extends StatelessWidget {
  final Department dept;
  const _AnimatedPopularCard({super.key, required this.dept});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          ClipOval(
            child: Image.network(
              dept.logo,
              height: 70,
              width: 70,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.image_not_supported, size: 40, color: Colors.white54),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            dept.name,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _AnimatedDepartmentCard extends StatefulWidget {
  final Department dept;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;
  final VoidCallback onEventsTap;

  const _AnimatedDepartmentCard({
    super.key,
    required this.dept,
    required this.isFavorite,
    required this.onFavoriteTap,
    required this.onEventsTap,
  });

  @override
  State<_AnimatedDepartmentCard> createState() =>
      _AnimatedDepartmentCardState();
}

class _AnimatedDepartmentCardState extends State<_AnimatedDepartmentCard> {
  bool _isHoveredCard = false;
  bool _isHoveredOrganizedBy = false;
  bool _isHoveredDeptName = false;
  bool _isHoveredTitle = false;

  @override
  Widget build(BuildContext context) {
    final dept = widget.dept;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHoveredCard = true),
      onExit: (_) => setState(() => _isHoveredCard = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        width: 240,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
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
            ),
          ],
          border: Border.all(
              color: _isHoveredCard ? Colors.purple : Colors.purpleAccent,
              width: 1.2),
        ),
        transform: Matrix4.identity()..scale(_isHoveredCard ? 1.055 : 1.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                dept.image,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.image_not_supported, size: 60, color: Colors.white54),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipOval(
                      child: Image.network(
                        dept.logo,
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(
                            Icons.image_not_supported,
                            size: 30,
                            color: Colors.white54),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MouseRegion(
                          onEnter: (_) =>
                              setState(() => _isHoveredOrganizedBy = true),
                          onExit: (_) =>
                              setState(() => _isHoveredOrganizedBy = false),
                          child: Text(
                            "Organized by",
                            style: TextStyle(
                                color: _isHoveredOrganizedBy
                                    ? Colors.purple
                                    : Colors.white54,
                                fontSize: 12,
                                fontWeight: _isHoveredOrganizedBy
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                        ),
                        MouseRegion(
                          onEnter: (_) => setState(() => _isHoveredDeptName = true),
                          onExit: (_) => setState(() => _isHoveredDeptName = false),
                          child: Text(
                            dept.name,
                            style: TextStyle(
                                color: _isHoveredDeptName
                                    ? Colors.purple
                                    : Colors.white,
                                fontSize: 14,
                                fontWeight: _isHoveredDeptName
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: widget.onFavoriteTap,
                  child: Icon(
                    widget.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
                    color:
                        widget.isFavorite ? Colors.purpleAccent : Colors.white54,
                    size: 28,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            MouseRegion(
              onEnter: (_) => setState(() => _isHoveredTitle = true),
              onExit: (_) => setState(() => _isHoveredTitle = false),
              child: Text(
                dept.title,
                style: TextStyle(
                    color: _isHoveredTitle ? Colors.purple : Colors.white,
                    fontWeight:
                        _isHoveredTitle ? FontWeight.bold : FontWeight.normal,
                    fontSize: 16),
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: _AnimatedEventsButton(
                onTap: widget.onEventsTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedEventsButton extends StatefulWidget {
  final VoidCallback onTap;

  const _AnimatedEventsButton({required this.onTap});

  @override
  State<_AnimatedEventsButton> createState() => _AnimatedEventsButtonState();
}

class _AnimatedEventsButtonState extends State<_AnimatedEventsButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat(reverse: true);
    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 1.1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurple.withOpacity(0.5),
                blurRadius: 8,
                offset: const Offset(2, 4),
              ),
            ],
          ),
          child: const Text(
            "Events",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
      ),
    );
  }
}
