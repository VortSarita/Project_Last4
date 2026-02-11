import 'package:flutter/material.dart';
import 'click.dart';
import 'favorite.dart';
import 'explore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool isDark = true;
  int _currentPageIndex = 0;
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> filteredDestinations = [];
  late AnimationController _toggleController;
  late AnimationController _navController;

  // ALL 25 PROVINCES OF CAMBODIA
  final List<Map<String, dynamic>> destinations = [
    {
      'name': 'Phnom Penh',
      'image': 'assets/Pp.png',
      'rate': 4.9,
      'fav': false,
      'visited': false,
      'savedDate': null,
    },
    {
      'name': 'Siem Reap',
      'image': 'assets/SiemReap.jpg',
      'rate': 4.9,
      'fav': false,
      'visited': false,
      'savedDate': null,
    },
    {
      'name': 'Battambang',
      'image': 'assets/Battambang.png',
      'rate': 4.7,
      'fav': false,
      'visited': false,
      'savedDate': null,
    },
    {
      'name': 'Sihanoukville',
      'image': 'assets/Sihanoukville.jpg',
      'rate': 4.6,
      'fav': false,
      'visited': false,
      'savedDate': null,
    },
    {
      'name': 'Kampot',
      'image': 'assets/Kompot.jpg',
      'rate': 4.7,
      'fav': false,
      'visited': false,
      'savedDate': null,
    },
    {
      'name': 'Kep',
      'image': 'assets/Keb.png',
      'rate': 4.5,
      'fav': false,
      'visited': false,
      'savedDate': null,
    },
    {
      'name': 'Kampong Cham',
      'image': 'assets/KompongCham.jpg',
      'rate': 4.4,
      'fav': false,
      'visited': false,
      'savedDate': null,
    },
    {
      'name': 'Kampong Chhnang',
      'image': 'assets/KompongChnang.png',
      'rate': 4.3,
      'fav': false,
      'visited': false,
      'savedDate': null,
    },
    {
      'name': 'Kampong Speu',
      'image': 'assets/KompongSpeu.png',
      'rate': 4.3,
      'fav': false,
      'visited': false,
      'savedDate': null,
    },
    {
      'name': 'Kampong Thom',
      'image': 'assets/KompongThom.png',
      'rate': 4.4,
      'fav': false,
      'visited': false,
      'savedDate': null,
    },
    {
      'name': 'Kandal',
      'image': 'assets/Kandal.png',
      'rate': 4.2,
      'fav': false,
      'visited': false,
      'savedDate': null,
    },
    {
      'name': 'Koh Kong',
      'image': 'assets/KohKong.webp',
      'rate': 4.5,
      'fav': false,
      'visited': false,
      'savedDate': null,
    },
    {
      'name': 'Kratié',
      'image': 'assets/Kratie.png',
      'rate': 4.6,
      'fav': false,
      'visited': false,
      'savedDate': null,
    },
    {
      'name': 'Mondulkiri',
      'image': 'assets/Mondulkiri.jpg',
      'rate': 4.8,
      'fav': false,
      'visited': false,
      'savedDate': null,
    },
    {
      'name': 'Banteay Meanchey',
      'image': 'assets/BanteayMeanchey.png',
      'rate': 4.4,
      'fav': false,
      'visited': false,
      'savedDate': null,
    },
    {
      'name': 'Tboung Khmum',
      'image': 'assets/TboungKhmum.png',
      'rate': 4.7,
      'fav': false,
      'visited': false,
      'savedDate': null,
    },
    {
      'name': 'Pailin',
      'image': 'assets/Pailin.png',
      'rate': 4.3,
      'fav': false,
      'visited': false,
      'savedDate': null,
    },
    {
      'name': 'Preah Vihear',
      'image': 'assets/PreahVihea.webp',
      'rate': 4.5,
      'fav': false,
      'visited': false,
      'savedDate': null,
    },
    {
      'name': 'Pursat',
      'image': 'assets/Pursat.jpg',
      'rate': 4.2,
      'fav': false,
      'visited': false,
      'savedDate': null,
    },
    {
      'name': 'Prey Veng',
      'image': 'assets/Preyveng.png',
      'rate': 4.1,
      'fav': false,
      'visited': false,
      'savedDate': null,
    },
    {
      'name': 'Ratanakiri',
      'image': 'assets/RatanakKiri.png',
      'rate': 4.7,
      'fav': false,
      'visited': false,
      'savedDate': null,
    },
    {
      'name': 'Stung Treng',
      'image': 'assets/StungTreng.png',
      'rate': 4.4,
      'fav': false,
      'visited': false,
      'savedDate': null,
    },
    {
      'name': 'Svay Rieng',
      'image': 'assets/SvayReang.png',
      'rate': 4.0,
      'fav': false,
      'visited': false,
      'savedDate': null,
    },
    {
      'name': 'Takéo',
      'image': 'assets/Takeo.png',
      'rate': 4.3,
      'fav': false,
      'visited': false,
      'savedDate': null,
    },
    {
      'name': 'Oddar Meanchey',
      'image': 'assets/OddarMeanchey.png',
      'rate': 4.2,
      'fav': false,
      'visited': false,
      'savedDate': null,
    },
  ];

  @override
  void initState() {
    super.initState();
    filteredDestinations = destinations;
    searchController.addListener(_filterDestinations);

    _toggleController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _navController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    _toggleController.dispose();
    _navController.dispose();
    super.dispose();
  }

  void _filterDestinations() {
    setState(() {
      if (searchController.text.isEmpty) {
        filteredDestinations = destinations;
      } else {
        String searchTerm = searchController.text.toLowerCase();
        filteredDestinations = destinations
            .where(
              (destination) =>
                  destination['name'].toLowerCase().contains(searchTerm) ||
                  destination['name'].toLowerCase().startsWith(searchTerm),
            )
            .toList();
      }
    });
  }

  void toggleFav(int i) {
    setState(() {
      final originalIndex = destinations.indexOf(filteredDestinations[i]);
      destinations[originalIndex]['fav'] = !destinations[originalIndex]['fav'];
      filteredDestinations[i]['fav'] = destinations[originalIndex]['fav'];

      if (destinations[originalIndex]['fav']) {
        final now = DateTime.now();
        const List<String> months = [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec',
        ];
        destinations[originalIndex]['savedDate'] =
            '${months[now.month - 1]} ${now.day}, ${now.year}';

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: isDark
                ? const Color(0xFF64B5F6)
                : const Color(0xFFB8860B),
            content: Text(
              '${destinations[originalIndex]['name']} added to favorites!',
              style: const TextStyle(color: Colors.white),
            ),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      } else {
        destinations[originalIndex]['savedDate'] = null;
        destinations[originalIndex]['visited'] = false;
      }
    });
  }

  void navigateToDetail(Map<String, dynamic> destination) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClickCard(
          destination: destination,
          isDarkMode: isDark,
          onFavoriteUpdated: (updatedDestination) {
            final index = destinations.indexWhere(
              (dest) => dest['name'] == updatedDestination['name'],
            );
            if (index != -1) {
              setState(() {
                destinations[index]['fav'] = updatedDestination['fav'];
                destinations[index]['savedDate'] =
                    updatedDestination['savedDate'];
                destinations[index]['visited'] = updatedDestination['visited'];
              });
            }
          },
        ),
      ),
    );
  }

  Color get bgColor => isDark
      ? const Color(0xFF0A0E27)
      : const Color.fromARGB(255, 245, 232, 210);

  Color get textColor => isDark ? Colors.white : const Color(0xFF2C1810);
  Color get cardBg => isDark ? const Color(0xFF1E3A5F) : Colors.white;
  Color get borderColor =>
      isDark ? const Color(0xFF64B5F6) : const Color(0xFFD4A574);

  Color get accentColor =>
      isDark ? const Color(0xFF64B5F6) : const Color(0xFFB8860B);

  Color get buttonColor =>
      isDark ? Colors.white.withOpacity(0.1) : Colors.white;
  Color get iconColor =>
      isDark ? const Color(0xFF64B5F6) : const Color(0xFFD4A574);

  Widget _buildEnhancedToggle() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isDark = !isDark;
        });
        if (isDark) {
          _toggleController.forward();
        } else {
          _toggleController.reverse();
        }
      },
      child: AnimatedBuilder(
        animation: _toggleController,
        builder: (context, child) {
          return Container(
            width: 70,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: isDark
                    ? [const Color(0xFF1E3A5F), const Color(0xFF0A0E27)]
                    : [const Color(0xFFFFD700), const Color(0xFFB8860B)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color:
                      (isDark
                              ? const Color(0xFF64B5F6)
                              : const Color(0xFFFFD700))
                          .withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                if (isDark)
                  Positioned(
                    left: 8,
                    top: 8,
                    child: Icon(
                      Icons.star,
                      size: 6,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                if (isDark)
                  Positioned(
                    left: 16,
                    top: 12,
                    child: Icon(
                      Icons.star,
                      size: 4,
                      color: Colors.white.withOpacity(0.4),
                    ),
                  ),
                if (!isDark) ...[
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Icon(
                      Icons.wb_sunny_outlined,
                      size: 12,
                      color: const Color(0xFFFFF8DC).withOpacity(0.8),
                    ),
                  ),
                  Positioned(
                    right: 12,
                    top: 18,
                    child: Icon(
                      Icons.circle,
                      size: 3,
                      color: const Color(0xFFFFF8DC).withOpacity(0.6),
                    ),
                  ),
                ],
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  left: isDark ? 38 : 3,
                  top: 3,
                  child: Container(
                    width: 29,
                    height: 29,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      isDark ? Icons.nightlight_round : Icons.wb_sunny,
                      size: 18,
                      color: isDark
                          ? const Color(0xFF1E3A5F)
                          : const Color(0xFFFFB300),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCreativeNavItem(IconData icon, String label, int index) {
    final isSelected = _currentPageIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentPageIndex = index;
          _navController.forward(from: 0);
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 20 : 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [borderColor, borderColor.withOpacity(0.7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: borderColor.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  icon,
                  color: isSelected ? Colors.white : textColor.withOpacity(0.5),
                  size: isSelected ? 26 : 24,
                ),
                if (index == 2 && _getFavoriteDestinations().isNotEmpty)
                  Positioned(
                    right: -6,
                    top: -6,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE91E63),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      child: Text(
                        '${_getFavoriteDestinations().length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getFavoriteDestinations() {
    return destinations.where((dest) => dest['fav'] == true).toList();
  }

  Widget _buildHomePage() {
    return Column(
      children: [
        const SizedBox(height: 18),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Discover",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 29,
                      color: textColor,
                      letterSpacing: -0.5,
                    ),
                  ),
                  Text(
                    "Let's Explore with us!! 🌟",
                    style: TextStyle(
                      fontSize: 13,
                      color: textColor.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              _buildEnhancedToggle(),
            ],
          ),
        ),

        const SizedBox(height: 16),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            height: 52,
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF1A1F3A)
                  : const Color.fromARGB(255, 244, 238, 227),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: borderColor.withOpacity(0.5),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: borderColor.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(Icons.search_rounded, color: borderColor, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: searchController,
                    style: TextStyle(color: textColor, fontSize: 15),
                    decoration: InputDecoration(
                      hintText: "Search places...",
                      hintStyle: TextStyle(
                        color: textColor.withOpacity(.5),
                        fontSize: 15,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if (searchController.text.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      searchController.clear();
                    },
                    child: Icon(
                      Icons.close_rounded,
                      color: textColor.withOpacity(0.5),
                      size: 20,
                    ),
                  ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Cambodia Provinces",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: borderColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: borderColor.withOpacity(0.5),
                    width: 1.5,
                  ),
                ),
                child: Text(
                  "${filteredDestinations.length} places",
                  style: TextStyle(
                    fontSize: 13,
                    color: borderColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        Expanded(
          child: filteredDestinations.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.travel_explore,
                        size: 64,
                        color: textColor.withOpacity(0.3),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "No provinces found",
                        style: TextStyle(
                          color: textColor.withOpacity(0.6),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filteredDestinations.length,
                  itemBuilder: (context, i) {
                    final item = filteredDestinations[i];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: GestureDetector(
                        onTap: () => navigateToDetail(item),
                        child: Container(
                          height: 220,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: borderColor.withOpacity(.2),
                                blurRadius: 16,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Stack(
                              children: [
                                Image.asset(
                                  item['image'],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            borderColor.withOpacity(0.3),
                                            borderColor.withOpacity(0.1),
                                          ],
                                        ),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.landscape,
                                          size: 64,
                                          color: borderColor.withOpacity(0.5),
                                        ),
                                      ),
                                    );
                                  },
                                ),

                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(.7),
                                      ],
                                    ),
                                  ),
                                ),

                                Positioned(
                                  bottom: 16,
                                  left: 16,
                                  right: 16,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item['name'],
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: -0.5,
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on_rounded,
                                                  color: Colors.white
                                                      .withOpacity(0.8),
                                                  size: 16,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  "Cambodia",
                                                  style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.8),
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.4),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color: Colors.white.withOpacity(
                                              0.2,
                                            ),
                                            width: 1,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.star_rounded,
                                              color: Color(0xFFFFB300),
                                              size: 18,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              "${item['rate']}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Positioned(
                                  top: 14,
                                  right: 14,
                                  child: GestureDetector(
                                    onTap: () => toggleFav(i),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.95),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.2,
                                            ),
                                            blurRadius: 10,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        item['fav']
                                            ? Icons.favorite_rounded
                                            : Icons.favorite_border_rounded,
                                        color: item['fav']
                                            ? const Color(0xFFE91E63)
                                            : Colors.grey[600],
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: IndexedStack(
          index: _currentPageIndex,
          children: [
            _buildHomePage(),
            // ✅ FIXED: Added destinations and callback parameters
            ExplorePage(
              isDark: isDark,
              onNavItemTap: (index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              destinations: destinations, // ✅ ADDED
              onPlaceFavoriteUpdated: (placeName, isFav, savedDate, isVisited) {
                // ✅ ADDED
                // This callback updates when favorites are toggled in Popular places
                setState(() {
                  // The callback is already handled by ExplorePage
                  // We just need to trigger a rebuild
                });
              },
            ),
            FavoritePage(
              favoriteDestinations: _getFavoriteDestinations(),
              onToggleFavorite: (index) {
                final favDest = _getFavoriteDestinations()[index];
                final originalIndex = destinations.indexWhere(
                  (dest) => dest['name'] == favDest['name'],
                );
                if (originalIndex != -1) {
                  setState(() {
                    destinations[originalIndex]['fav'] =
                        !destinations[originalIndex]['fav'];
                    if (!destinations[originalIndex]['fav']) {
                      destinations[originalIndex]['savedDate'] = null;
                      destinations[originalIndex]['visited'] = false;
                    }
                  });
                }
              },
              onMarkAsVisited: (index) {
                final favDest = _getFavoriteDestinations()[index];
                final originalIndex = destinations.indexWhere(
                  (dest) => dest['name'] == favDest['name'],
                );
                if (originalIndex != -1) {
                  setState(() {
                    destinations[originalIndex]['visited'] =
                        !(destinations[originalIndex]['visited'] ?? false);
                  });
                }
              },
              onDeleteFavorite: (index) {
                final favDest = _getFavoriteDestinations()[index];
                final originalIndex = destinations.indexWhere(
                  (dest) => dest['name'] == favDest['name'],
                );
                if (originalIndex != -1) {
                  setState(() {
                    destinations[originalIndex]['fav'] = false;
                    destinations[originalIndex]['savedDate'] = null;
                    destinations[originalIndex]['visited'] = false;
                  });
                }
              },
              onSetDate: (index, selectedDate) {
                final favDest = _getFavoriteDestinations()[index];
                final originalIndex = destinations.indexWhere(
                  (dest) => dest['name'] == favDest['name'],
                );
                if (originalIndex != -1) {
                  const List<String> months = [
                    'Jan',
                    'Feb',
                    'Mar',
                    'Apr',
                    'May',
                    'Jun',
                    'Jul',
                    'Aug',
                    'Sep',
                    'Oct',
                    'Nov',
                    'Dec',
                  ];
                  setState(() {
                    destinations[originalIndex]['savedDate'] =
                        '${months[selectedDate.month - 1]} ${selectedDate.day}, ${selectedDate.year}';
                  });
                }
              },
              isDark: isDark,
              onNavItemTap: (index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
            ),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1A1F3A) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: borderColor.withOpacity(0.3), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: borderColor.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildCreativeNavItem(Icons.home_rounded, "Home", 0),
            _buildCreativeNavItem(Icons.explore_rounded, "Explore", 1),
            _buildCreativeNavItem(Icons.favorite_rounded, "Favorite", 2),
          ],
        ),
      ),
    );
  }
}
