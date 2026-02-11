import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  final List<Map<String, dynamic>> favoriteDestinations;
  final Function(int) onToggleFavorite;
  final Function(int) onMarkAsVisited;
  final Function(int) onDeleteFavorite;
  final Function(int, DateTime) onSetDate;
  final bool isDark;
  final Function(int) onNavItemTap;

  const FavoritePage({
    super.key,
    required this.favoriteDestinations,
    required this.onToggleFavorite,
    required this.onMarkAsVisited,
    required this.onDeleteFavorite,
    required this.onSetDate,
    required this.isDark,
    required this.onNavItemTap,
  });

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  int _selectedFilter = 0;
  final List<String> _filterOptions = ['All', 'Visited', 'Not Visited'];
  List<Map<String, dynamic>> _filteredFavorites = [];

  @override
  void initState() {
    super.initState();
    _filteredFavorites = widget.favoriteDestinations;
  }

  @override
  void didUpdateWidget(FavoritePage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.favoriteDestinations.length !=
            oldWidget.favoriteDestinations.length ||
        !_areListsEqual(
          widget.favoriteDestinations,
          oldWidget.favoriteDestinations,
        )) {
      if (_selectedFilter == 0) {
        _filteredFavorites = widget.favoriteDestinations;
      } else if (_selectedFilter == 1) {
        _filteredFavorites = widget.favoriteDestinations
            .where((dest) => dest['visited'] == true)
            .toList();
      } else if (_selectedFilter == 2) {
        _filteredFavorites = widget.favoriteDestinations
            .where((dest) => dest['visited'] != true)
            .toList();
      }

      if (mounted) {
        setState(() {});
      }
    }
  }

  bool _areListsEqual(
    List<Map<String, dynamic>> list1,
    List<Map<String, dynamic>> list2,
  ) {
    if (list1.length != list2.length) return false;

    for (int i = 0; i < list1.length; i++) {
      if (list1[i]['name'] != list2[i]['name'] ||
          list1[i]['fav'] != list2[i]['fav'] ||
          list1[i]['visited'] != list2[i]['visited'] ||
          list1[i]['savedDate'] != list2[i]['savedDate']) {
        return false;
      }
    }

    return true;
  }

  void _applyFilter(int index) {
    setState(() {
      _selectedFilter = index;

      if (index == 0) {
        _filteredFavorites = widget.favoriteDestinations;
      } else if (index == 1) {
        _filteredFavorites = widget.favoriteDestinations
            .where((dest) => dest['visited'] == true)
            .toList();
      } else if (index == 2) {
        _filteredFavorites = widget.favoriteDestinations
            .where((dest) => dest['visited'] != true)
            .toList();
      }
    });
  }

  String _formatDate(DateTime date) {
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
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  Future<void> _showDatePicker(int index) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: widget.isDark
              ? ThemeData.dark().copyWith(
                  colorScheme: ColorScheme.dark(
                    primary: accentColor,
                    onPrimary: Colors.white,
                  ),
                )
              : ThemeData.light().copyWith(
                  colorScheme: ColorScheme.light(
                    primary: accentColor,
                    onPrimary: Colors.white,
                  ),
                ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      widget.onSetDate(index, picked);
      if (mounted) {
        setState(() {});
      }
    }
  }

  void _confirmDelete(int index) {
    final destinationName = _filteredFavorites[index]['name'];

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(24),
        child: Container(
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header with icon
              Container(
                padding: const EdgeInsets.only(top: 32, bottom: 20),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Background circle
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFE53935).withOpacity(0.1),
                      ),
                    ),
                    // Icon
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFE53935).withOpacity(0.2),
                      ),
                      child: Icon(
                        Icons.favorite_border_rounded,
                        size: 28,
                        color: const Color(0xFFE53935),
                      ),
                    ),
                  ],
                ),
              ),

              // Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Remove from Favorites?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    height: 1.3,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Subtitle with destination name
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  '$destinationName will be removed from\nyour favorites list.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: textColor.withOpacity(0.6),
                    height: 1.5,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Divider
              Container(
                height: 1,
                margin: const EdgeInsets.symmetric(horizontal: 24),
                color: textColor.withOpacity(0.1),
              ),

              // Action Buttons
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    // Cancel Button
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: textColor.withOpacity(0.7),
                            side: BorderSide(
                              color: textColor.withOpacity(0.2),
                              width: 1,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Remove Button
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            widget.onDeleteFavorite(index);
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE53935),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                            shadowColor: Colors.transparent,
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.delete_outline_rounded, size: 20),
                              SizedBox(width: 6),
                              Text(
                                'Remove',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Theme colors
  Color get bgColor => widget.isDark
      ? const Color(0xFF0A0E27)
      : const Color.fromARGB(255, 245, 232, 210);

  Color get textColor => widget.isDark ? Colors.white : const Color(0xFF2C1810);
  Color get cardBg => widget.isDark ? const Color(0xFF1E3A5F) : Colors.white;
  Color get borderColor =>
      widget.isDark ? const Color(0xFF64B5F6) : const Color(0xFFD4A574);

  Color get accentColor =>
      widget.isDark ? const Color(0xFF64B5F6) : const Color(0xFFB8860B);

  Color get visitedColor =>
      widget.isDark ? const Color(0xFF4CAF50) : const Color(0xFF388E3C);

  Color get unvisitedColor =>
      widget.isDark ? const Color(0xFFFF9800) : const Color(0xFFF57C00);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: null,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER - REMOVED BACK BUTTON
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Heavenly",
                            style: TextStyle(
                              fontSize: 29,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                              letterSpacing: -0.5,
                            ),
                          ),
                          Text(
                            "Your saved destinations 🏅",
                            style: TextStyle(
                              fontSize: 12,
                              color: textColor.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      // Favorite count badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [accentColor, accentColor.withOpacity(0.7)],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: accentColor.withOpacity(0.3),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.favorite_rounded,
                              color: Colors.white,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${widget.favoriteDestinations.length}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Filter Chips
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _filterOptions.asMap().entries.map((entry) {
                  int index = entry.key;
                  String label = entry.value;
                  bool isSelected = _selectedFilter == index;

                  return Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: GestureDetector(
                      onTap: () => _applyFilter(index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        constraints: const BoxConstraints(minWidth: 80),
                        decoration: BoxDecoration(
                          gradient: isSelected
                              ? LinearGradient(
                                  colors: [
                                    accentColor,
                                    accentColor.withOpacity(0.7),
                                  ],
                                )
                              : null,
                          color: isSelected
                              ? null
                              : widget.isDark
                              ? const Color(0xFF1A1F3A)
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? accentColor
                                : borderColor.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          label,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : textColor.withOpacity(0.7),
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 16),

            // Favorites List
            Expanded(
              child: _filteredFavorites.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _filteredFavorites.length,
                      itemBuilder: (context, index) {
                        final destination = _filteredFavorites[index];
                        bool isVisited = destination['visited'] == true;

                        return _buildFavoriteCard(
                          destination,
                          index,
                          isVisited,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteCard(
    Map<String, dynamic> destination,
    int index,
    bool isVisited,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: borderColor.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: cardBg,
            border: Border.all(
              color: isVisited
                  ? visitedColor.withOpacity(0.2)
                  : borderColor.withOpacity(0.2),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left side: Small Image
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      destination['image'],
                      fit: BoxFit.cover,
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
                          child: Icon(
                            Icons.landscape,
                            size: 32,
                            color: borderColor.withOpacity(0.5),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // Middle: Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name
                      Text(
                        destination['name'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 4),

                      // Rating and Location
                      Row(
                        children: [
                          // Rating
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Tooltip(
                              message: 'Rating: ${destination['rate']}',
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star_rounded,
                                    color: const Color(0xFFFFB300),
                                    size: 14,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${destination['rate']}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: textColor.withOpacity(0.8),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(width: 12),

                          // Location
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Tooltip(
                              message: 'Location: Cambodia',
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on_rounded,
                                    size: 12,
                                    color: textColor.withOpacity(0.6),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Cambodia',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: textColor.withOpacity(0.7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      // Date
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Tooltip(
                          message: 'Click to set/change visit date',
                          child: GestureDetector(
                            onTap: () => _showDatePicker(index),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: widget.isDark
                                    ? const Color(0xFF1A1F3A).withOpacity(0.5)
                                    : const Color.fromARGB(255, 244, 238, 227),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: borderColor.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.calendar_today_rounded,
                                    size: 12,
                                    color: accentColor,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    destination['savedDate'] ?? 'Set Date',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: destination['savedDate'] != null
                                          ? textColor.withOpacity(0.8)
                                          : accentColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                // Right side: Action buttons
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Visited/Planned button
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Tooltip(
                        message: isVisited
                            ? 'Mark as not visited'
                            : 'Mark as visited',
                        child: GestureDetector(
                          onTap: () {
                            widget.onMarkAsVisited(index);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isVisited ? visitedColor : unvisitedColor,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      (isVisited
                                              ? visitedColor
                                              : unvisitedColor)
                                          .withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  isVisited
                                      ? Icons.check_circle_rounded
                                      : Icons.schedule_rounded,
                                  color: Colors.white,
                                  size: 14,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  isVisited ? 'Visited' : 'Planned',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Delete button
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Tooltip(
                        message: 'Remove from favorites',
                        child: GestureDetector(
                          onTap: () => _confirmDelete(index),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE53935),
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFFE53935,
                                  ).withOpacity(0.3),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.delete_outline_rounded,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Delete',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: borderColor.withOpacity(0.1),
            ),
            child: Icon(
              Icons.favorite_border_rounded,
              size: 64,
              color: borderColor.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "No favorites yet",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Text(
              "Start exploring and tap the heart icon to save your favorite destinations",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: textColor.withOpacity(0.6),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
