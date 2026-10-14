import 'package:flutter/material.dart';
import 'models.dart';

class LayarDetail extends StatefulWidget {
  final Langganan langganan;
  final Function() onUbah;

  const LayarDetail({super.key, required this.langganan, required this.onUbah});

  @override
  State<LayarDetail> createState() => _LayarDetailState();
}

class _LayarDetailState extends State<LayarDetail> {
  @override
  Widget build(BuildContext context) {
    final l = widget.langganan;
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(l.nama)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card.filled(
            color: scheme.primaryContainer,
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${l.hitungSudahBayar()} dari ${l.anggota.length} sudah bayar',
                    style: text.headlineMedium?.copyWith(
                      color: scheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: l.hitungSudahBayar() / l.anggota.length,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Iuran Rp ${l.hitungIuran()} / orang • tagihan tiap tanggal ${l.tanggalTagihan}',
                    style: text.bodyMedium
                        ?.copyWith(color: scheme.onPrimaryContainer),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('Status Anggota', style: text.titleMedium),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: l.anggota.length,
              itemBuilder: (context, index) {
                final a = l.anggota[index];
                return CheckboxListTile(
                  value: a.sudahBayar,
                  title: Text(a.nama),
                  subtitle: Text(a.sudahBayar ? 'Sudah bayar' : 'Belum bayar'),
                  onChanged: (nilai) {
                    setState(() {
                      a.sudahBayar = nilai!;
                    });
                    widget.onUbah();
                  },
                );
              },
            ),
          ),
          if (!l.sudahLunas())
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton.tonalIcon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Pengingat dikirim!')),
                    );
                  },
                  icon: const Icon(Icons.notifications_active_outlined),
                  label: const Text('Ingatkan yang belum bayar'),
                ),
              ),
            ),
        ],
      ),
    );
  }
}