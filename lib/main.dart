import 'package:flutter/material.dart';

void main() => runApp(const DubplateApp());

class DubplateApp extends StatelessWidget {
  const DubplateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DUBPLATE',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF09090B),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF3D71),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  bool isPlaying = false;

  final titles = ['New Sound', 'Midnight Drive', 'Energy', 'After Rain', 'Lagos Nights'];
  final artists = ['DUB Artist', 'Nova', 'Kairo', 'Maya', 'The Wave'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('DUBPLATE', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded)),
          const Padding(padding: EdgeInsets.only(right: 12), child: CircleAvatar(radius: 17, child: Text('D'))),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 120),
        children: [
          const Text('Music before the world hears it.', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          Text('Discover artists, new sounds and exclusive pre-releases.', style: TextStyle(color: Colors.white.withOpacity(.65))),
          const SizedBox(height: 28),
          const SectionTitle('Trending now'),
          const SizedBox(height: 14),
          SizedBox(
            height: 190,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: titles.length,
              separatorBuilder: (_, __) => const SizedBox(width: 14),
              itemBuilder: (_, i) => GestureDetector(
                onTap: () => setState(() => isPlaying = true),
                child: MusicCard(title: titles[i], artist: artists[i], index: i),
              ),
            ),
          ),
          const SizedBox(height: 30),
          const SectionTitle('Coming soon'),
          const SizedBox(height: 14),
          GestureDetector(
            onTap: () => setState(() => isPlaying = true),
            child: const PreReleaseCard(),
          ),
          const SizedBox(height: 30),
          const SectionTitle('Genres'),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: ['Afrobeats', 'Hip-Hop', 'Gospel', 'Amapiano', 'R&B', 'Pop', 'Reggae', 'Jazz']
                .map((g) => Chip(label: Text(g)))
                .toList(),
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isPlaying)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(color: const Color(0xFF1A1A1D), borderRadius: BorderRadius.circular(15)),
              child: Row(children: [
                const Icon(Icons.album_rounded, size: 38),
                const SizedBox(width: 10),
                const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Midnight Drive', style: TextStyle(fontWeight: FontWeight.bold)), Text('Nova', style: TextStyle(color: Colors.white54, fontSize: 11))])),
                IconButton(onPressed: () => setState(() => isPlaying = !isPlaying), icon: Icon(isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.skip_next)),
              ]),
            ),
          NavigationBar(
            selectedIndex: selectedIndex,
            onDestinationSelected: (index) => setState(() => selectedIndex = index),
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
              NavigationDestination(icon: Icon(Icons.explore_outlined), selectedIcon: Icon(Icons.explore), label: 'Explore'),
              NavigationDestination(icon: Icon(Icons.library_music_outlined), selectedIcon: Icon(Icons.library_music), label: 'Library'),
              NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
            ],
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle(this.title, {super.key});
  @override
  Widget build(BuildContext context) => Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800));
}

class MusicCard extends StatelessWidget {
  final String title;
  final String artist;
  final int index;
  const MusicCard({required this.title, required this.artist, required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    final icons = [Icons.music_note_rounded, Icons.nightlight_round, Icons.bolt_rounded, Icons.water_drop_rounded, Icons.location_city_rounded];
    return SizedBox(
      width: 145,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: 145,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.pink.shade700, Colors.deepPurple.shade900, Colors.black]),
          ),
          child: Center(child: Icon(icons[index], size: 54)),
        ),
        const SizedBox(height: 8),
        Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(artist, style: TextStyle(color: Colors.white.withOpacity(.55))),
      ]),
    );
  }
}

class PreReleaseCard extends StatelessWidget {
  const PreReleaseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(22), gradient: const LinearGradient(colors: [Color(0xFF3D1028), Color(0xFF111113)])),
      child: Row(children: [
        Container(width: 92, height: 92, decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.black54), child: const Icon(Icons.album_rounded, size: 42)),
        const SizedBox(width: 15),
        const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('PRE-RELEASE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.4, color: Color(0xFFFF6B91))),
          SizedBox(height: 6),
          Text('My New Sound', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
          Text('Artist Name'),
          SizedBox(height: 8),
          Text('Release countdown • 15 days'),
        ])),
        const Icon(Icons.chevron_right_rounded),
      ]),
    );
  }
}
