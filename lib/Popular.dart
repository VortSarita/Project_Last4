import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PopularPage extends StatefulWidget {
  final Map<String, dynamic> place;
  final String provinceName;
  final bool isDarkMode;
  final VoidCallback? onToggleFavorite;
  final Function(Map<String, dynamic>)?
  onFavoriteUpdated; // NEW: Callback to update main list

  const PopularPage({
    super.key,
    required this.place,
    required this.provinceName,
    required this.isDarkMode,
    this.onToggleFavorite,
    this.onFavoriteUpdated, // NEW
  });

  @override
  State<PopularPage> createState() => _PopularPageState();
}

class _PopularPageState extends State<PopularPage> {
  late bool isDark;
  bool showFullDescription = false;
  late Map<String, dynamic> currentPlace; // Store place locally

  @override
  void initState() {
    super.initState();
    isDark = widget.isDarkMode;
    currentPlace = Map.from(widget.place); // Create a local copy
  }

  final Map<String, Map<String, dynamic>> placeDetails = {
    // PHNOM PENH
    'Royal Palace': {
      'fullDescription':
          'The Royal Palace of Cambodia is a stunning complex of buildings serving as the royal residence of the King of Cambodia. Built in 1866, the palace stands as a magnificent example of Khmer architecture with its distinctive golden roofs and ornate decorations. The compound houses the Silver Pagoda, named for its floor covered with five tons of silver, and contains numerous national treasures including gold and jeweled Buddha statues. The Throne Hall with its 59-meter tower dominates the skyline and hosts royal ceremonies and coronations. Walking through the palace gardens, visitors can admire the perfectly manicured French-style landscaping and traditional Khmer design elements. The palace remains a working residence, so certain sections are closed to the public, but the areas open to visitors provide an incredible glimpse into Cambodia\'s royal heritage and Buddhist traditions.',
      'openingHours': '8:00 AM - 11:00 AM, 2:00 PM - 5:00 PM',
      'entryFee': '\$10 USD',
      'bestTime': 'Early morning (8:00-9:30 AM) to avoid crowds and heat',
      'duration': '2-3 hours',
      'highlights': [
        'Silver Pagoda with emerald Buddha statue',
        'Throne Hall with magnificent golden spires',
        'Classic Khmer architecture and design',
        'Royal regalia and priceless artifacts',
        'Beautiful French-influenced gardens',
      ],
      'tips': [
        'Dress modestly - cover shoulders and knees (sarongs available)',
        'No photography inside the Silver Pagoda',
        'Remove hats and sunglasses when entering buildings',
        'Hire a guide for deeper historical context',
        'Visit early morning for best lighting and fewer crowds',
      ],
    },
    'Tuol Sleng Genocide Museum': {
      'fullDescription':
          'Tuol Sleng Genocide Museum, also known as S-21, stands as a haunting memorial to the victims of the Khmer Rouge regime. Originally a high school, this building was converted into a security prison where an estimated 17,000 people were imprisoned, tortured, and executed between 1975-1979. The museum preserves the prison in its original state, with interrogation rooms, tiny brick cells, and instruments of torture still visible. Photographs of victims line the walls, creating a powerful and emotional experience. The museum serves as an important educational center, documenting the atrocities committed during Democratic Kampuchea and honoring those who perished. Audio guides feature survivor testimonies, providing deeply personal accounts of this dark period in history. Visiting Tuol Sleng is a sobering but essential experience for understanding Cambodia\'s recent past and the resilience of its people.',
      'openingHours': '8:00 AM - 5:00 PM daily',
      'entryFee': '\$5 USD (Audio guide \$3 extra)',
      'bestTime': 'Morning for a quieter, more reflective visit',
      'duration': '2-3 hours',
      'highlights': [
        'Preserved prison cells and interrogation rooms',
        'Photographic archive of victims',
        'Detailed historical documentation',
        'Survivor testimonies (audio guide)',
        'Memorial stupa in courtyard',
      ],
      'tips': [
        'Prepare emotionally - this is a difficult experience',
        'Audio guide highly recommended for context',
        'Photography allowed but be respectful',
        'Consider visiting the Killing Fields afterward',
        'Dress respectfully',
      ],
    },
    'National Museum of Cambodia': {
      'fullDescription':
          'The National Museum of Cambodia is the country\'s leading historical and archaeological museum, housing the world\'s finest collection of Khmer art spanning from prehistoric times to the post-Angkorian period. Built in 1920, the elegant terracotta building features traditional Khmer architecture with a beautiful central courtyard garden. The museum\'s collection includes over 14,000 items, from ancient stone sculptures and bronze artifacts to ceramics and ethnographic objects. Highlights include pre-Angkorian statues from Funan and Chenla periods, masterpieces from Angkor, and exquisite examples of Khmer craftsmanship. The statuary gallery showcases Buddha images in various styles, while the bronze collection demonstrates the evolution of Khmer metalwork. The peaceful inner courtyard provides a tranquil space for reflection, with lotus ponds and tropical plants creating a serene atmosphere perfect for contemplating Cambodia\'s rich artistic heritage.',
      'openingHours': '8:00 AM - 5:00 PM daily',
      'entryFee': '\$10 USD (Audio guide \$5 extra)',
      'bestTime': 'Morning or late afternoon when cooler',
      'duration': '1.5-2.5 hours',
      'highlights': [
        'World-class Khmer sculpture collection',
        'Bronze Buddha statues from different eras',
        'Pre-Angkorian and Angkorian artifacts',
        'Beautiful traditional architecture',
        'Peaceful inner courtyard garden',
      ],
      'tips': [
        'No photography inside galleries',
        'Hire a knowledgeable guide for deeper understanding',
        'Visit before or after Angkor Wat for context',
        'The courtyard is perfect for a peaceful break',
        'Combination tickets available with Royal Palace',
      ],
    },
    'Wat Phnom': {
      'fullDescription':
          'Wat Phnom is the namesake and symbolic center of Phnom Penh, sitting atop a 27-meter artificial hill. According to legend, in 1372, a wealthy widow named Penh found four Buddha statues washed up on the riverbank and built this hill ("phnom") to house them, giving the city its name. The current pagoda dates from 1926 and features beautiful murals depicting scenes from Buddha\'s life and Khmer folklore. The temple complex includes several shrines, a large stupa containing the ashes of King Ponhea Yat, and a clock tower gifted by the French. The park surrounding the temple is a popular gathering place for locals, especially during festivals and holidays. Visitors can observe daily religious practices, make offerings, and enjoy panoramic views of the city from the hilltop. The site also serves as an important pilgrimage destination for Cambodians seeking blessings and good fortune.',
      'openingHours': '6:00 AM - 6:00 PM daily',
      'entryFee': '\$1 USD',
      'bestTime': 'Early morning (6:00-7:00 AM) or sunset (5:00-6:00 PM)',
      'duration': '45 minutes - 1 hour',
      'highlights': [
        'Historic pagoda with founding legend',
        'Beautiful murals and Buddhist art',
        'City views from the hilltop',
        'Peaceful park with tropical gardens',
        'Local religious ceremonies',
      ],
      'tips': [
        'Watch out for playful monkeys in the park',
        'Remove shoes before entering the temple',
        'Dress modestly (cover shoulders and knees)',
        'Bring small bills for donations and offerings',
        'Visit during a festival for special ceremonies',
      ],
    },
    'Riverside Walk (Sisowath Quay)': {
      'fullDescription':
          'Sisowath Quay is Phnom Penh\'s vibrant riverside promenade stretching along the Tonle Sap River for over 3 kilometers. This beautifully landscaped walkway has transformed into one of the city\'s most popular destinations, lined with palm trees, restaurants, cafes, bars, and shops. During the day, the riverside is perfect for strolling, jogging, or cycling while watching traditional wooden boats and modern cruise ships pass by. Street vendors sell everything from fresh coconuts to traditional snacks. As evening approaches, the promenade comes alive with locals practicing aerobics, families relaxing, and tourists enjoying the cooling river breeze. Sunset over the Mekong-Tonle Sap confluence is spectacular, with the Royal Palace illuminated in the background. The night market adds extra vibrancy on weekends, while riverside restaurants offer everything from traditional Khmer cuisine to international fare, many with stunning river views.',
      'openingHours': 'Open 24/7',
      'entryFee': 'Free',
      'bestTime': 'Sunset (5:30-6:30 PM) for best atmosphere',
      'duration': '1-3 hours',
      'highlights': [
        'Spectacular sunset views over the river',
        'Diverse dining options with river views',
        'Refreshing evening river breeze',
        'People watching and local life',
        'Weekend night market',
      ],
      'tips': [
        'Try street food from local vendors',
        'Watch for pickpockets in crowded areas',
        'Rent a bike for easier exploration',
        'Best photo opportunities at golden hour',
        'Visit riverside cafes for air-conditioned breaks',
      ],
    },

    // SIEM REAP
    'Angkor Wat': {
      'fullDescription':
          'Angkor Wat is the largest and most magnificent religious monument in the world, spanning over 400 acres. Built in the early 12th century by King Suryavarman II, it was originally dedicated to the Hindu god Vishnu before becoming a Buddhist temple. The temple complex represents the pinnacle of classical Khmer architecture and art, with its five lotus-bud towers symbolizing Mount Meru, home of the Hindu gods. The extensive bas-relief galleries depict Hindu epics and historical events, covering over 1,200 square meters with intricate carvings. The famous sunrise view reflects the temple in the lotus pond, creating one of Southeast Asia\'s most iconic images. Inside, narrow galleries lead to the central sanctuary, where steep stairs test visitors\' courage and faith. The preservation work is ongoing, and you can witness international teams working to maintain this UNESCO World Heritage masterpiece for future generations.',
      'openingHours': '5:00 AM - 5:30 PM daily',
      'entryFee': '1-day pass: \$37, 3-day pass: \$62, 7-day pass: \$72',
      'bestTime': 'Sunrise (5:00-6:30 AM) or late afternoon (3:00-5:00 PM)',
      'duration': '3-5 hours minimum',
      'highlights': [
        'Iconic sunrise reflection in lotus pond',
        'Extensive bas-relief galleries depicting Hindu epics',
        'Five central towers representing Mount Meru',
        'Intricate Apsara carvings (over 1,800)',
        'Central sanctuary with panoramic views',
      ],
      'tips': [
        'Arrive by 5:00 AM for prime sunrise viewing spots',
        'Wear comfortable walking shoes',
        'Bring water, sunscreen, and hat',
        'Dress modestly for temple areas',
        'Hire a knowledgeable guide for historical context',
        'Visit main temple in morning, return in afternoon for different light',
      ],
    },
    'Bayon Temple': {
      'fullDescription':
          'Bayon Temple stands at the heart of Angkor Thom, the last great capital of the Khmer Empire. Built in the late 12th century by King Jayavarman VII, Bayon is famous for its 216 massive smiling stone faces thought to represent either the king himself or Avalokiteshvara, the bodhisattva of compassion. The temple\'s unique architectural style represents the transition from Hindu to Buddhist worship. The outer galleries feature 1,200 square meters of bas-reliefs depicting daily life in 12th-century Cambodia, including market scenes, festivals, and naval battles with the Cham. As you climb through the three levels, the peaceful faces seem to watch you from every angle, creating an almost mystical atmosphere. The morning light illuminates the western faces while afternoon brings warmth to the eastern facades, making multiple visits worthwhile. The temple\'s maze-like structure rewards exploration, with hidden chambers and unexpected viewpoints around every corner.',
      'openingHours': '7:30 AM - 5:30 PM daily',
      'entryFee': 'Included in Angkor Archaeological Park pass',
      'bestTime': 'Morning light (9:00-10:30 AM) for best face illumination',
      'duration': '1.5-2.5 hours',
      'highlights': [
        '216 enigmatic smiling stone faces',
        'Intricate bas-reliefs showing daily Khmer life',
        'Central tower with panoramic views',
        'Unique blend of Hindu and Buddhist imagery',
        'Atmospheric maze-like corridors',
      ],
      'tips': [
        'Visit mid-morning for best lighting on faces',
        'Explore all three levels for different perspectives',
        'Look for bas-reliefs on outer walls depicting battles',
        'Less crowded in early afternoon',
        'Photography is best in soft morning light',
      ],
    },
    'Ta Prohm Temple': {
      'fullDescription':
          'Ta Prohm offers one of the most photogenic and atmospheric temple experiences at Angkor. Built in 1186 by King Jayavarman VII as a monastery and university, the temple has been deliberately left in a state of "controlled ruin" by archaeologists. Massive silk-cotton and strangler fig trees grow through and over the stone structures, their enormous roots draping over doorways and walls like natural sculptures. This creates a dramatic interplay between nature and architecture that captures visitors\' imaginations. The temple gained fame as a filming location for "Tomb Raider," but its appeal goes far beyond Hollywood. Walking through Ta Prohm feels like discovering a lost civilization, with crumbling corridors, fallen stones, and hidden chambers creating an adventurous atmosphere. The conservation work here is delicate, balancing the need to prevent further collapse while maintaining the romantic, jungle-consumed aesthetic that makes Ta Prohm so special.',
      'openingHours': '7:30 AM - 5:30 PM daily',
      'entryFee': 'Included in Angkor Archaeological Park pass',
      'bestTime':
          'Early morning (7:30-9:00 AM) or late afternoon (3:00-5:00 PM)',
      'duration': '1-2 hours',
      'highlights': [
        'Massive tree roots engulfing temple structures',
        'Atmospheric jungle temple setting',
        '"Tomb Raider" filming location',
        'Excellent photo opportunities',
        'Ongoing conservation work visible',
      ],
      'tips': [
        'Visit very early to avoid tour groups',
        'Bring insect repellent for mosquitoes',
        'Watch your step on uneven stones',
        'Respect the conservation areas',
        'Late afternoon light creates magical atmosphere',
      ],
    },
    'Pub Street': {
      'fullDescription':
          'Pub Street is the beating heart of Siem Reap\'s nightlife and dining scene, a vibrant pedestrian street in the old French Quarter. By day, it\'s a charming colonial-style street with cafes, shops, and restaurants offering everything from authentic Khmer cuisine to international fare. As evening falls, the street transforms into a lively entertainment zone with neon lights, live music, and crowds of travelers from around the world. The famous "Angkor What?" bar serves strong cocktails, while traditional restaurants offer Khmer dishes like amok and lok lak. Side streets branch off to the Night Market, massage parlors, and more dining options. The atmosphere is energetic but friendly, with locals and tourists mingling freely. Street performers, market vendors, and tuk-tuk drivers add to the colorful scene. While it can be touristy, Pub Street remains the best place to meet fellow travelers, celebrate a day at the temples, and experience Siem Reap\'s cosmopolitan side.',
      'openingHours': 'Most venues: 11:00 AM - late (1:00-3:00 AM)',
      'entryFee': 'Free entry (pay for food/drinks)',
      'bestTime': 'Evening (7:00 PM onwards) for full atmosphere',
      'duration': '2-4 hours',
      'highlights': [
        'Vibrant nightlife and entertainment',
        'Diverse restaurant options',
        'Live music and performances',
        'Adjacent Night Market',
        'Social atmosphere for meeting travelers',
      ],
      'tips': [
        'Try traditional Khmer cuisine at local restaurants',
        'Bargain at the Night Market',
        'Happy hour deals are common (5:00-8:00 PM)',
        'Watch your belongings in crowded areas',
        'Explore side streets for quieter dining options',
      ],
    },
    'Beng Mealea Temple': {
      'fullDescription':
          'Beng Mealea is a spectacular jungle temple located 40km east of the main Angkor complex, offering an authentic "Indiana Jones" adventure. Built in the 12th century during the reign of King Suryavarman II, this massive temple covers over one square kilometer but remains largely unrestored and overgrown. Walking through Beng Mealea is like stepping into the 19th century when explorers first discovered Angkor. Trees grow through roofs, collapsed galleries create tunnels to crawl through, and hidden carvings emerge from beneath vines. Wooden walkways now guide visitors through the ruins, allowing access while protecting the delicate structures. The lack of crowds makes exploration peaceful and personal. You can spend hours discovering hidden libraries, collapsed towers, and intricate lintel carvings that match Angkor Wat in quality. The temple\'s remote location means fewer tourists, giving you a sense of discovery rarely felt at more famous sites. The separate entrance fee keeps visitor numbers low, enhancing the jungle temple atmosphere.',
      'openingHours': '7:00 AM - 5:00 PM daily',
      'entryFee': '\$5 USD (separate from Angkor pass)',
      'bestTime': 'Morning (8:00-10:00 AM) to avoid afternoon heat',
      'duration': '1.5-2.5 hours',
      'highlights': [
        'Unrestored temple complex',
        'Dramatic jungle overgrowth',
        'Fewer tourists than main Angkor sites',
        'Wooden walkways through ruins',
        'Adventure-style exploration',
      ],
      'tips': [
        'Requires separate entrance fee',
        'Hire transport (tuk-tuk or taxi)',
        'Bring water and snacks',
        'Wear sturdy shoes for walking on uneven surfaces',
        'Allow 1 hour travel time from Siem Reap',
      ],
    },

    // BATTAMBANG
    'Bamboo Train': {
      'fullDescription':
          'The Bamboo Train (Norry) is one of Cambodia\'s most unique and thrilling experiences. This improvised transport system consists of a bamboo platform mounted on wheels, powered by a small gasoline engine. Passengers sit on thin mats as the platform rattles along old French colonial railway tracks at speeds up to 40 km/h. The 7-kilometer journey passes through rice paddies, small villages, and open countryside, offering glimpses of rural Cambodian life. The most exciting part comes when two bamboo trains meet on the single track - the lighter loaded train must be quickly dismantled and removed from the tracks to let the other pass, then reassembled to continue. While the train has been relocated to a dedicated tourist track to preserve this experience (the original tracks are now used by regular trains), it remains a fun and memorable adventure. The open-air ride provides cool breezes and photo opportunities, making it perfect for families and adventure seekers alike.',
      'openingHours': '7:00 AM - 5:00 PM daily',
      'entryFee': '\$5 USD per person round trip',
      'bestTime':
          'Early morning (7:00-9:00 AM) or late afternoon (3:00-5:00 PM)',
      'duration': '30-45 minutes round trip',
      'highlights': [
        'Unique bamboo railway experience',
        'Countryside and rice paddy views',
        'Traditional village life observations',
        'Fun for all ages',
        'Photo opportunities',
      ],
      'tips': [
        'Wear sunglasses for dust protection',
        'Hold on tight - it can be bumpy',
        'Bring sunscreen and hat',
        'Small refreshment stop at the end',
        'Tuk-tuk can drop you directly at station',
      ],
    },
    'Phnom Sampeau': {
      'fullDescription':
          'Phnom Sampeau is a limestone mountain rising 100 meters above the rice paddies south of Battambang, crowned with temples and offering spectacular views. The site holds both natural beauty and dark history. Wat Sampeau at the summit provides panoramic vistas of the surrounding countryside. Below are the Killing Caves, where the Khmer Rouge executed thousands of people by throwing them through a skylight into natural caverns - a sobering memorial with a reclining Buddha and glass-sided stupa containing bones of victims. However, Phnom Sampeau is most famous for its nightly bat exodus. Around sunset, millions of wrinkle-lipped bats stream out of caves in the mountain in a spiral formation, creating a black ribbon across the sky for 30-40 minutes. This natural phenomenon attracts photographers and nature enthusiasts from around the world. The mountain also features several active temples where monks live and meditate, adding spiritual significance to the site.',
      'openingHours': '6:00 AM - 6:00 PM daily',
      'entryFee': '\$2-3 USD',
      'bestTime': 'Late afternoon (4:30 PM arrival) for bats at sunset',
      'duration': '2-3 hours',
      'highlights': [
        'Spectacular bat exodus at sunset (5:30-6:00 PM)',
        'Temple ruins with panoramic views',
        'Killing Caves memorial',
        'Active Buddhist temples',
        'Countryside panoramas',
      ],
      'tips': [
        'Arrive by 5:30 PM for bat viewing',
        'Bring water for the climb',
        'Respectful dress for temple areas',
        'Hire a moto or tuk-tuk (bike taxi available)',
        'Combine with Bamboo Train visit',
      ],
    },
    'Colonial Buildings': {
      'fullDescription':
          'Battambang boasts some of Cambodia\'s best-preserved French colonial architecture, earning it recognition as a UNESCO Creative City. The city\'s golden age was the 1920s-1930s when wealthy rice traders and French administrators built elegant mansions, shophouses, and public buildings. Walking through the old town reveals a treasure trove of architectural styles: Art Deco shophouses with colorful facades, colonial mansions with shuttered windows and balconies, and the iconic Governor\'s Residence. The riverside area features perfectly preserved blocks of two-story buildings with Chinese-French fusion design. Many structures have been beautifully restored and now house cafes, restaurants, galleries, and guesthouses. The morning and late afternoon light brings out the pastel colors of these buildings, making them perfect for photography. Several walking tour companies offer architectural tours with knowledgeable guides who explain the history and design elements. The colonial quarter\'s cafe culture is thriving, with European-style cafes serving excellent coffee in beautiful historical settings.',
      'openingHours':
          'Buildings viewable anytime; cafes typically 7:00 AM - 9:00 PM',
      'entryFee': 'Free to view; cafe purchases optional',
      'bestTime':
          'Early morning (7:00-9:00 AM) or late afternoon (4:00-6:00 PM)',
      'duration': '1.5-3 hours',
      'highlights': [
        '1920s-1930s French colonial architecture',
        'Art Deco shophouses',
        'Riverside colonial mansions',
        'Heritage cafes and restaurants',
        'Walking tour opportunities',
      ],
      'tips': [
        'Explore on foot or by bicycle',
        'Stop for coffee at heritage cafes',
        'Best photos in morning golden light',
        'Join a walking tour for historical context',
        'Riverside area is most photogenic',
      ],
    },
    'Bat Caves': {
      'fullDescription':
          'The Bat Caves of Phnom Sampeau contain one of Southeast Asia\'s largest bat colonies, with an estimated 2-3 million wrinkle-lipped bats roosting in the mountain\'s limestone caverns. Every evening at sunset, these bats emerge in a spectacular exodus that lasts 30-45 minutes. The bats exit through several cave openings, forming a spiraling black ribbon that stretches across the sky as they head out to feed on insects over the rice paddies. The formation can extend for several kilometers, creating one of nature\'s most impressive displays. Scientists estimate the bats consume several tons of insects nightly, providing natural pest control for local farmers. Viewing platforms near the cave entrances offer the best vantage points, though the sight is visible from throughout the valley. The phenomenon occurs year-round but is most spectacular during the dry season (November-April) when clear skies provide perfect viewing conditions. Local vendors sell snacks and drinks at viewing areas, making it a social evening event.',
      'openingHours': 'Viewing time: 5:30-6:30 PM daily',
      'entryFee': 'Included with Phnom Sampeau entry fee',
      'bestTime': 'Arrive 5:15-5:30 PM for best viewing positions',
      'duration': '45 minutes - 1 hour',
      'highlights': [
        'Millions of bats in spiral formation',
        'Natural pest control demonstration',
        'Sunset backdrop',
        'Year-round phenomenon',
        'Photography opportunities',
      ],
      'tips': [
        'Arrive 30 minutes before sunset',
        'Bring camera with good zoom lens',
        'Best viewing from designated platforms',
        'Combine with temple visit earlier',
        'Bug spray recommended for mosquitoes',
      ],
    },

    // SIHANOUKVILLE
    'Koh Rong Samloem': {
      'fullDescription':
          'Koh Rong Samloem is a pristine island paradise in the Gulf of Thailand, known for its crystal-clear turquoise waters, powdery white sand beaches, and abundant marine life. The island remains relatively undeveloped compared to its sister island Koh Rong, making it perfect for those seeking tranquility. Saracen Bay offers the most facilities with beachfront bungalows and restaurants, while Lazy Beach and Sunset Beach provide more secluded experiences. The island is famous for bioluminescent plankton that lights up the water at night - swimming through the glowing blue water is an unforgettable experience. Snorkeling and diving reveal vibrant coral reefs teeming with tropical fish. Jungle trails connect the beaches, offering chances to spot wildlife. The slow pace of island life, lack of roads and vehicles, and stunning natural beauty make Koh Rong Samloem a perfect escape from modern life.',
      'openingHours': 'Island accessible 24/7',
      'entryFee': 'Boat fare: \$10-25 USD round trip (depending on speed)',
      'bestTime': 'November to April (dry season)',
      'duration': 'Recommended: 2-3 days minimum',
      'highlights': [
        'Crystal clear turquoise waters',
        'Bioluminescent plankton at night',
        'Excellent snorkeling and diving',
        'Pristine white sand beaches',
        'Peaceful, undeveloped atmosphere',
      ],
      'tips': [
        'Book accommodation in advance during peak season',
        'Bring enough cash - limited ATMs',
        'Pack reef-safe sunscreen',
        'Bring snorkeling gear if possible',
        'Night swimming for bioluminescence (dark moon nights best)',
      ],
    },

    // KAMPOT
    'Bokor Mountain': {
      'fullDescription':
          'Bokor Mountain rises 1,080 meters above sea level in Bokor National Park, offering dramatically cooler temperatures and misty landscapes. The mountain is famous for its abandoned French colonial hill station, including the iconic Bokor Palace Hotel and casino, now partially restored as a luxury resort. The eerily atmospheric abandoned buildings, often shrouded in fog, have appeared in numerous films. The mountain road offers spectacular views over the Cambodian coastline and provides access to Popokvil Waterfall. The summit features a Buddhist temple with panoramic views on clear days. The cooler climate makes this a refreshing escape from coastal heat, though fog can obscure views. The park protects rare wildlife including tigers, elephants, and Asian black bears, though sightings are extremely rare. The winding mountain road itself is an adventure, passing through dense jungle and offering viewpoints over the valleys below.',
      'openingHours': '7:00 AM - 6:00 PM daily',
      'entryFee': '\$5-10 USD (park entrance)',
      'bestTime': 'Dry season (November-March) for clearest views',
      'duration': 'Full day trip',
      'highlights': [
        'Abandoned French colonial buildings',
        'Dramatic coastal views',
        'Cooler mountain climate',
        'Popokvil Waterfall',
        'Atmospheric fog and mist',
      ],
      'tips': [
        'Bring warm jacket (can be 10°C cooler than coast)',
        'Hire transport (moto or car)',
        'Morning visits have clearer views',
        'Fog can obscure views in afternoon',
        'Combine with waterfall visit',
      ],
    },

    'Kep Beach': {
      'fullDescription':
          'Kep Beach offers a tranquil seaside retreat with the iconic Kep statues (Dancing Lady and the Crab) creating picture-perfect moments. Unlike the sandy beaches of Sihanoukville, Kep features a rocky coastline with calm waters perfect for swimming. The beachfront promenade is ideal for evening strolls, with food vendors selling grilled seafood and tropical fruits. The famous Crab Market is just a short walk away, offering the freshest seafood in Cambodia. Kep\'s laid-back atmosphere attracts those seeking relaxation rather than beach parties. The sunsets over the Gulf of Thailand are spectacular, with Rabbit Island visible in the distance. Beach clubs and restaurants line the shore, offering everything from budget local food to upscale dining experiences. The area is also great for cycling, with flat coastal roads providing easy exploration of the town.',
      'openingHours': 'Open 24/7',
      'entryFee': 'Free',
      'bestTime': 'November to May (dry season)',
      'duration': 'Half day to full day',
      'highlights': [
        'Iconic Kep statues for photos',
        'Calm waters for swimming',
        'Relaxed, uncrowded atmosphere',
        'Beautiful sunset views',
        'Easy access to Crab Market',
      ],
      'tips': [
        'Bring beach towel',
        'Try seafood at local restaurants',
        'Best for relaxation, not watersports',
        'Rent bicycle to explore town',
        'Visit Crab Market for lunch',
      ],
    },
  };

