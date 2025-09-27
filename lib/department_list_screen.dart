// department_list_screen.dart

import 'package:flutter/material.dart';
import 'package:departmentspg/departement_model.dart';
import 'department_api.dart';

class DepartmentListScreen extends StatefulWidget {
  const DepartmentListScreen({super.key});

  @override
  State<DepartmentListScreen> createState() => _DepartmentListScreenState();
}

class _DepartmentListScreenState extends State<DepartmentListScreen>
    with TickerProviderStateMixin {
  late Future<List<Department>> futureDepartments;
  List<Department> departments = [];
  List<Department> filteredDepartments = [];
  List<Department> favoriteDepartments = [];
  int _currentIndex = 0;

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureDepartments = fetchDepartments();
    futureDepartments.then((deptList) {
      setState(() {
        departments = deptList;
        filteredDepartments = deptList;
      });
    });

    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
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

  // 🔹 Home page: Welcome + Popular + Recommendations
  Widget _buildHomePage() {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.topLeft,
          radius: 1.25,
          colors: [Color(0xFF2E0854), Colors.black],
          stops: [0.4, 1],
        ),
      ),
      child: SafeArea(
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

              // Search bar
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

              // Popular Section (Logos + Names)
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
                        ),
                      )
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

              // Recommendations Section (Full Cards)
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
                        ),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: filteredDepartments.length,
                        itemBuilder: (context, index) {
                          final dept = filteredDepartments[index];
                          return _AnimatedDepartmentCard(
                            dept: dept,
                            isFavorite: favoriteDepartments.contains(dept),
                            onFavoriteTap: () => _toggleFavorite(dept),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Empty Page
  Widget _buildEmptyPage(String title) {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.topLeft,
          radius: 1.25,
          colors: [Color(0xFF2E0854), Colors.black],
          stops: [0.4, 1],
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Text(
            title,
            style: const TextStyle(color: Colors.white70, fontSize: 18),
          ),
        ),
      ),
    );
  }

  // 🔹 Bottom Navigation
  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black87,
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.3),
            offset: const Offset(0, -3),
            blurRadius: 10,
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        selectedItemColor: Colors.purpleAccent,
        unselectedItemColor: Colors.white70,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
            activeIcon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_outlined),
            label: 'Events',
            activeIcon: Icon(Icons.event),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.app_registration_outlined),
            label: 'Registrations',
            activeIcon: Icon(Icons.app_registration),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
            activeIcon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget bodyWidget;

    switch (_currentIndex) {
      case 0:
        bodyWidget = _buildHomePage();
        break;
      case 1:
        bodyWidget = _buildEmptyPage('Events Page (Empty)');
        break;
      case 2:
        bodyWidget = _buildEmptyPage('Registrations Page (Empty)');
        break;
      case 3:
        bodyWidget = _buildEmptyPage('Profile Page (Empty)');
        break;
      default:
        bodyWidget = _buildHomePage();
    }

    return Scaffold(
      extendBody: true,
      body: bodyWidget,
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}

// 🔹 Popular Card (Logo + Name)
class _AnimatedPopularCard extends StatefulWidget {
  final Department dept;

  const _AnimatedPopularCard({required this.dept});

  @override
  State<_AnimatedPopularCard> createState() => _AnimatedPopularCardState();
}

class _AnimatedPopularCardState extends State<_AnimatedPopularCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.2, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dept = widget.dept;

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: GestureDetector(
          onTap: () {
            print("Tapped ${dept.name} in Popular");
          },
          child: Container(
            width: 100,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                ClipOval(
                  child: Image.network(
                    'https://adityauniversity.in:2001/public/Department_Images/${dept.logo}',
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.image_not_supported,
                            size: 40, color: Colors.white54),
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
          ),
        ),
      ),
    );
  }
}

// 🔹 Recommendation Card (Full Card)
class _AnimatedDepartmentCard extends StatefulWidget {
  final Department dept;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;

  const _AnimatedDepartmentCard({
    required this.dept,
    required this.isFavorite,
    required this.onFavoriteTap,
  });

  @override
  State<_AnimatedDepartmentCard> createState() =>
      _AnimatedDepartmentCardState();
}

class _AnimatedDepartmentCardState extends State<_AnimatedDepartmentCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.3, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dept = widget.dept;

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          width: 240,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.purpleAccent.withOpacity(0.4),
                offset: const Offset(0, 4),
                blurRadius: 10,
              ),
            ],
            border: Border.all(color: Colors.purpleAccent, width: 1.2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Department image
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  'https://adityauniversity.in:2001/public/Department_Images/${dept.image}',
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image_not_supported,
                          size: 60, color: Colors.white54),
                ),
              ),
              const SizedBox(height: 10),

              // Logo + Organized by + Favorite
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipOval(
                        child: Image.network(
                          'https://adityauniversity.in:2001/public/Department_Images/${dept.logo}',
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.image_not_supported,
                                  size: 30, color: Colors.white54),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Organized by",
                            style: TextStyle(
                                color: Colors.white54, fontSize: 12),
                          ),
                          Text(
                            dept.name,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
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
                      color: widget.isFavorite
                          ? Colors.purpleAccent
                          : Colors.white54,
                      size: 28,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Title
              Text(
                dept.title,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),

              const SizedBox(height: 12),

              // Events Button
              _AnimatedEventsButton(
                onTap: () {
                  print("Tapped Events in ${dept.name}");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 🔹 Animated Events Button (Looping Pulse + Clickable)
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