import 'package:flutter/material.dart';
import 'package:oldschool_strike/widgets/left_drawer.dart';
import 'package:oldschool_strike/widgets/product_card.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final String nama = "Gust Niera"; //nama
  final String npm = "2406496403"; //npm
  final String kelas = "A"; //kelas
  final List<ItemHomepage> items = [
    ItemHomepage(
      "All Products₊˚⊹♡",
      Icons.storefront,
      const Color(0xFF628ECB), // #628ECB (biru)
      Colors.white,
    ),
    ItemHomepage(
      "My Products(˶ˆ꒳ˆ˵)",
      Icons.inventory_2,
      const Color(0xFF9FE3B6), // #9fe3b6 (hijau)
      Colors.white,
    ),
    ItemHomepage(
      "Create Product",
      Icons.add_circle_outline,
      const Color(0xFFBD4A55), // #bd4a55 (merah)
      Colors.white,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ᯓ⚽︎LDSCHOOL STRIKEᯓ',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            letterSpacing: 0.5,
          ),
        ),
        backgroundColor: const Color(0xFF395886),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: LeftDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF395886), Color(0xFFD5DEEF), Color(0xFFEAF6FF)],
            stops: [0.0, 0.3, 1.0],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Section with Info Cards
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // Info Cards Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: InfoCard(title: 'NPM', content: npm),
                        ),
                        const SizedBox(width: 12.0),
                        Expanded(
                          child: InfoCard(title: 'Name', content: nama),
                        ),
                        const SizedBox(width: 12.0),
                        Expanded(
                          child: InfoCard(title: 'Class', content: kelas),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Welcome Message
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.waving_hand,
                      color: Color(0xFF395886),
                      size: 28.0,
                    ),
                    SizedBox(width: 12.0),
                    Expanded(
                      child: Text(
                        'Selamat datang di Oldschool Strikeᕙ( •̀ ᗜ •́ )ᕗ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: Color(0xFF395886),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24.0),

              // Action Buttons Grid
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.85,
                  children: items.map((ItemHomepage item) {
                    return ItemCard(item);
                  }).toList(),
                ),
              ),

              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12.0,
              color: Color(0xFF628ECB),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            content,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              color: Color(0xFF395886),
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}

class ItemHomepage {
  final String name;
  final IconData icon;
  final Color bgColor;
  final Color textColor;

  ItemHomepage(this.name, this.icon, this.bgColor, this.textColor);
}