  Color get bgColor => isDark
      ? const Color(0xFF0A0E27)
      : const Color.fromARGB(255, 245, 232, 210);

  Color get textColor => isDark ? Colors.white : const Color(0xFF2C1810);
  Color get cardBg =>
      isDark ? const Color.fromARGB(255, 14, 14, 16) : Colors.white;
  Color get borderColor =>
      isDark ? const Color(0xFF64B5F6) : const Color(0xFFD4A574);

  Color get accentColor =>
      isDark ? const Color(0xFF64B5F6) : const Color(0xFFB8860B);

  Map<String, dynamic> getPlaceDetails() {
    final String placeName = currentPlace['name']; // Use currentPlace
    return placeDetails[placeName] ??
        {
          'fullDescription':
              '${currentPlace['name']} is a remarkable destination showcasing Cambodia\'s rich cultural heritage and natural beauty. This location offers visitors a unique opportunity to explore traditional Cambodian life, stunning landscapes, and historical significance. Whether you\'re interested in ancient temples, natural wonders, or cultural experiences, this destination provides an authentic glimpse into the heart of Cambodia. The area is well-suited for travelers seeking both adventure and relaxation, with various activities available throughout the year.',
          'openingHours': '8:00 AM - 5:00 PM daily',
          'entryFee': 'Varies (typically \$2-5 USD)',
          'bestTime': 'Morning or late afternoon during dry season',
          'duration': '2-3 hours',
          'highlights': [
            'Authentic Cambodian cultural experience',
            'Beautiful natural scenery',
            'Great photo opportunities',
            'Local artisan demonstrations',
            'Traditional architecture',
          ],
          'tips': [
            'Wear comfortable walking shoes',
            'Bring water and sun protection',
            'Respect local customs and traditions',
            'Best visited during dry season (November-April)',
            'Consider hiring a local guide',
          ],
        };
  }

