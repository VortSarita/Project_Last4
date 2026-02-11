import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Popular.dart';

class ClickCard extends StatefulWidget {
  final Map<String, dynamic> destination;
  final bool isDarkMode;
  final Function(Map<String, dynamic>)?
  onFavoriteUpdated; // NEW: Add this callback

  const ClickCard({
    super.key,
    required this.destination,
    required this.isDarkMode,
    this.onFavoriteUpdated, // NEW
  });
  @override
  State<ClickCard> createState() => _ClickCardState();
}

class _ClickCardState extends State<ClickCard> {
  bool showFullDescription = false;
  late bool isDark;
  late Map<String, dynamic> currentDestination; // Store destination locally

  @override
  void initState() {
    super.initState();
    isDark = widget.isDarkMode;
    currentDestination = Map.from(widget.destination); // Create local copy
  }

  // Province descriptions
  final Map<String, String> provinceDescriptions = {
    'Phnom Penh':
        'The vibrant capital city of Cambodia, where ancient temples stand alongside modern skyscrapers. Experience rich history, bustling markets, and the Royal Palace.',
    'Siem Reap':
        'Gateway to the magnificent Angkor Wat temple complex. A cultural hub offering ancient wonders, traditional performances, and authentic Khmer cuisine.',
    'Battambang':
        'Cambodia\'s charming riverside city known for colonial architecture, the famous bamboo train, and stunning countryside filled with temples and caves.',
    'Sihanoukville':
        'Beautiful coastal paradise with pristine beaches, crystal-clear waters, and vibrant island life. Perfect for relaxation and water activities.',
    'Kampot':
        'Picturesque riverside town famous for its pepper plantations, French colonial buildings, and stunning sunset views over the Kampot River.',
    'Kep':
        'Tranquil seaside town renowned for fresh crab, peaceful beaches, and the abandoned French villas that dot the hillsides.',
    'Kampong Cham':
        'Historic town along the Mekong River featuring bamboo bridges, ancient temples, and traditional Khmer culture.',
    'Kampong Chhnang':
        'Known as the "Port of Pottery," this province showcases traditional pottery-making and floating villages on Tonle Sap Lake.',
    'Kampong Speu':
        'Rich agricultural region with scenic countryside, ancient temples, and the famous Phnom Chisor temple complex.',
    'Kampong Thom':
        'Home to the impressive Sambor Prei Kuk temple ruins, a UNESCO World Heritage site dating back to the 7th century.',
    'Kandal':
        'Surrounding Phnom Penh, this province offers silk weaving villages, riverside communities, and peaceful rural landscapes.',
    'Koh Kong':
        'Wild and pristine province featuring dense jungles, waterfalls, and the stunning Cardamom Mountains with diverse wildlife.',
    'Kratié':
        'Famous for rare Irrawaddy dolphins in the Mekong River, French colonial architecture, and beautiful river islands.',
    'Mondulkiri':
        'Cambodia\'s mountainous eastern province known for elephant sanctuaries, waterfalls, and indigenous minority cultures.',
    'Banteay Meanchey':
        'Border province featuring ancient temples, traditional villages, and the gateway to Thailand via Poipet.',
    'Tboung Khmum':
        'Newly established province rich in rubber plantations, peaceful countryside, and traditional Cambodian lifestyle.',
    'Pailin':
        'Former gem-mining town nestled in scenic mountains, known for its waterfalls and colorful history.',
    'Preah Vihear':
        'Home to the spectacular cliff-top Preah Vihear Temple, a UNESCO World Heritage site with breathtaking views.',
    'Pursat':
        'Central province famous for marble carving, the Cardamom Mountains, and floating villages on Tonle Sap Lake.',
    'Prey Veng':
        'Agricultural heartland with rice paddies, traditional villages, and authentic rural Cambodian experiences.',
    'Ratanakiri':
        'Remote northeastern province featuring volcanic lakes, dense forests, ethnic minority villages, and stunning waterfalls.',
    'Stung Treng':
        'Gateway to Laos, featuring the Mekong River, rare dolphins, and lush forested landscapes.',
    'Svay Rieng':
        'Border province known for its vibrant markets, agricultural landscapes, and proximity to Vietnam.',
    'Takéo':
        'Known as the "Cradle of Cambodian Civilization," featuring ancient pre-Angkorian temples and traditional silk weaving.',
    'Oddar Meanchey':
        'Northern province with ancient temples, beautiful countryside, and the historic Anlong Veng district.',
  };

