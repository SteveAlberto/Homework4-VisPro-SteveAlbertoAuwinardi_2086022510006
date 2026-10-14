import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'models.dart';

final List<Langganan> kMenuNormal = [
  Langganan('Netflix Premium', 47000, 5, [
    Anggota('Saya', true), Anggota('Andi', true), Anggota('Budi', false),
  ]),
  Langganan('Spotify Family', 29000, 12, [
    Anggota('Saya', true), Anggota('Andi', true),
  ]),
];

final List<Langganan> kLongNameData = [
  Langganan(
      'Langganan Layanan Streaming Film dan Serial Televisi Internasional Netflix Paket Premium Ultra HD 4K Berbagi Bersama Teman Kosan dan Mahasiswa Jurusan Sistem Informasi Angkatan 2026 Semester Genap',
      186000, 1,
      [Anggota('Nama Anggota Pertama Yang Sangat Panjang Sekali Hingga Melebihi Batas Wajar Dan Mungkin Akan Menyebabkan Overflow Jika Tidak Ditangani Dengan Benar Menggunakan MaxLines Dan TextOverflow Ellipsis Pada ListTile', true)]),
  ...kMenuNormal,
];

final List<Langganan> kBigData = List<Langganan>.generate(500, (i) => Langganan(
    'Langganan ${i + 1}', 50000, 1, [Anggota('A', false), Anggota('B', true)]));

enum _Device {
  small('Small phone', Size(320, 568)),
  large('Large phone', Size(430, 932)),
  tablet('Tablet', Size(800, 1280));

  const _Device(this.label, this.size);
  final String label;
  final Size size;
}

enum _Data {
  normal('Normal'),
  longName('200-char name'),
  empty('Zero items'),
  big('500 items');

  const _Data(this.label);
  final String label;

  List<Langganan> get items => switch (this) {
        _Data.normal => kMenuNormal,
        _Data.longName => kLongNameData,
        _Data.empty => const <Langganan>[],
        _Data.big => kBigData,
      };
}

class LabHarness extends StatefulWidget {
  const LabHarness({super.key});
  @override
  State<LabHarness> createState() => _LabHarnessState();
}

class _LabHarnessState extends State<LabHarness> {
  _Device _device = _Device.small;
  _Data _data = _Data.normal;
  bool _landscape = false;
  bool _keyboard = false;
  bool _dark = false;
  bool _insets = false;

  Size get _screen => _landscape ? _device.size.flipped : _device.size;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: const Color(0xFF00897B)),
      home: Builder(
        builder: (context) => Scaffold(
          body: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(width: 280, child: _panel(context)),
                const VerticalDivider(width: 1),
                Expanded(child: _stage(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _panel(BuildContext context) {
    Widget group(String title, List<Widget> chips) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            Wrap(spacing: 8, runSpacing: 8, children: chips),
          ],
        ),
      );
    }
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        group('Screen', _Device.values.map((d) => ChoiceChip(
          label: Text(d.label), selected: _device == d, onSelected: (_) => setState(() => _device = d))).toList()),
        group('Orientation', [
          ChoiceChip(label: const Text('Portrait'), selected: !_landscape, onSelected: (_) => setState(() => _landscape = false)),
          ChoiceChip(label: const Text('Landscape'), selected: _landscape, onSelected: (_) => setState(() => _landscape = true)),
        ]),
        group('Data', _Data.values.map((d) => ChoiceChip(
          label: Text(d.label), selected: _data == d, onSelected: (_) => setState(() => _data = d))).toList()),
        group('Conditions', [
          FilterChip(label: const Text('Keyboard open'), selected: _keyboard, onSelected: (v) => setState(() => _keyboard = v)),
          FilterChip(label: const Text('Dark mode'), selected: _dark, onSelected: (v) => setState(() => _dark = v)),
        ]),
      ],
    );
  }

  Widget _stage(BuildContext context) {
    final size = _screen;
    final keyboard = _keyboard ? (_landscape ? 180.0 : 260.0) : 0.0;
    final media = MediaQuery.of(context).copyWith(size: size, viewInsets: EdgeInsets.only(bottom: keyboard));

    return ColoredBox(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox.fromSize(
                size: size,
                child: MediaQuery(
                  data: media,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: MyApp(
                          key: ValueKey(_data),
                          initialData: _data.items,
                          themeMode: _dark ? ThemeMode.dark : ThemeMode.light,
                        ),
                      ),
                      if (keyboard > 0)
                        Positioned(
                          left: 0, right: 0, bottom: 0, height: keyboard,
                          child: const ColoredBox(color: Colors.black87),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}