import 'package:flutter/material.dart';
import 'Popular.dart';

class ExplorePage extends StatefulWidget {
  final bool isDark;
  final Function(int) onNavItemTap;
  final List<Map<String, dynamic>> destinations;
  final Function(String, bool, String?, bool) onPlaceFavoriteUpdated;

  const ExplorePage({
    super.key,
    required this.isDark,
    required this.onNavItemTap,
    required this.destinations,
    required this.onPlaceFavoriteUpdated,
  });

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  late bool isDark;
  String selectedCategory = 'All';
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isDark = widget.isDark;
  }

  @override
  void didUpdateWidget(ExplorePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isDark != widget.isDark) {
      setState(() {
        isDark = widget.isDark;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Categories with better icons
  final List<Map<String, dynamic>> categories = [
    {
      'name': 'All',
      'icon': Icons.all_inclusive_rounded,
      'color': Colors.deepPurple,
      'count': 0,
    },
    {
      'name': 'Temples',
      'icon': Icons.temple_buddhist_rounded,
      'color': Colors.amber,
      'count': 0,
    },
    {
      'name': 'Beaches',
      'icon': Icons.beach_access_rounded,
      'color': Colors.blue,
      'count': 0,
    },
    {
      'name': 'Nature',
      'icon': Icons.forest_rounded,
      'color': Colors.green,
      'count': 0,
    },
    {
      'name': 'Culture',
      'icon': Icons.account_balance_rounded,
      'color': Colors.red,
      'count': 0,
    },
  ];

  // COMPREHENSIVE LIST OF ALL POPULAR PLACES FROM YOUR CLICKCARD DATA
  final List<Map<String, dynamic>> allPopularPlaces = [
    // Phnom Penh - Culture
    {
      'name': 'Royal Palace',
      'province': 'Phnom Penh',
      'image': 'assets/Royal.png',
      'category': 'Culture',
      'description': 'The official residence of the Cambodian King',
      'rating': 4.8,
      'reviews': 8500,
    },
    {
      'name': 'Tuol Sleng Genocide Museum',
      'province': 'Phnom Penh',
      'image': 'assets/Toulsleng.png',
      'category': 'Culture',
      'description': 'Historical museum documenting Khmer Rouge regime',
      'rating': 4.5,
      'reviews': 6200,
    },
    {
      'name': 'National Museum of Cambodia',
      'province': 'Phnom Penh',
      'image': 'assets/National.png',
      'category': 'Culture',
      'description': 'Largest museum of cultural history in Cambodia',
      'rating': 4.6,
      'reviews': 4100,
    },
    {
      'name': 'Wat Phnom',
      'province': 'Phnom Penh',
      'image': 'assets/Wat.png',
      'category': 'Temples',
      'description': 'Buddhist temple on the only hill in Phnom Penh',
      'rating': 4.4,
      'reviews': 3800,
    },
    {
      'name': 'Riverside Walk (Sisowath Quay)',
      'province': 'Phnom Penh',
      'image': 'assets/riverside.png',
      'category': 'Nature',
      'description': 'Scenic riverside promenade along the Mekong River',
      'rating': 4.7,
      'reviews': 5400,
    },

    // Siem Reap - Temples
    {
      'name': 'Angkor Wat',
      'province': 'Siem Reap',
      'image': 'assets/Angkor.png',
      'category': 'Temples',
      'description': 'World\'s largest religious monument',
      'rating': 4.9,
      'reviews': 12500,
    },
    {
      'name': 'Bayon Temple',
      'province': 'Siem Reap',
      'image': 'assets/Bayon.png',
      'category': 'Temples',
      'description': 'Famous for its many smiling stone faces',
      'rating': 4.8,
      'reviews': 9800,
    },
    {
      'name': 'Ta Prohm Temple',
      'province': 'Siem Reap',
      'image': 'assets/Taphrom.png',
      'category': 'Temples',
      'description': 'Jungle temple famous for giant tree roots',
      'rating': 4.7,
      'reviews': 7600,
    },
    {
      'name': 'Pub Street',
      'province': 'Siem Reap',
      'image': 'assets/Pubstreet.png',
      'category': 'Culture',
      'description': 'Vibrant nightlife area with restaurants and bars',
      'rating': 4.5,
      'reviews': 4300,
    },
    {
      'name': 'Beng Mealea Temple',
      'province': 'Siem Reap',
      'image': 'assets/BengMealea.png',
      'category': 'Temples',
      'description': 'Remote jungle temple with dramatic ruins',
      'rating': 4.6,
      'reviews': 2800,
    },

    // Battambang - Culture & Nature
    {
      'name': 'Psar Nat (Central Market)',
      'province': 'Battambang',
      'image': 'assets/PsaNat.png',
      'category': 'Culture',
      'description': 'Historic market building from French colonial era',
      'rating': 4.3,
      'reviews': 2200,
    },
    {
      'name': 'Battambang Museum',
      'province': 'Battambang',
      'image': 'assets/Battam.png',
      'category': 'Culture',
      'description': 'Museum showcasing local history and artifacts',
      'rating': 4.2,
      'reviews': 1800,
    },
    {
      'name': 'Wat Banan Temple',
      'province': 'Battambang',
      'image': 'assets/Watbanan.png',
      'category': 'Temples',
      'description': 'Ancient Angkorian temple on a hill',
      'rating': 4.4,
      'reviews': 2400,
    },
    {
      'name': 'Bamboo Train',
      'province': 'Battambang',
      'image': 'assets/Bambootrain.png',
      'category': 'Culture',
      'description': 'Unique bamboo railway experience',
      'rating': 4.5,
      'reviews': 3200,
    },
    {
      'name': 'Crocodile Farm',
      'province': 'Battambang',
      'image': 'assets/Farmcroco.png',
      'category': 'Nature',
      'description': 'Crocodile breeding and conservation center',
      'rating': 4.1,
      'reviews': 1500,
    },

    // Sihanoukville - Beaches
    {
      'name': 'Koh Rong Samloem',
      'province': 'Sihanoukville',
      'image': 'assets/Kohrong.png',
      'category': 'Beaches',
      'description': 'Pristine island paradise with crystal waters',
      'rating': 4.7,
      'reviews': 5400,
    },
    {
      'name': 'Otres Beach',
      'province': 'Sihanoukville',
      'image': 'assets/Otres.png',
      'category': 'Beaches',
      'description': 'Peaceful beach away from the crowds',
      'rating': 4.6,
      'reviews': 3900,
    },
    {
      'name': 'Kbal Chhay Waterfall',
      'province': 'Sihanoukville',
      'image': 'assets/KbalChay.png',
      'category': 'Nature',
      'description': 'Beautiful cascading waterfall in the jungle',
      'rating': 4.3,
      'reviews': 2100,
    },
    {
      'name': 'Independence Beach',
      'province': 'Sihanoukville',
      'image': 'assets/Independence.png',
      'category': 'Beaches',
      'description': 'Historic beach with calm waters',
      'rating': 4.4,
      'reviews': 2600,
    },

    // Kampot - Nature & Culture
    {
      'name': 'Popokvil Waterfall',
      'province': 'Kampot',
      'image': 'assets/Popokvil.png',
      'category': 'Nature',
      'description': 'Multi-tiered waterfall in Bokor National Park',
      'rating': 4.5,
      'reviews': 2900,
    },
    {
      'name': 'Teuk Chhou Rapids',
      'province': 'Kampot',
      'image': 'assets/TerkChhou.png',
      'category': 'Nature',
      'description': 'Scenic river rapids for swimming',
      'rating': 4.4,
      'reviews': 2300,
    },
    {
      'name': 'Bokor Mountain',
      'province': 'Kampot',
      'image': 'assets/Bokor.jpg',
      'category': 'Nature',
      'description': 'Mountain with panoramic views',
      'rating': 4.6,
      'reviews': 3400,
    },
    {
      'name': 'Veal Pouch Waterfall',
      'province': 'Kampot',
      'image': 'assets/VealPouch.png',
      'category': 'Nature',
      'description': 'Hidden waterfall with clear pools',
      'rating': 4.3,
      'reviews': 1900,
    },
    {
      'name': 'Kampong Trach Cave',
      'province': 'Kampot',
      'image': 'assets/KampongTrach.png',
      'category': 'Nature',
      'description': 'Limestone cave with shrines',
      'rating': 4.2,
      'reviews': 1700,
    },

    // Kep - Beaches
    {
      'name': 'Kep Beach',
      'province': 'Kep',
      'image': 'assets/Kebbeach.png',
      'category': 'Beaches',
      'description': 'Tranquil seaside retreat',
      'rating': 4.4,
      'reviews': 2500,
    },
    {
      'name': 'Crab Market',
      'province': 'Kep',
      'image': 'assets/Crab.png',
      'category': 'Culture',
      'description': 'Fresh seafood market famous for Kep crabs',
      'rating': 4.5,
      'reviews': 3100,
    },
    {
      'name': 'Tmor Rung Waterfall',
      'province': 'Kep',
      'image': 'assets/Tmorrung.png',
      'category': 'Nature',
      'description': 'Beautiful waterfall in Kep National Park',
      'rating': 4.2,
      'reviews': 1600,
    },
    {
      'name': 'Koh Tonsay (Rabbit Island)',
      'province': 'Kep',
      'image': 'assets/KohTonsay.png',
      'category': 'Beaches',
      'description': 'Small island with rustic beach bungalows',
      'rating': 4.3,
      'reviews': 2000,
    },

    // Kampong Cham - Nature & Culture
    {
      'name': 'Tek Cha',
      'province': 'Kampong Cham',
      'image': 'assets/Terkcha.png',
      'category': 'Nature',
      'description': 'Popular local resort and recreation area',
      'rating': 4.2,
      'reviews': 1400,
    },
    {
      'name': 'Hanchey Mountain',
      'province': 'Kampong Cham',
      'image': 'assets/hanchey.png',
      'category': 'Nature',
      'description': 'Scenic mountain with river views',
      'rating': 4.3,
      'reviews': 1800,
    },
    {
      'name': 'Phnom Pros & Phnom Srei',
      'province': 'Kampong Cham',
      'image': 'assets/prossrey.png',
      'category': 'Temples',
      'description': 'Twin hills with cultural significance',
      'rating': 4.1,
      'reviews': 1200,
    },
    {
      'name': 'Koh Pen Beach',
      'province': 'Kampong Cham',
      'image': 'assets/Kohpen.png',
      'category': 'Beaches',
      'description': 'River island beach perfect for relaxation',
      'rating': 4.0,
      'reviews': 1100,
    },
    {
      'name': 'Nokor Bachey Temple',
      'province': 'Kampong Cham',
      'image': 'assets/Nokor.png',
      'category': 'Temples',
      'description': 'Ancient temple with unique architecture',
      'rating': 4.2,
      'reviews': 1300,
    },

    // Kampong Chhnang - Culture & Nature
    {
      'name': 'Floating Village',
      'province': 'Kampong Chhnang',
      'image': 'assets/Floating.png',
      'category': 'Culture',
      'description': 'Traditional floating community on Tonle Sap',
      'rating': 4.4,
      'reviews': 2200,
    },
    {
      'name': 'Pottery Village',
      'province': 'Kampong Chhnang',
      'image': 'assets/Chnnang.png',
      'category': 'Culture',
      'description': 'Traditional Khmer pottery making center',
      'rating': 4.3,
      'reviews': 1900,
    },
    {
      'name': 'Phnom San Touch',
      'province': 'Kampong Chhnang',
      'image': 'assets/Santouch.png',
      'category': 'Nature',
      'description': 'Hill with pagoda and panoramic views',
      'rating': 4.1,
      'reviews': 1500,
    },
    {
      'name': 'Phnom Preah Theat Temple',
      'province': 'Kampong Chhnang',
      'image': 'assets/PreahTheat.png',
      'category': 'Temples',
      'description': 'Ancient temple with historical significance',
      'rating': 4.0,
      'reviews': 1300,
    },
    {
      'name': 'Kong Rei Mountain',
      'province': 'Kampong Chhnang',
      'image': 'assets/Kongrei.png',
      'category': 'Nature',
      'description': 'Scenic mountain for hiking and nature',
      'rating': 4.2,
      'reviews': 1700,
    },

    // Kampong Speu - Nature
    {
      'name': 'Kirirom National Park',
      'province': 'Kampong Speu',
      'image': 'assets/Kirirom.png',
      'category': 'Nature',
      'description': 'Pine forest plateau with cool climate',
      'rating': 4.5,
      'reviews': 2800,
    },
    {
      'name': 'Phnom Aural',
      'province': 'Kampong Speu',
      'image': 'assets/Aural.png',
      'category': 'Nature',
      'description': 'Cambodia\'s highest mountain',
      'rating': 4.4,
      'reviews': 2100,
    },
    {
      'name': 'Chambok Waterfall',
      'province': 'Kampong Speu',
      'image': 'assets/Chambok.png',
      'category': 'Nature',
      'description': 'Beautiful waterfall in natural surroundings',
      'rating': 4.3,
      'reviews': 1800,
    },
    {
      'name': 'Knong Phsar Mountain',
      'province': 'Kampong Speu',
      'image': 'assets/KnongPhsar.png',
      'category': 'Nature',
      'description': 'Mountain with local market and views',
      'rating': 4.1,
      'reviews': 1400,
    },

    // Kampong Thom - Temples
    {
      'name': 'Sambor Prei Kuk',
      'province': 'Kampong Thom',
      'image': 'assets/Sambor.png',
      'category': 'Temples',
      'description': 'UNESCO World Heritage pre-Angkorian temples',
      'rating': 4.6,
      'reviews': 3200,
    },
    {
      'name': 'Prasat Andet',
      'province': 'Kampong Thom',
      'image': 'assets/Prasat.png',
      'category': 'Temples',
      'description': 'Ancient temple ruins',
      'rating': 4.2,
      'reviews': 1600,
    },
    {
      'name': 'Phnom Santuk',
      'province': 'Kampong Thom',
      'image': 'assets/Santuk.png',
      'category': 'Temples',
      'description': 'Sacred mountain with pagoda',
      'rating': 4.3,
      'reviews': 1900,
    },
    {
      'name': 'Stung Sen River',
      'province': 'Kampong Thom',
      'image': 'assets/stungsen.png',
      'category': 'Nature',
      'description': 'Major river for boat trips',
      'rating': 4.1,
      'reviews': 1300,
    },
    {
      'name': 'Prey Pros Lake',
      'province': 'Kampong Thom',
      'image': 'assets/PreyPros.png',
      'category': 'Nature',
      'description': 'Natural lake for relaxation',
      'rating': 4.0,
      'reviews': 1100,
    },

    // Kandal - Culture & Temples
    {
      'name': 'Vihear Sour Pagoda',
      'province': 'Kandal',
      'image': 'assets/vihearsour.png',
      'category': 'Temples',
      'description': 'Historic Buddhist temple',
      'rating': 4.2,
      'reviews': 1700,
    },
    {
      'name': 'Kien Svay Krao',
      'province': 'Kandal',
      'image': 'assets/kiensvay.png',
      'category': 'Nature',
      'description': 'Popular riverside recreation area',
      'rating': 4.3,
      'reviews': 2000,
    },
    {
      'name': 'Oudong Mountain',
      'province': 'Kandal',
      'image': 'assets/oudong.png',
      'category': 'Culture',
      'description': 'Ancient royal capital with stupas',
      'rating': 4.4,
      'reviews': 2400,
    },
    {
      'name': 'Phnom Prasithy',
      'province': 'Kandal',
      'image': 'assets/prasity.png',
      'category': 'Nature',
      'description': 'Hill with religious significance',
      'rating': 4.1,
      'reviews': 1500,
    },
    {
      'name': 'Toul Reachea Pagoda',
      'province': 'Kandal',
      'image': 'assets/reachea.png',
      'category': 'Temples',
      'description': 'Beautiful pagoda complex',
      'rating': 4.2,
      'reviews': 1800,
    },

    // Koh Kong - Nature
    {
      'name': 'Tatai Waterfall',
      'province': 'Koh Kong',
      'image': 'assets/Tatai.png',
      'category': 'Nature',
      'description': 'Majestic waterfall in Cardamom Mountains',
      'rating': 4.6,
      'reviews': 2900,
    },
    {
      'name': 'Peam Krasop Wildlife Sanctuary',
      'province': 'Koh Kong',
      'image': 'assets/PeamKrasop.png',
      'category': 'Nature',
      'description': 'Mangrove forest sanctuary',
      'rating': 4.5,
      'reviews': 2600,
    },
    {
      'name': 'Koh Kong Island',
      'province': 'Koh Kong',
      'image': 'assets/KohkongIsland.png',
      'category': 'Beaches',
      'description': 'Pristine island paradise',
      'rating': 4.7,
      'reviews': 3100,
    },
    {
      'name': 'Cardamom Mountains',
      'province': 'Koh Kong',
      'image': 'assets/Cardamom.png',
      'category': 'Nature',
      'description': 'Largest rainforest in Southeast Asia',
      'rating': 4.8,
      'reviews': 3400,
    },

    // Kratié - Nature
    {
      'name': 'Koh Pdao Community Tour',
      'province': 'Kratié',
      'image': 'assets/KohPdao.png',
      'category': 'Culture',
      'description': 'Community-based eco-tourism experience',
      'rating': 4.4,
      'reviews': 2100,
    },
    {
      'name': 'Koh Trong',
      'province': 'Kratié',
      'image': 'assets/KohTrong.png',
      'category': 'Nature',
      'description': 'River island with scenic views',
      'rating': 4.3,
      'reviews': 1800,
    },
    {
      'name': 'Wat Roka Kandal Temple',
      'province': 'Kratié',
      'image': 'assets/Watroka.png',
      'category': 'Temples',
      'description': 'Ancient wooden temple',
      'rating': 4.2,
      'reviews': 1600,
    },
    {
      'name': 'Phnom Sopor Kaley',
      'province': 'Kratié',
      'image': 'assets/Kaley.png',
      'category': 'Nature',
      'description': 'Hill with religious significance',
      'rating': 4.1,
      'reviews': 1400,
    },
    {
      'name': 'Kampi Dolphin Pool',
      'province': 'Kratié',
      'image': 'assets/Kampi.png',
      'category': 'Nature',
      'description': 'Habitat of rare Irrawaddy dolphins',
      'rating': 4.5,
      'reviews': 2700,
    },

    // Mondulkiri - Nature
    {
      'name': 'Bou Sra Waterfall',
      'province': 'Mondulkiri',
      'image': 'assets/bousra.png',
      'category': 'Nature',
      'description': 'Cambodia\'s largest waterfall',
      'rating': 4.7,
      'reviews': 2900,
    },
    {
      'name': 'Sen Monorom Waterfall',
      'province': 'Mondulkiri',
      'image': 'assets/senMonorom.png',
      'category': 'Nature',
      'description': 'Beautiful waterfall near town',
      'rating': 4.4,
      'reviews': 2100,
    },
    {
      'name': 'Chrey Thom Waterfall',
      'province': 'Mondulkiri',
      'image': 'assets/ChreyThom.png',
      'category': 'Nature',
      'description': 'Peaceful waterfall for relaxation',
      'rating': 4.3,
      'reviews': 1800,
    },
    {
      'name': 'Phnom Andong Sne',
      'province': 'Mondulkiri',
      'image': 'assets/Andong.png',
      'category': 'Nature',
      'description': 'Mountain with ethnic village',
      'rating': 4.2,
      'reviews': 1600,
    },

    // Banteay Meanchey - Temples
    {
      'name': 'Banteay Chhmar',
      'province': 'Banteay Meanchey',
      'image': 'assets/Chmar.png',
      'category': 'Temples',
      'description': 'Massive Angkorian temple complex',
      'rating': 4.5,
      'reviews': 2400,
    },
    {
      'name': 'Banteay Torb Temple',
      'province': 'Banteay Meanchey',
      'image': 'assets/BanteayTorb.png',
      'category': 'Temples',
      'description': 'Ancient brick temple ruins',
      'rating': 4.2,
      'reviews': 1700,
    },
    {
      'name': 'Wat Phnom Toch',
      'province': 'Banteay Meanchey',
      'image': 'assets/WatphnomToch.png',
      'category': 'Temples',
      'description': 'Hilltop pagoda with views',
      'rating': 4.1,
      'reviews': 1500,
    },

    // Tboung Khmum - Temples & Nature
    {
      'name': 'Preah Theat Basrei Temple',
      'province': 'Tboung Khmum',
      'image': 'assets/Phreah.png',
      'category': 'Temples',
      'description': 'Ancient temple with unique architecture',
      'rating': 4.3,
      'reviews': 1900,
    },
    {
      'name': 'Houng Waterfall',
      'province': 'Tboung Khmum',
      'image': 'assets/houng.png',
      'category': 'Nature',
      'description': 'Natural waterfall in forest',
      'rating': 4.2,
      'reviews': 1600,
    },
    {
      'name': 'OBT Training Center',
      'province': 'Tboung Khmum',
      'image': 'assets/obt.png',
      'category': 'Culture',
      'description': 'Organization for Basic Training facility',
      'rating': 4.0,
      'reviews': 1300,
    },

    // Pailin - Nature
    {
      'name': 'Ou Ta Vau Waterfall',
      'province': 'Pailin',
      'image': 'assets/Outavau.png',
      'category': 'Nature',
      'description': 'Beautiful waterfall in forest',
      'rating': 4.4,
      'reviews': 2000,
    },
    {
      'name': 'Ang Jing Chok',
      'province': 'Pailin',
      'image': 'assets/AngJing.png',
      'category': 'Nature',
      'description': 'Natural rock formation',
      'rating': 4.2,
      'reviews': 1700,
    },
    {
      'name': 'Bar Yakha',
      'province': 'Pailin',
      'image': 'assets/Baryak.png',
      'category': 'Culture',
      'description': 'Local market and gathering place',
      'rating': 4.1,
      'reviews': 1400,
    },

    // Preah Vihear - Temples
    {
      'name': 'Preah Vihear Temple',
      'province': 'Preah Vihear',
      'image': 'assets/Phreah.png',
      'category': 'Temples',
      'description': 'UNESCO World Heritage temple on cliff edge',
      'rating': 4.8,
      'reviews': 3100,
    },
    {
      'name': 'Koh Ker Temple',
      'province': 'Preah Vihear',
      'image': 'assets/Kohker.png',
      'category': 'Temples',
      'description': 'Ancient pyramid temple in remote jungle',
      'rating': 4.6,
      'reviews': 2400,
    },
    {
      'name': 'Neak Buos Temple',
      'province': 'Preah Vihear',
      'image': 'assets/NeakBuos.png',
      'category': 'Temples',
      'description': 'Remote temple ruins near Thai border',
      'rating': 4.3,
      'reviews': 1800,
    },

    // Pursat - Nature
    {
      'name': 'Ou Da',
      'province': 'Pursat',
      'image': 'assets/ouda.png',
      'category': 'Nature',
      'description': 'Natural rock formation and caves',
      'rating': 4.3,
      'reviews': 1900,
    },
    {
      'name': 'Thmor Da Waterfall',
      'province': 'Pursat',
      'image': 'assets/thmorda.png',
      'category': 'Nature',
      'description': 'Beautiful waterfall for relaxation',
      'rating': 4.2,
      'reviews': 1600,
    },
    {
      'name': 'Phnom 1500',
      'province': 'Pursat',
      'image': 'assets/phnom1500.png',
      'category': 'Nature',
      'description': 'Mountain with cool climate',
      'rating': 4.4,
      'reviews': 2100,
    },
    {
      'name': 'Labak Komrounh',
      'province': 'Pursat',
      'image': 'assets/labak.png',
      'category': 'Nature',
      'description': 'Scenic natural area',
      'rating': 4.1,
      'reviews': 1400,
    },
    {
      'name': 'Chrork Laeang Waterfall',
      'province': 'Pursat',
      'image': 'assets/chrork.png',
      'category': 'Nature',
      'description': 'Multi-tiered waterfall',
      'rating': 4.3,
      'reviews': 1800,
    },

    // Prey Veng - Temples
    {
      'name': 'Ba Phnom Temple',
      'province': 'Prey Veng',
      'image': 'assets/Baphnom.png',
      'category': 'Temples',
      'description': 'Ancient temple on sacred hill',
      'rating': 4.2,
      'reviews': 1700,
    },
    {
      'name': 'Nokor Phnom',
      'province': 'Prey Veng',
      'image': 'assets/Nokor.png',
      'category': 'Temples',
      'description': 'Historical site with pagoda',
      'rating': 4.1,
      'reviews': 1500,
    },
    {
      'name': 'Vihear Chan Temple',
      'province': 'Prey Veng',
      'image': 'assets/VihearChan.png',
      'category': 'Temples',
      'description': 'Beautiful Buddhist temple',
      'rating': 4.0,
      'reviews': 1300,
    },
    {
      'name': 'Toul Baray Andet',
      'province': 'Prey Veng',
      'image': 'assets/ToulBaray.png',
      'category': 'Culture',
      'description': 'Ancient reservoir ruins',
      'rating': 3.9,
      'reviews': 1200,
    },

    // Ratanakiri - Nature
    {
      'name': 'Yeak Loam Lake',
      'province': 'Ratanakiri',
      'image': 'assets/Yeaklaom.png',
      'category': 'Nature',
      'description': 'Volcanic crater lake perfect for swimming',
      'rating': 4.7,
      'reviews': 2800,
    },
    {
      'name': 'Cha Ong Waterfall',
      'province': 'Ratanakiri',
      'image': 'assets/Chanong.png',
      'category': 'Nature',
      'description': 'Beautiful waterfall in jungle',
      'rating': 4.5,
      'reviews': 2300,
    },
    {
      'name': 'Katieng Waterfall',
      'province': 'Ratanakiri',
      'image': 'assets/Katieng.png',
      'category': 'Nature',
      'description': 'Scenic waterfall for nature lovers',
      'rating': 4.4,
      'reviews': 2000,
    },
    {
      'name': 'Kiri WongKut Lake',
      'province': 'Ratanakiri',
      'image': 'assets/wongkut.png',
      'category': 'Nature',
      'description': 'Natural lake surrounded by forest',
      'rating': 4.3,
      'reviews': 1800,
    },
    {
      'name': 'Virak Chey Park',
      'province': 'Ratanakiri',
      'image': 'assets/virakchey.png',
      'category': 'Nature',
      'description': 'National park with diverse wildlife',
      'rating': 4.5,
      'reviews': 2400,
    },

    // Stung Treng - Nature
    {
      'name': 'Preah Nimith Waterfall',
      'province': 'Stung Treng',
      'image': 'assets/Nimith.png',
      'category': 'Nature',
      'description': 'Beautiful waterfall on Mekong tributary',
      'rating': 4.4,
      'reviews': 2100,
    },
    {
      'name': 'La Ang Phnom Prak',
      'province': 'Stung Treng',
      'image': 'assets/LaAng.png',
      'category': 'Nature',
      'description': 'Natural rock formation',
      'rating': 4.2,
      'reviews': 1700,
    },
    {
      'name': 'Oresey Kondal Resort',
      'province': 'Stung Treng',
      'image': 'assets/Oresey.png',
      'category': 'Nature',
      'description': 'Riverside resort for relaxation',
      'rating': 4.3,
      'reviews': 1900,
    },
    {
      'name': 'Koh Ksach Resort',
      'province': 'Stung Treng',
      'image': 'assets/Kohksach.png',
      'category': 'Nature',
      'description': 'Island resort on Mekong River',
      'rating': 4.1,
      'reviews': 1500,
    },

    // Svay Rieng - Temples
    {
      'name': 'Bassac Temple',
      'province': 'Svay Rieng',
      'image': 'assets/Bassac.png',
      'category': 'Temples',
      'description': 'Ancient temple with unique style',
      'rating': 4.2,
      'reviews': 1600,
    },
    {
      'name': 'Ji Hor Temple',
      'province': 'Svay Rieng',
      'image': 'assets/Jihor.png',
      'category': 'Temples',
      'description': 'Historic Buddhist temple',
      'rating': 4.1,
      'reviews': 1400,
    },
    {
      'name': 'Korky Forest',
      'province': 'Svay Rieng',
      'image': 'assets/Korky.png',
      'category': 'Nature',
      'description': 'Natural forest area',
      'rating': 4.0,
      'reviews': 1200,
    },
    {
      'name': 'Tek Vil',
      'province': 'Svay Rieng',
      'image': 'assets/TekVil.png',
      'category': 'Nature',
      'description': 'Scenic natural area',
      'rating': 3.9,
      'reviews': 1100,
    },

    // Takéo - Temples & Culture
    {
      'name': 'Phnom Chita Pech',
      'province': 'Takéo',
      'image': 'assets/chitapech.png',
      'category': 'Temples',
      'description': 'Hill with religious significance',
      'rating': 4.2,
      'reviews': 1700,
    },
    {
      'name': 'Angkor Borei',
      'province': 'Takéo',
      'image': 'assets/borei.png',
      'category': 'Culture',
      'description': 'Ancient capital of Funan kingdom',
      'rating': 4.4,
      'reviews': 2200,
    },
    {
      'name': 'Phnom Tamao Zoo',
      'province': 'Takéo',
      'image': 'assets/tamaozoo.png',
      'category': 'Nature',
      'description': 'Wildlife rescue center and zoo',
      'rating': 4.5,
      'reviews': 2500,
    },
    {
      'name': 'Phnom Chisor',
      'province': 'Takéo',
      'image': 'assets/chisor.png',
      'category': 'Temples',
      'description': 'Hilltop temple with panoramic views',
      'rating': 4.3,
      'reviews': 2000,
    },
    {
      'name': 'Phnom Bayong',
      'province': 'Takéo',
      'image': 'assets/bayoung.png',
      'category': 'Temples',
      'description': 'Ancient temple ruins',
      'rating': 4.1,
      'reviews': 1500,
    },

    // Oddar Meanchey - Temples
    {
      'name': 'Ta Krabei Temple',
      'province': 'Oddar Meanchey',
      'image': 'assets/Krabei.png',
      'category': 'Temples',
      'description': 'Ancient temple ruins',
      'rating': 4.2,
      'reviews': 1600,
    },
    {
      'name': 'Ta Moan Thom Temple',
      'province': 'Oddar Meanchey',
      'image': 'assets/MoanThom.png',
      'category': 'Temples',
      'description': 'Remote temple complex near border',
      'rating': 4.4,
      'reviews': 2100,
    },
    {
      'name': 'Ta Moan Toch Temple',
      'province': 'Oddar Meanchey',
      'image': 'assets/Tamaon.png',
      'category': 'Temples',
      'description': 'Smaller temple near Ta Moan Thom',
      'rating': 4.1,
      'reviews': 1400,
    },
    {
      'name': 'Dey Rolous Thom Resort',
      'province': 'Oddar Meanchey',
      'image': 'assets/DeyRolous.png',
      'category': 'Nature',
      'description': 'Local resort area',
      'rating': 4.0,
      'reviews': 1200,
    },
    {
      'name': 'Champei Waterfall',
      'province': 'Oddar Meanchey',
      'image': 'assets/Champei.png',
      'category': 'Nature',
      'description': 'Natural waterfall in forest',
      'rating': 4.3,
      'reviews': 1800,
    },
  ];

  // Colors
  Color get bgColor => isDark
      ? const Color(0xFF0A0E27)
      : const Color.fromARGB(255, 245, 232, 210);

  Color get textColor => isDark ? Colors.white : const Color(0xFF2C1810);
  Color get cardBg => isDark ? const Color(0xFF1E3A5F) : Colors.white;
  Color get borderColor =>
      isDark ? const Color(0xFF64B5F6) : const Color(0xFFD4A574);
  Color get accentColor =>
      isDark ? const Color(0xFF64B5F6) : const Color(0xFFB8860B);
  Color get surfaceColor =>
      isDark ? const Color.fromARGB(255, 31, 53, 71) : const Color(0xFFE8EAF6);

  List<Map<String, dynamic>> getFilteredDestinations() {
    List<Map<String, dynamic>> results = allPopularPlaces;

    // Filter by category
    if (selectedCategory != 'All') {
      results = results
          .where((place) => place['category'] == selectedCategory)
          .toList();
    }

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      final query = searchQuery.toLowerCase();
      results = results
          .where(
            (place) =>
                place['name'].toLowerCase().contains(query) ||
                place['province'].toLowerCase().contains(query) ||
                place['category'].toLowerCase().contains(query),
          )
          .toList();
    }

    return results;
  }

  void navigateToDetail(Map<String, dynamic> place) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => PopularPage(
          place: place,
          provinceName: place['province'],
          isDarkMode: isDark,
          onFavoriteUpdated: (updatedPlace) {
            final index = allPopularPlaces.indexWhere(
              (p) => p['name'] == updatedPlace['name'],
            );
            if (index != -1) {
              setState(() {
                allPopularPlaces[index]['fav'] = updatedPlace['fav'];
                allPopularPlaces[index]['savedDate'] =
                    updatedPlace['savedDate'];
                allPopularPlaces[index]['visited'] = updatedPlace['visited'];
              });

              widget.onPlaceFavoriteUpdated(
                updatedPlace['name'],
                updatedPlace['fav'] ?? false,
                updatedPlace['savedDate'],
                updatedPlace['visited'] ?? false,
              );
            }
          },
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 0.5);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  Map<String, int> getCategoryCounts() {
    final counts = <String, int>{};
    for (var place in allPopularPlaces) {
      final category = place['category'];
      counts[category] = (counts[category] ?? 0) + 1;
    }
    counts['All'] = allPopularPlaces.length;
    return counts;
  }

  @override
  Widget build(BuildContext context) {
    final categoryCounts = getCategoryCounts();
    final filteredDestinations = getFilteredDestinations();
    final isSearching = searchQuery.isNotEmpty;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER - REMOVED BACK BUTTON
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Explore Cambodia",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 28,
                      color: textColor,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Discover ${allPopularPlaces.length} amazing places across 25 provinces",
                    style: TextStyle(
                      fontSize: 13,
                      color: textColor.withOpacity(0.7),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),

            // SEARCH BAR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: borderColor.withOpacity(0.2),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: borderColor.withOpacity(0.1),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    Icon(Icons.search_rounded, color: borderColor, size: 22),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                          });
                        },
                        style: TextStyle(
                          color: textColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          hintText: "Search places...",
                          hintStyle: TextStyle(
                            color: textColor.withOpacity(0.4),
                            fontSize: 15,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    if (searchQuery.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: GestureDetector(
                          onTap: () {
                            _searchController.clear();
                            setState(() {
                              searchQuery = '';
                            });
                          },
                          child: Icon(
                            Icons.close_rounded,
                            color: textColor.withOpacity(0.5),
                            size: 20,
                          ),
                        ),
                      ),
                    const SizedBox(width: 16),
                  ],
                ),
              ),
            ),

            // CATEGORIES
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Categories",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 48,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        final isSelected = selectedCategory == category['name'];
                        final count = categoryCounts[category['name']] ?? 0;

                        return Padding(
                          padding: EdgeInsets.only(
                            right: index < categories.length - 1 ? 10 : 0,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCategory = category['name'];
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeInOut,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected ? accentColor : surfaceColor,
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: isSelected
                                      ? accentColor
                                      : borderColor.withOpacity(0.2),
                                  width: isSelected ? 0 : 1.5,
                                ),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: accentColor.withOpacity(0.3),
                                          blurRadius: 8,
                                          offset: const Offset(0, 3),
                                        ),
                                      ]
                                    : null,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    category['icon'],
                                    size: 18,
                                    color: isSelected
                                        ? Colors.white
                                        : category['color'],
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    category['name'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: isSelected
                                          ? Colors.white
                                          : textColor.withOpacity(0.9),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? Colors.white.withOpacity(0.2)
                                          : borderColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      '$count',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: isSelected
                                            ? Colors.white
                                            : textColor.withOpacity(0.7),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // RESULTS HEADER
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isSearching
                            ? 'Search Results'
                            : selectedCategory == 'All'
                            ? 'All Destinations'
                            : selectedCategory,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${filteredDestinations.length} places found',
                        style: TextStyle(
                          fontSize: 13,
                          color: textColor.withOpacity(0.6),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  if (isSearching || selectedCategory != 'All')
                    TextButton(
                      onPressed: () {
                        setState(() {
                          selectedCategory = 'All';
                          searchQuery = '';
                          _searchController.clear();
                        });
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Clear',
                        style: TextStyle(
                          color: accentColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // DESTINATIONS GRID - FIXED SCROLLING
            Expanded(
              child: filteredDestinations.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.travel_explore_rounded,
                              size: 80,
                              color: textColor.withOpacity(0.2),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              isSearching
                                  ? 'No matches found for "$searchQuery"'
                                  : 'No destinations found',
                              style: TextStyle(
                                color: textColor.withOpacity(0.6),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              isSearching
                                  ? 'Try a different search term'
                                  : 'Select a different category',
                              style: TextStyle(
                                color: textColor.withOpacity(0.4),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.72,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                      itemCount: filteredDestinations.length,
                      itemBuilder: (context, index) {
                        final place = filteredDestinations[index];
                        final categoryColor = categories.firstWhere(
                          (cat) => cat['name'] == place['category'],
                          orElse: () => categories[0],
                        )['color'];

                        return GestureDetector(
                          onTap: () => navigateToDetail(place),
                          child: Hero(
                            tag: 'place_${place['name']}',
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: cardBg,
                                boxShadow: [
                                  BoxShadow(
                                    color: borderColor.withOpacity(0.08),
                                    blurRadius: 16,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Stack(
                                  children: [
                                    // Image
                                    Image.asset(
                                      place['image'],
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    surfaceColor,
                                                    surfaceColor.withOpacity(
                                                      0.5,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              child: Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.place_rounded,
                                                      size: 40,
                                                      color: textColor
                                                          .withOpacity(0.3),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    Text(
                                                      place['name'],
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: textColor
                                                            .withOpacity(0.5),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      maxLines: 2,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                    ),

                                    // Gradient overlay
                                    Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.transparent,
                                            Colors.black.withOpacity(0.7),
                                          ],
                                        ),
                                      ),
                                    ),

                                    // Category badge
                                    Positioned(
                                      top: 12,
                                      left: 12,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: categoryColor.withOpacity(0.9),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.2,
                                              ),
                                              blurRadius: 4,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          place['category'],
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 0.3,
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Rating badge
                                    Positioned(
                                      top: 12,
                                      right: 12,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.7),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(
                                              Icons.star_rounded,
                                              color: Colors.amber,
                                              size: 12,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              '${place['rating'] ?? '4.0'}',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    // Content
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.transparent,
                                              Colors.black.withOpacity(0.9),
                                            ],
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              place['name'],
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                height: 1.2,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 4),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on_outlined,
                                                  size: 12,
                                                  color: Colors.white
                                                      .withOpacity(0.8),
                                                ),
                                                const SizedBox(width: 4),
                                                Expanded(
                                                  child: Text(
                                                    place['province'],
                                                    style: TextStyle(
                                                      color: Colors.white
                                                          .withOpacity(0.8),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              place['description'],
                                              style: TextStyle(
                                                color: Colors.white.withOpacity(
                                                  0.7,
                                                ),
                                                fontSize: 10,
                                                height: 1.2,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    // Click overlay
                                    Positioned.fill(
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () => navigateToDetail(place),
                                          splashColor: accentColor.withOpacity(
                                            0.2,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            20,
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
        ),
      ),
    );
  }
}