  // Travel Tips for each province
  final Map<String, List<Map<String, dynamic>>> provinceTravelTips = {
    'Phnom Penh': [
      {
        'icon': Icons.temple_buddhist_rounded,
        'title': 'Cultural Etiquette',
        'description': 'Dress modestly when visiting temples.',
        'color': Colors.purple,
      },
      {
        'icon': Icons.local_taxi_rounded,
        'title': 'Transport Tips',
        'description': 'Use PassApp or Grab for reliable pricing.',
        'color': Colors.blue,
      },
      {
        'icon': Icons.security_rounded,
        'title': 'Safety Advice',
        'description': 'Keep valuables secure in crowded areas.',
        'color': Colors.green,
      },
      {
        'icon': Icons.monetization_on_rounded,
        'title': 'Money Matters',
        'description': 'Use USD for larger purchases, Riel for small items.',
        'color': Colors.amber,
      },
    ],
    'Siem Reap': [
      {
        'icon': Icons.sunny,
        'title': 'Temple Timing',
        'description': 'Visit Angkor Wat at sunrise for fewer crowds.',
        'color': Colors.orange,
      },
      {
        'icon': Icons.hiking_rounded,
        'title': 'Explore Smart',
        'description': 'Wear comfortable shoes! Angkor complex is huge.',
        'color': Colors.blueGrey,
      },
      {
        'icon': Icons.water_drop_rounded,
        'title': 'Stay Hydrated',
        'description': 'Carry water always - temples offer little shade.',
        'color': Colors.blue,
      },
      {
        'icon': Icons.shopping_bag_rounded,
        'title': 'Shopping Tips',
        'description': 'Bargain at markets (start at 30% of asking price).',
        'color': Colors.pink,
      },
    ],
    'Battambang': [
      {
        'icon': Icons.train_rounded,
        'title': 'Bamboo Train',
        'description': 'Best time: Early morning or late afternoon.',
        'color': Colors.deepOrange,
      },
      {
        'icon': Icons.nightlife_rounded,
        'title': 'Bat Cave Show',
        'description': 'Arrive by 5:30 PM for best viewing.',
        'color': Colors.indigo,
      },
      {
        'icon': Icons.bike_scooter_rounded,
        'title': 'Local Transport',
        'description': 'Rent a bicycle to explore the city center.',
        'color': Colors.teal,
      },
      {
        'icon': Icons.food_bank_rounded,
        'title': 'Food Experience',
        'description': 'Try the famous Battambang sticky rice.',
        'color': Colors.red,
      },
    ],
    'Sihanoukville': [
      {
        'icon': Icons.beach_access_rounded,
        'title': 'Beach Selection',
        'description': 'Otres Beach is cleanest and quietest.',
        'color': Colors.cyan,
      },
      {
        'icon': Icons.sailing_rounded,
        'title': 'Island Hopping',
        'description': 'Book tours in advance during peak season.',
        'color': Colors.blue,
      },
      {
        'icon': Icons.waves_rounded,
        'title': 'Water Safety',
        'description': 'Check weather before swimming.',
        'color': Colors.deepPurple,
      },
      {
        'icon': Icons.local_bar_rounded,
        'title': 'Nightlife',
        'description': 'Beach parties mostly on weekends.',
        'color': Colors.pink,
      },
    ],
    'Kampot': [
      {
        'icon': Icons.agriculture_rounded,
        'title': 'Pepper Farms',
        'description': 'Best tours: La Plantation or Sothy\'s Pepper Farm.',
        'color': Colors.green,
      },
      {
        'icon': Icons.landscape_rounded,
        'title': 'Bokor Mountain',
        'description': 'Bring a jacket - it gets cold at the top!',
        'color': Colors.grey,
      },
      {
        'icon': Icons.kayaking_rounded,
        'title': 'River Activities',
        'description': 'Kayak rentals available along the river.',
        'color': Colors.blue,
      },
      {
        'icon': Icons.coffee_rounded,
        'title': 'Café Culture',
        'description': 'Riverside cafés are the town\'s highlight.',
        'color': Colors.brown,
      },
    ],
    'Kep': [
      {
        'icon': Icons.set_meal_rounded,
        'title': 'Crab Market',
        'description': 'Best time: Morning for freshest catch.',
        'color': Colors.red,
      },
      {
        'icon': Icons.villa_rounded,
        'title': 'French Villas',
        'description': 'Explore abandoned villas with amazing ocean views.',
        'color': Colors.purple,
      },
      {
        'icon': Icons.pedal_bike_rounded,
        'title': 'Getting Around',
        'description':
            'Everything is walkable, but bicycles make exploring easier.',
        'color': Colors.teal,
      },
      {
        'icon': Icons.iso_rounded,
        'title': 'Koh Tonsay',
        'description': 'Day trip to Rabbit Island.',
        'color': Colors.cyan,
      },
    ],
  };

