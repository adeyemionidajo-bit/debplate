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
          seedColor: const Color(0xFF7C3AED),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'DUBPLATE',
          style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded)),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CircleAvatar(
              radius: 17,
              child: Text('D', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
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
              itemCount: 5,
              separatorBuilder: (_, __) => const SizedBox(width: 14),
              itemBuilder: (_, i) => MusicCard(index: i),
            ),
          ),
          const SizedBox(height: 30),
          const SectionTitle('Coming soon'),
          const SizedBox(height: 14),
          const PreReleaseCard(),
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
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.explore_outlined), selectedIcon: Icon(Icons.explore), label: 'Explore'),
          NavigationDestination(icon: Icon(Icons.library_music_outlined), selectedIcon: Icon(Icons.library_music), label: 'Library'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
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
  final int index;
  const MusicCard({required this.index, super.key});
  @override
  Widget build(BuildContext context) {
    final titles = ['New Sound', 'Midnight', 'Energy', 'After Rain', 'Lagos Nights'];
    final artists = ['DUB Artist', 'Nova', 'Kairo', 'Maya', 'The Wave'];
    return SizedBox(
      width: 145,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: 145,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.deepPurple.shade700, Colors.black]),
          ),
          child: const Center(child: Icon(Icons.music_note_rounded, size: 54)),
        ),
        const SizedBox(height: 8),
        Text(titles[index], maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(artists[index], style: TextStyle(color: Colors.white.withOpacity(.55))),
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
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(22), gradient: const LinearGradient(colors: [Color(0xFF29134D), Color(0xFF111113)])),
      child: Row(children: [
        Container(width: 92, height: 92, decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.black54), child: const Icon(Icons.album_rounded, size: 42)),
        const SizedBox(width: 15),
        const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('PRE-RELEASE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.4)),
          SizedBox(height: 6),
          Text('My New Sound', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
          Text('Artist Name'),
          SizedBox(height: 8),
          Text('Release countdown • 15 days'),
        ])),
        Icon(Icons.chevron_right_rounded),
      ]),
    );
  }
}