  Future<void> _openGoogleMaps() async {
    final String locationName =
        '${currentPlace['name']}, ${widget.provinceName}'; // Use currentPlace
    final String encodedLocation = Uri.encodeComponent(locationName);
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
        ),
      );
    }
  }

  void _toggleFavorite() {
    setState(() {
      // Toggle favorite status
      currentPlace['fav'] = !(currentPlace['fav'] ?? false);

      // Add/remove saved date
      if (currentPlace['fav']) {
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
        currentPlace['savedDate'] =
            '${months[now.month - 1]} ${now.day}, ${now.year}';
      } else {
        currentPlace['savedDate'] = null;
        currentPlace['visited'] = false;
      }
    });

    // Call the callback to update parent
    if (widget.onFavoriteUpdated != null) {
      widget.onFavoriteUpdated!(currentPlace);
    }

    // Also call the old callback if it exists
    widget.onToggleFavorite?.call();

    // Show snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          currentPlace['fav'] == true
              ? '${currentPlace['name']} added to favorites!'
              : '${currentPlace['name']} removed from favorites',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: currentPlace['fav'] == true
            ? accentColor
            : Colors.grey[700],
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final details = getPlaceDetails();
    final bool isFavorite = currentPlace['fav'] ?? false;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Pass the updated place back when navigating back
                      if (widget.onFavoriteUpdated != null) {
                        widget.onFavoriteUpdated!(currentPlace);
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
                      widget.provinceName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // HERO IMAGE CARD
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 8, 14, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: cardBg,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: borderColor.withOpacity(0.3),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: borderColor.withOpacity(0.15),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              child: Stack(
                                children: [
                                  Image.asset(
                                    currentPlace['image'],
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 180,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        height: 180,
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
                                            Icons.place_rounded,
                                            size: 48,
                                            color: accentColor.withOpacity(0.5),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  Container(
                                    height: 180,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black.withOpacity(0.3),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // HEART BUTTON
                                  Positioned(
                                    top: 14,
                                    right: 14,
                                    child: GestureDetector(
                                      onTap: _toggleFavorite,
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
                                          isFavorite
                                              ? Icons.favorite_rounded
                                              : Icons.favorite_border_rounded,
                                          color: isFavorite
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
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          currentPlace['name'],
                                          style: TextStyle(
                                            color: textColor,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: -0.5,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: accentColor.withOpacity(0.15),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color: accentColor.withOpacity(0.3),
                                            width: 1.5,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.location_city_rounded,
                                              color: accentColor,
                                              size: 14,
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              widget.provinceName,
                                              style: TextStyle(
                                                color: accentColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_rounded,
                                        size: 16,
                                        color: textColor.withOpacity(0.6),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        '${widget.provinceName}, Cambodia',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: textColor.withOpacity(0.7),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // INFO CARDS
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildInfoCard(
                              Icons.access_time_rounded,
                              'Duration',
                              details['duration'],
                              Colors.blue,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildInfoCard(
                              Icons.attach_money_rounded,
                              'Entry Fee',
                              details['entryFee'],
                              Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildInfoCard(
                              Icons.schedule_rounded,
                              'Best Time',
                              details['bestTime'],
                              Colors.orange,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: GestureDetector(
                              onTap: _openGoogleMaps,
                              child: _buildInfoCard(
                                Icons.location_on_rounded,
                                'Location',
                                'View Map',
                                Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ABOUT SECTION
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Container(
                        padding: const EdgeInsets.all(14),
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
                                  "About",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: textColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              showFullDescription
                                  ? details['fullDescription']
                                  : details['fullDescription'].length > 200
                                  ? '${details['fullDescription'].substring(0, 200)}...'
                                  : details['fullDescription'],
                              style: TextStyle(
                                fontSize: 13,
                                color: textColor.withOpacity(0.8),
                                height: 1.5,
                              ),
                            ),
                            if (details['fullDescription'].length > 200)
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
                                      fontSize: 13,
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

                    const SizedBox(height: 16),

                    // HIGHLIGHTS
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.stars_rounded,
                                color: accentColor,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "Highlights",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          ...List.generate(
                            details['highlights'].length,
                            (index) => Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 6),
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: accentColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      details['highlights'][index],
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: textColor.withOpacity(0.8),
                                        height: 1.4,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // VISITOR TIPS
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.lightbulb_outline_rounded,
                                color: accentColor,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "Visitor Tips",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          ...List.generate(
                            details['tips'].length,
                            (index) => Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: cardBg,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: borderColor.withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.check_circle_outline_rounded,
                                      color: accentColor,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        details['tips'][index],
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: textColor.withOpacity(0.8),
                                          height: 1.4,
                                        ),
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

                    const SizedBox(height: 16),

                    // OPENING HOURS
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: cardBg,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: borderColor.withOpacity(0.3),
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: accentColor.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.access_time_rounded,
                                color: accentColor,
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Opening Hours",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: textColor,
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    details['openingHours'],
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: textColor.withOpacity(0.7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    IconData icon,
    String label,
    String value,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor.withOpacity(0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: borderColor.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: textColor.withOpacity(0.6),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