  // Popular destinations for each province - MATCHING YOUR HOME STRUCTURE
  final Map<String, List<Map<String, dynamic>>> popularPlaces = {
    'Phnom Penh': [
      {
        'name': 'Royal Palace',
        'image': 'assets/Royal.png',
        'description': 'The official residence of the Cambodian King',
      },
      {
        'name': 'Tuol Sleng Genocide Museum',
        'image': 'assets/Toulsleng.png',
        'description': 'Historical museum documenting Khmer Rouge regime',
      },
      {
        'name': 'National Museum of Cambodia',
        'image': 'assets/National.png',
        'description': 'Largest museum of cultural history in Cambodia',
      },
      {
        'name': 'Wat Phnom',
        'image': 'assets/Wat.png',
        'description': 'Buddhist temple on the only hill in Phnom Penh',
      },
      {
        'name': 'Riverside Walk (Sisowath Quay)',
        'image': 'assets/riverside.png',
        'description': 'Scenic riverside promenade along the Mekong River',
      },
    ],
    'Siem Reap': [
      {
        'name': 'Angkor Wat',
        'image': 'assets/Angkor.png',
        'description': 'World\'s largest religious monument',
      },
      {
        'name': 'Bayon Temple',
        'image': 'assets/Bayon.png',
        'description': 'Famous for its many smiling stone faces',
      },
      {
        'name': 'Ta Prohm Temple',
        'image': 'assets/Taphrom.png',
        'description': 'Jungle temple famous for giant tree roots',
      },
      {
        'name': 'Pub Street',
        'image': 'assets/Pubstreet.png',
        'description': 'Vibrant nightlife area with restaurants and bars',
      },
      {
        'name': 'Beng Mealea Temple',
        'image': 'assets/BengMealea.png',
        'description': 'Remote jungle temple with dramatic ruins',
      },
    ],
    'Battambang': [
      {
        'name': 'Psar Nat (Central Market)',
        'image': 'assets/PsaNat.png',
        'description': 'Historic market building from French colonial era',
      },
      {
        'name': 'Battambang Museum',
        'image': 'assets/Battam.png',
        'description': 'Museum showcasing local history and artifacts',
      },
      {
        'name': 'Wat Banan Temple',
        'image': 'assets/Watbanan.png',
        'description': 'Ancient Angkorian temple on a hill',
      },
      {
        'name': 'Bamboo Train',
        'image': 'assets/Bambootrain.png',
        'description': 'Unique bamboo railway experience',
      },
      {
        'name': 'Crocodile Farm',
        'image': 'assets/Farmcroco.png',
        'description': 'Crocodile breeding and conservation center',
      },
    ],
    'Sihanoukville': [
      {
        'name': 'Koh Rong Samloem',
        'image': 'assets/Kohrong.png',
        'description': 'Pristine island paradise with crystal waters',
      },
      {
        'name': 'Otres Beach',
        'image': 'assets/Otres.png',
        'description': 'Peaceful beach away from the crowds',
      },
      {
        'name': 'Kbal Chhay Waterfall',
        'image': 'assets/KbalChay.png',
        'description': 'Beautiful cascading waterfall in the jungle',
      },
      {
        'name': 'Independence Beach',
        'image': 'assets/Independence.png',
        'description': 'Historic beach with calm waters',
      },
    ],
    'Kampot': [
      {
        'name': 'Popokvil Waterfall',
        'image': 'assets/Popokvil.png',
        'description': 'Multi-tiered waterfall in Bokor National Park',
      },
      {
        'name': 'Teuk Chhou Rapids',
        'image': 'assets/TerkChhou.png',
        'description': 'Scenic river rapids for swimming',
      },
      {
        'name': 'Bokor Mountain',
        'image': 'assets/Bokor.jpg',
        'description': 'Mountain with panoramic views',
      },
      {
        'name': 'Veal Pouch Waterfall',
        'image': 'assets/VealPouch.png',
        'description': 'Hidden waterfall with clear pools',
      },
      {
        'name': 'Kampong Trach Cave',
        'image': 'assets/KampongTrach.png',
        'description': 'Limestone cave with shrines',
      },
    ],
    'Kep': [
      {
        'name': 'Kep Beach',
        'image': 'assets/Kebbeach.png',
        'description': 'Tranquil seaside retreat',
      },
      {
        'name': 'Crab Market',
        'image': 'assets/Crab.png',
        'description': 'Fresh seafood market famous for Kep crabs',
      },
      {
        'name': 'Tmor Rung Waterfall',
        'image': 'assets/Tmorrung.png',
        'description': 'Beautiful waterfall in Kep National Park',
      },
      {
        'name': 'Koh Tonsay (Rabbit Island)',
        'image': 'assets/KohTonsay.png',
        'description': 'Small island with rustic beach bungalows',
      },
    ],
    'Kampong Cham': [
      {
        'name': 'Tek Cha',
        'image': 'assets/Terkcha.png',
        'description': 'Popular local resort and recreation area',
      },
      {
        'name': 'Hanchey Mountain',
        'image': 'assets/hanchey.png',
        'description': 'Scenic mountain with river views',
      },
      {
        'name': 'Phnom Pros & Phnom Srei',
        'image': 'assets/prossrey.png',
        'description': 'Twin hills with cultural significance',
      },
      {
        'name': 'Koh Pen Beach',
        'image': 'assets/Kohpen.png',
        'description': 'River island beach perfect for relaxation',
      },
      {
        'name': 'Nokor Bachey Temple',
        'image': 'assets/Nokor.png',
        'description': 'Ancient temple with unique architecture',
      },
    ],
    'Kampong Chhnang': [
      {
        'name': 'Floating Village',
        'image': 'assets/Floating.png',
        'description': 'Traditional floating community on Tonle Sap',
      },
      {
        'name': 'Pottery Village',
        'image': 'assets/Chnnang.png',
        'description': 'Traditional Khmer pottery making center',
      },
      {
        'name': 'Phnom San Touch',
        'image': 'assets/Santouch.png',
        'description': 'Hill with pagoda and panoramic views',
      },
      {
        'name': 'Phnom Preah Theat Temple',
        'image': 'assets/PreahTheat.png',
        'description': 'Ancient temple with historical significance',
      },
      {
        'name': 'Kong Rei Mountain',
        'image': 'assets/Kongrei.png',
        'description': 'Scenic mountain for hiking and nature',
      },
    ],
    'Kampong Speu': [
      {
        'name': 'Kirirom National Park',
        'image': 'assets/Kirirom.png',
        'description': 'Pine forest plateau with cool climate',
      },
      {
        'name': 'Phnom Aural',
        'image': 'assets/Aural.png',
        'description': 'Cambodia\'s highest mountain',
      },
      {
        'name': 'Chambok Waterfall',
        'image': 'assets/Chambok.png',
        'description': 'Beautiful waterfall in natural surroundings',
      },
      {
        'name': 'Knong Phsar Mountain',
        'image': 'assets/KnongPhsar.png',
        'description': 'Mountain with local market and views',
      },
    ],
    'Kampong Thom': [
      {
        'name': 'Sambor Prei Kuk',
        'image': 'assets/Sambor.png',
        'description': 'UNESCO World Heritage pre-Angkorian temples',
      },
      {
        'name': 'Prasat Andet',
        'image': 'assets/Prasat.png',
        'description': 'Ancient temple ruins',
      },
      {
        'name': 'Phnom Santuk',
        'image': 'assets/Santuk.png',
        'description': 'Sacred mountain with pagoda',
      },
      {
        'name': 'Stung Sen River',
        'image': 'assets/stungsen.png',
        'description': 'Major river for boat trips',
      },
      {
        'name': 'Prey Pros Lake',
        'image': 'assets/PreyPros.png',
        'description': 'Natural lake for relaxation',
      },
    ],
    'Kandal': [
      {
        'name': 'Vihear Sour Pagoda',
        'image': 'assets/vihearsour.png',
        'description': 'Historic Buddhist temple',
      },
      {
        'name': 'Kien Svay Krao',
        'image': 'assets/kiensvay.png',
        'description': 'Popular riverside recreation area',
      },
      {
        'name': 'Oudong Mountain',
        'image': 'assets/oudong.png',
        'description': 'Ancient royal capital with stupas',
      },
      {
        'name': 'Phnom Prasithy',
        'image': 'assets/prasity.png',
        'description': 'Hill with religious significance',
      },
      {
        'name': 'Toul Reachea Pagoda',
        'image': 'assets/reachea.png',
        'description': 'Beautiful pagoda complex',
      },
    ],
    'Koh Kong': [
      {
        'name': 'Tatai Waterfall',
        'image': 'assets/Tatai.png',
        'description': 'Majestic waterfall in Cardamom Mountains',
      },
      {
        'name': 'Peam Krasop Wildlife Sanctuary',
        'image': 'assets/PeamKrasop.png',
        'description': 'Mangrove forest sanctuary',
      },
      {
        'name': 'Koh Kong Island',
        'image': 'assets/KohkongIsland.png',
        'description': 'Pristine island paradise',
      },

      {
        'name': 'Cardamom Mountains',
        'image': 'assets/Cardamom.png',
        'description': 'Largest rainforest in Southeast Asia',
      },
    ],
    'Kratié': [
      {
        'name': 'Koh Pdao Community Tour',
        'image': 'assets/KohPdao.png',
        'description': 'Community-based eco-tourism experience',
      },
      {
        'name': 'Koh Trong',
        'image': 'assets/KohTrong.png',
        'description': 'River island with scenic views',
      },
      {
        'name': 'Wat Roka Kandal Temple',
        'image': 'assets/Watroka.png',
        'description': 'Ancient wooden temple',
      },
      {
        'name': 'Phnom Sopor Kaley',
        'image': 'assets/Kaley.png',
        'description': 'Hill with religious significance',
      },
      {
        'name': 'Kampi Dolphin Pool',
        'image': 'assets/Kampi.png',
        'description': 'Habitat of rare Irrawaddy dolphins',
      },
    ],
    'Mondulkiri': [
      {
        'name': 'Bou Sra Waterfall',
        'image': 'assets/bousra.png',
        'description': 'Cambodia\'s largest waterfall',
      },
      {
        'name': 'Sen Monorom Waterfall',
        'image': 'assets/senMonorom.png',
        'description': 'Beautiful waterfall near town',
      },

      {
        'name': 'Chrey Thom Waterfall',
        'image': 'assets/ChreyThom.png',
        'description': 'Peaceful waterfall for relaxation',
      },
      {
        'name': 'Phnom Andong Sne',
        'image': 'assets/Andong.png',
        'description': 'Mountain with ethnic village',
      },
    ],
    'Banteay Meanchey': [
      {
        'name': 'Banteay Chhmar',
        'image': 'assets/Chmar.png',
        'description': 'Massive Angkorian temple complex',
      },

      {
        'name': 'Banteay Torb Temple',
        'image': 'assets/BanteayTorb.png',
        'description': 'Ancient brick temple ruins',
      },
      {
        'name': 'Wat Phnom Toch',
        'image': 'assets/WatphnomToch.png',
        'description': 'Hilltop pagoda with views',
      },
    ],
    'Tboung Khmum': [
      {
        'name': 'Preah Theat Basrei Temple',
        'image': 'assets/Phreah.png',
        'description': 'Ancient temple with unique architecture',
      },
      {
        'name': 'Houng Waterfall',
        'image': 'assets/houng.png',
        'description': 'Natural waterfall in forest',
      },

      {
        'name': 'OBT Training Center',
        'image': 'assets/obt.png',
        'description': 'Organization for Basic Training facility',
      },
    ],
    'Pailin': [
      {
        'name': 'Ou Ta Vau Waterfall',
        'image': 'assets/Outavau.png',
        'description': 'Beautiful waterfall in forest',
      },

      {
        'name': 'Ang Jing Chok',
        'image': 'assets/AngJing.png',
        'description': 'Natural rock formation',
      },
      {
        'name': 'Bar Yakha',
        'image': 'assets/Baryak.png',
        'description': 'Local market and gathering place',
      },
    ],
    'Preah Vihear': [
      {
        'name': 'Preah Vihear Temple',
        'image': 'assets/Phreah.png',
        'description': 'UNESCO World Heritage temple on cliff edge',
      },
      {
        'name': 'Koh Ker Temple',
        'image': 'assets/Kohker.png',
        'description': 'Ancient pyramid temple in remote jungle',
      },
      {
        'name': 'Neak Buos Temple',
        'image': 'assets/NeakBuos.png',
        'description': 'Remote temple ruins near Thai border',
      },
    ],
    'Pursat': [
      {
        'name': 'Ou Da',
        'image': 'assets/ouda.png',
        'description': 'Natural rock formation and caves',
      },
      {
        'name': 'Thmor Da Waterfall',
        'image': 'assets/thmorda.png',
        'description': 'Beautiful waterfall for relaxation',
      },
      {
        'name': 'Phnom 1500',
        'image': 'assets/phnom1500.png',
        'description': 'Mountain with cool climate',
      },
      {
        'name': 'Labak Komrounh',
        'image': 'assets/labak.png',
        'description': 'Scenic natural area',
      },
      {
        'name': 'Chrork Laeang Waterfall',
        'image': 'assets/chrork.png',
        'description': 'Multi-tiered waterfall',
      },
    ],
    'Prey Veng': [
      {
        'name': 'Ba Phnom Temple',
        'image': 'assets/Baphnom.png',
        'description': 'Ancient temple on sacred hill',
      },
      {
        'name': 'Nokor Phnom',
        'image': 'assets/Nokor.png',
        'description': 'Historical site with pagoda',
      },

      {
        'name': 'Vihear Chan Temple',
        'image': 'assets/VihearChan.png',
        'description': 'Beautiful Buddhist temple',
      },
      {
        'name': 'Toul Baray Andet',
        'image': 'assets/ToulBaray.png',
        'description': 'Ancient reservoir ruins',
      },
    ],
    'Ratanakiri': [
      {
        'name': 'Yeak Loam Lake',
        'image': 'assets/Yeaklaom.png',
        'description': 'Volcanic crater lake perfect for swimming',
      },
      {
        'name': 'Cha Ong Waterfall',
        'image': 'assets/Chanong.png',
        'description': 'Beautiful waterfall in jungle',
      },
      {
        'name': 'Katieng Waterfall',
        'image': 'assets/Katieng.png',
        'description': 'Scenic waterfall for nature lovers',
      },
      {
        'name': 'Kiri WongKut Lake',
        'image': 'assets/wongkut.png',
        'description': 'Natural lake surrounded by forest',
      },
      {
        'name': 'Virak Chey Park',
        'image': 'assets/virakchey.png',
        'description': 'National park with diverse wildlife',
      },
    ],
    'Stung Treng': [
      {
        'name': 'Preah Nimith Waterfall',
        'image': 'assets/Nimith.png',
        'description': 'Beautiful waterfall on Mekong tributary',
      },

      {
        'name': 'La Ang Phnom Prak',
        'image': 'assets/LaAng.png',
        'description': 'Natural rock formation',
      },
      {
        'name': 'Oresey Kondal Resort',
        'image': 'assets/Oresey.png',
        'description': 'Riverside resort for relaxation',
      },
      {
        'name': 'Koh Ksach Resort',
        'image': 'assets/Kohksach.png',
        'description': 'Island resort on Mekong River',
      },
    ],
    'Svay Rieng': [
      {
        'name': 'Bassac Temple',
        'image': 'assets/Bassac.png',
        'description': 'Ancient temple with unique style',
      },
      {
        'name': 'Ji Hor Temple',
        'image': 'assets/Jihor.png',
        'description': 'Historic Buddhist temple',
      },

      {
        'name': 'Korky Forest',
        'image': 'assets/Korky.png',
        'description': 'Natural forest area',
      },
      {
        'name': 'Tek Vil',
        'image': 'assets/TekVil.png',
        'description': 'Scenic natural area',
      },
    ],
    'Takéo': [
      {
        'name': 'Phnom Chita Pech',
        'image': 'assets/chitapech.png',
        'description': 'Hill with religious significance',
      },
      {
        'name': 'Angkor Borei',
        'image': 'assets/borei.png',
        'description': 'Ancient capital of Funan kingdom',
      },
      {
        'name': 'Phnom Tamao Zoo',
        'image': 'assets/tamaozoo.png',
        'description': 'Wildlife rescue center and zoo',
      },
      {
        'name': 'Phnom Chisor',
        'image': 'assets/chisor.png',
        'description': 'Hilltop temple with panoramic views',
      },
      {
        'name': 'Phnom Bayong',
        'image': 'assets/bayoung.png',
        'description': 'Ancient temple ruins',
      },
    ],
    'Oddar Meanchey': [
      {
        'name': 'Ta Krabei Temple',
        'image': 'assets/Krabei.png',
        'description': 'Ancient temple ruins',
      },
      {
        'name': 'Ta Moan Thom Temple',
        'image': 'assets/MoanThom.png',
        'description': 'Remote temple complex near border',
      },
      {
        'name': 'Ta Moan Toch Temple',
        'image': 'assets/Tamaon.png',
        'description': 'Smaller temple near Ta Moan Thom',
      },
      {
        'name': 'Dey Rolous Thom Resort',
        'image': 'assets/DeyRolous.png',
        'description': 'Local resort area',
      },
      {
        'name': 'Champei Waterfall',
        'image': 'assets/Champei.png',
        'description': 'Natural waterfall in forest',
      },
    ],
  };

