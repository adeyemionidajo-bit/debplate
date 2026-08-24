import 'package:flutter/material.dart';

void main() => runApp(const DubplateApp());

class DubplateApp extends StatelessWidget {
  const DubplateApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'DUBPLATE',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF08080B),
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF9B5CFF), brightness: Brightness.dark),
      useMaterial3: true,
    ),
    home: const DubplateShell(),
  );
}

class Track {
  final String title, artist, symbol;
  const Track(this.title, this.artist, this.symbol);
}

const tracks = [
  Track('New Sound', 'DUB Artist', '♫'),
  Track('Midnight', 'Nova', '◉'),
  Track('Energy', 'Kairo', '⚡'),
  Track('After Rain', 'Maya', '☼'),
  Track('Lagos Nights', 'The Wave', '◌'),
];

class DubplateShell extends StatefulWidget {
  const DubplateShell({super.key});
  @override State<DubplateShell> createState() => _DubplateShellState();
}

class _DubplateShellState extends State<DubplateShell> {
  int tab = 0;
  int? selected;
  bool playing = false;

  void play(int index) => setState(() { selected = index; playing = true; });

  @override
  Widget build(BuildContext context) {
    final pages = [_home(), _explore(), _library(), _profile()];
    return Scaffold(
      body: SafeArea(child: pages[tab]),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (selected != null) _miniPlayer(),
          NavigationBar(
            selectedIndex: tab,
            onDestinationSelected: (i) => setState(() => tab = i),
            backgroundColor: const Color(0xFF101015),
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

  Widget _home() => CustomScrollView(slivers: [
    SliverPadding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 30),
      sliver: SliverList(delegate: SliverChildListDelegate([
        Row(children: [
          const Expanded(child: Text('DUBPLATE', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900, letterSpacing: 3))),
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none)),
        ]),
        const SizedBox(height: 26),
        const Text('Music before\nthe world hears it.', style: TextStyle(fontSize: 38, height: 1, fontWeight: FontWeight.w900)),
        const SizedBox(height: 12),
        Text('Discover artists, new sounds and exclusive pre-releases.', style: TextStyle(color: Colors.grey.shade400, fontSize: 16)),
        const SizedBox(height: 25),
        _searchBox(),
        const SizedBox(height: 30),
        _heading('Trending now', 'See all'),
        const SizedBox(height: 14),
        SizedBox(height: 225, child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: tracks.length,
          separatorBuilder: (_, __) => const SizedBox(width: 14),
          itemBuilder: (_, i) => GestureDetector(
            onTap: () => play(i),
            child: SizedBox(width: 165, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _cover(tracks[i].symbol, 165),
              const SizedBox(height: 9),
              Text(tracks[i].title, style: const TextStyle(fontWeight: FontWeight.w800)),
              const SizedBox(height: 3),
              Text(tracks[i].artist, style: TextStyle(color: Colors.grey.shade500)),
            ])),
          ),
        )),
        const SizedBox(height: 25),
        _heading('Coming soon', 'View all'),
        const SizedBox(height: 14),
        GestureDetector(onTap: () => play(0), child: _preRelease()),
        const SizedBox(height: 28),
        _heading('Browse genres', ''),
        const SizedBox(height: 14),
        Wrap(spacing: 9, runSpacing: 9, children: ['Afrobeats','Hip-Hop','Gospel','Amapiano','R&B','Pop','Reggae','Jazz']
          .map((g) => Chip(label: Text(g), backgroundColor: const Color(0xFF17171E))).toList()),
      ])),
    ),
  ]);

  Widget _explore() => _page(Icons.explore_outlined, 'Explore', 'Search and discover songs, albums, artists and genres.');
  Widget _library() => _page(Icons.library_music_outlined, 'Your Library', 'Liked music, purchases, playlists and saved pre-releases will appear here.');
  Widget _profile() => _page(Icons.person_outline, 'Profile', 'Your DUBPLATE listener and artist profile will live here.');

  Widget _page(IconData icon, String title, String subtitle) => Center(
    child: Padding(
      padding: const EdgeInsets.all(28),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(icon, size: 65, color: const Color(0xFFB37AFF)),
        const SizedBox(height: 18),
        Text(title, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900)),
        const SizedBox(height: 10),
        Text(subtitle, textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade500, fontSize: 16)),
      ]),
    ),
  );

  Widget _searchBox() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(color: const Color(0xFF15151B), borderRadius: BorderRadius.circular(16)),
    child: const TextField(
      decoration: InputDecoration(border: InputBorder.none, icon: Icon(Icons.search), hintText: 'Search songs, artists, albums...'),
    ),
  );

  Widget _heading(String a, String b) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [Text(a, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w900)), if (b.isNotEmpty) Text(b, style: const TextStyle(color: Color(0xFFB37AFF)))],
  );

  Widget _cover(String symbol, double size) => Container(
    width: size, height: size,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: const LinearGradient(colors: [Color(0xFF7C3AED), Color(0xFF17101F)], begin: Alignment.topLeft, end: Alignment.bottomRight),
    ),
    child: Center(child: Text(symbol, style: TextStyle(fontSize: size * .28, fontWeight: FontWeight.w900))),
  );

  Widget _preRelease() => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(22),
      gradient: const LinearGradient(colors: [Color(0xFF27113F), Color(0xFF111116)]),
      border: Border.all(color: const Color(0xFF45275F)),
    ),
    child: Row(children: [
      _cover('♫', 92),
      const SizedBox(width: 14),
      const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('PRE-RELEASE', style: TextStyle(color: Color(0xFFC084FC), fontWeight: FontWeight.w900, fontSize: 11, letterSpacing: 1.3)),
        SizedBox(height: 5),
        Text('My New Sound', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
        SizedBox(height: 4),
        Text('Artist Name', style: TextStyle(color: Colors.grey)),
        SizedBox(height: 7),
        Text('Release countdown • 15 days', style: TextStyle(color: Colors.white70, fontSize: 12)),
      ])),
      const Icon(Icons.chevron_right),
    ]),
  );

  Widget _miniPlayer() {
    final t = tracks[selected!];
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 6, 10, 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(color: const Color(0xFF17171D), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFF292932))),
      child: Row(children: [
        _cover(t.symbol, 45),
        const SizedBox(width: 10),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(t.title, style: const TextStyle(fontWeight: FontWeight.w800)),
          Text(t.artist, style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
        ])),
        IconButton(onPressed: () => setState(() => playing = !playing), icon: Icon(playing ? Icons.pause_circle_filled : Icons.play_circle_fill, size: 32)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.skip_next)),
      ]),
    );
  }
}