  // COLORS
  Color get bgColor => isDark
      ? const Color(0xFF0A0E27)
      : const Color.fromARGB(255, 245, 232, 210);

  Color get textColor => isDark ? Colors.white : const Color(0xFF2C1810);
  Color get cardBg =>
      isDark ? const Color.fromARGB(255, 10, 11, 14) : Colors.white;
  Color get borderColor =>
      isDark ? const Color(0xFF64B5F6) : const Color(0xFFD4A574);

  Color get accentColor =>
      isDark ? const Color(0xFF64B5F6) : const Color(0xFFB8860B);
  List<Map<String, dynamic>> getPopularPlaces() {
    return popularPlaces[widget.destination['name']] ??
        [
          {
            'name': 'Scenic Viewpoint',
            'image': 'assets/images/default/viewpoint.jpg',
            'description': 'Beautiful panoramic views',
          },
          {
            'name': 'Cultural Site',
            'image': 'assets/images/default/cultural.jpg',
            'description': 'Rich historical significance',
          },
          {
            'name': 'Local Market',
            'image': 'assets/images/default/market.jpg',
            'description': 'Authentic local experience',
          },
          {
            'name': 'Nature Trail',
            'image': 'assets/images/default/nature.jpg',
            'description': 'Scenic hiking paths',
          },
        ];
  }

  List<Map<String, dynamic>> getTravelTips() {
    final List<Map<String, dynamic>> provinceTips =
        provinceTravelTips[widget.destination['name']] ?? [];

    if (provinceTips.isNotEmpty) {
      return provinceTips;
    }

    return [
      {
        'icon': Icons.wb_sunny_rounded,
        'title': 'Best Time to Visit',
        'description': 'November to March offers cool, dry weather.',
        'color': Colors.orange,
      },
      {
        'icon': Icons.restaurant_rounded,
        'title': 'Local Cuisine',
        'description': 'Try authentic Khmer dishes at local restaurants.',
        'color': Colors.red,
      },
      {
        'icon': Icons.directions_bus_rounded,
        'title': 'Getting Around',
        'description': 'Tuk-tuks and motorbikes are most popular.',
        'color': Colors.blue,
      },
      {
        'icon': Icons.monetization_on_rounded,
        'title': 'Money Tips',
        'description': 'Carry small bills. USD widely accepted.',
        'color': Colors.green,
      },
    ];
  }

  String getDescription() {
    return provinceDescriptions[widget.destination['name']] ??
        'Discover the beauty and culture of this amazing Cambodian province. Experience authentic local life, stunning landscapes, and rich history.';
  }

  Future<void> _openGoogleMaps() async {
    final String locationName = widget.destination['name'];
    final String encodedLocation = Uri.encodeComponent(
      '$locationName Cambodia',
    );
    final String googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$encodedLocation';
    final Uri url = Uri.parse(googleMapsUrl);

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        _showErrorSnackbar();
      }
    } catch (e) {
      _showErrorSnackbar();
    }
  }

  void _showErrorSnackbar() {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Could not open maps.',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void navigateToPopularPlace(Map<String, dynamic> place) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PopularPage(
          place: place,
          provinceName: currentDestination['name'], // Use currentDestination
          isDarkMode: isDark,
          onFavoriteUpdated: (updatedPlace) {
            // Find and update the place in popularPlaces list
            final provinceName = currentDestination['name'];
            if (popularPlaces.containsKey(provinceName)) {
              final index = popularPlaces[provinceName]!.indexWhere(
                (p) => p['name'] == updatedPlace['name'],
              );
              if (index != -1) {
                setState(() {
                  popularPlaces[provinceName]![index]['fav'] =
                      updatedPlace['fav'];
                  popularPlaces[provinceName]![index]['savedDate'] =
                      updatedPlace['savedDate'];
                  popularPlaces[provinceName]![index]['visited'] =
                      updatedPlace['visited'];
                });

                // Pass the favorite update back to parent if callback exists
                if (widget.onFavoriteUpdated != null) {
                  widget.onFavoriteUpdated!(currentDestination);
                }
              }
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final places = getPopularPlaces();
    final description = getDescription();
    final travelTips = getTravelTips();

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER - Update back button to pass data back
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Pass the updated destination back when navigating back
                      if (widget.onFavoriteUpdated != null) {
                        widget.onFavoriteUpdated!(currentDestination);
                      }
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: borderColor.withOpacity(0.3),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: borderColor.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: textColor,
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Destination",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 70),
                ],
              ),
            ),

            // CONTENT
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // LOCATION BOX
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GestureDetector(
                        onTap: _openGoogleMaps,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: cardBg,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: borderColor.withOpacity(0.3),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: borderColor.withOpacity(0.15),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFF64B5F6,
                                  ).withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: const Color(
                                      0xFF64B5F6,
                                    ).withOpacity(0.3),
                                    width: 1.5,
                                  ),
                                ),
                                child: Icon(
                                  Icons.location_on_rounded,
                                  color: const Color(0xFF64B5F6),
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.destination['name'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: textColor,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.map_rounded,
                                          size: 14,
                                          color: const Color(0xFF64B5F6),
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          'Tap to open in Google Maps',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: textColor.withOpacity(0.7),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                color: textColor.withOpacity(0.5),
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // MAIN IMAGE
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        height: 320,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: borderColor.withOpacity(0.2),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Stack(
                            children: [
                              Image.asset(
                                widget.destination['image'],
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          accentColor.withOpacity(0.3),
                                          accentColor.withOpacity(0.1),
                                        ],
                                      ),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.landscape,
                                        size: 64,
                                        color: accentColor.withOpacity(0.5),
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
                                      Colors.black.withOpacity(0.7),
                                    ],
                                  ),
                                ),
                              ),

                              Positioned(
                                bottom: 16,
                                left: 16,
                                right: 16,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.95),
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.15),
                                        blurRadius: 15,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          widget.destination['name'],
                                          style: const TextStyle(
                                            color: Color(0xFF2C1810),
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: -0.5,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(
                                            0xFFFFB300,
                                          ).withOpacity(0.15),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.star_rounded,
                                              color: Color(0xFFFFB300),
                                              size: 18,
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              "${widget.destination['rate'] ?? '4.9'}",
                                              style: const TextStyle(
                                                color: Color(0xFF2C1810),
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              'Rating',
                                              style: TextStyle(
                                                color: const Color(
                                                  0xFF2C1810,
                                                ).withOpacity(0.7),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 16,
                                right: 16,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      currentDestination['fav'] =
                                          !(currentDestination['fav'] ?? false);

                                      // Add/remove saved date
                                      if (currentDestination['fav']) {
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
                                        currentDestination['savedDate'] =
                                            '${months[now.month - 1]} ${now.day}, ${now.year}';
                                      } else {
                                        currentDestination['savedDate'] = null;
                                        currentDestination['visited'] = false;
                                      }
                                    });

                                    // Pass the update back to parent
                                    if (widget.onFavoriteUpdated != null) {
                                      widget.onFavoriteUpdated!(
                                        currentDestination,
                                      );
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.95),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.15),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      currentDestination['fav'] // Use currentDestination
                                          ? Icons.favorite_rounded
                                          : Icons.favorite_border_rounded,
                                      color:
                                          currentDestination['fav'] // Use currentDestination
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

                    const SizedBox(height: 24),

                    // DESCRIPTION
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: cardBg,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: borderColor.withOpacity(0.3),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: borderColor.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.info_outline_rounded,
                                  color: accentColor,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "About This Place",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: textColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              showFullDescription
                                  ? description
                                  : description.length > 120
                                  ? '${description.substring(0, 120)}...'
                                  : description,
                              style: TextStyle(
                                fontSize: 14,
                                color: textColor.withOpacity(0.8),
                                height: 1.6,
                              ),
                            ),
                            if (description.length > 120)
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    showFullDescription = !showFullDescription;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    showFullDescription
                                        ? "Read less"
                                        : "Read more",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: accentColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // POPULAR DESTINATIONS
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.explore_rounded,
                                color: accentColor,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "Popular Destinations",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                            ),
                            child: Text(
                              "View All",
                              style: TextStyle(
                                color: accentColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // HORIZONTAL SCROLLING POPULAR PLACES
                    SizedBox(
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: places.length,
                        itemBuilder: (context, index) {
                          final place = places[index];
                          return Padding(
                            padding: EdgeInsets.only(
                              right: index < places.length - 1 ? 12 : 0,
                            ),
                            child: GestureDetector(
                              onTap: () => navigateToPopularPlace(place),
                              child: Container(
                                width: 140,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: borderColor.withOpacity(0.15),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Stack(
                                    children: [
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
                                                    colors: [
                                                      accentColor.withOpacity(
                                                        0.3,
                                                      ),
                                                      accentColor.withOpacity(
                                                        0.1,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.place_rounded,
                                                    size: 36,
                                                    color: accentColor
                                                        .withOpacity(0.5),
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
                                              Colors.black.withOpacity(0.7),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 10,
                                        left: 10,
                                        right: 10,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              place['name'],
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                height: 1.2,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 3),
                                            Text(
                                              place['description'],
                                              style: TextStyle(
                                                color: Colors.white.withOpacity(
                                                  0.85,
                                                ),
                                                fontSize: 10,
                                                height: 1.3,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
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

                    const SizedBox(height: 24),

                    // TRAVEL TIPS
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.tips_and_updates_rounded,
                                color: accentColor,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "Travel Tips",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ...travelTips.map((tip) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: _buildTipCard(
                                icon: tip['icon'],
                                title: tip['title'],
                                description: tip['description'],
                                color: tip['color'] ?? accentColor,
                              ),
                            );
                          }),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor.withOpacity(0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: borderColor.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color.withOpacity(0.3), width: 1.5),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: textColor.withOpacity(0.7),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
