import 'package:flutter/material.dart';
import 'models.dart';
import 'detail_screen.dart';
import 'form_screen.dart';
import 'harness.dart';

class LayarAwal extends StatefulWidget {
  final List<Langganan>? initialData;

  const LayarAwal({super.key, this.initialData});

  @override
  State<LayarAwal> createState() => _LayarAwalState();
}

class _LayarAwalState extends State<LayarAwal> {
  late List<Langganan> _daftarLangganan;

  @override
  void initState() {
    super.initState();
    _daftarLangganan = (widget.initialData ?? kMenuNormal).toList();
  }

  void _tambahLangganan(Langganan baru) {
    setState(() {
      _daftarLangganan.add(baru);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${baru.nama} ditambahkan')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    int totalTagihan = 0;
    int belumLunas = 0;
    for (int i = 0; i < _daftarLangganan.length; i++) {
      totalTagihan = totalTagihan + _daftarLangganan[i].harga;
      if (!_daftarLangganan[i].sudahLunas()) {
        belumLunas = belumLunas + 1;
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Patungan Langganan')),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: SizedBox(
                width: double.infinity,
                child: Card.filled(
                  color: scheme.primaryContainer,
                  margin: const EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Tagihan',
                          style: text.labelLarge?.copyWith(color: scheme.onPrimaryContainer),
                        ),
                        Text(
                          'Rp $totalTagihan',
                          style: text.displaySmall?.copyWith(
                            color: scheme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '$belumLunas langganan belum lunas',
                          style: text.bodyMedium?.copyWith(color: scheme.onPrimaryContainer),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text('Daftar Patungan Aktif', style: text.titleMedium),
              ),
            ),
          ];
        },

        body: _daftarLangganan.isEmpty
            ? Center(
                key: const Key('empty-state'),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.receipt_long_outlined, size: 64, color: scheme.outline),
                      const SizedBox(height: 16),
                      Text('Belum ada tagihan', style: text.titleLarge),
                      const SizedBox(height: 8),
                      Text('Tambahkan langganan pertama Anda.', style: text.bodyMedium),
                      const SizedBox(height: 16),
                      FilledButton.tonal(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => LayarTambah(onSimpan: _tambahLangganan),
                          ));
                        },
                        child: const Text('Mulai Patungan'),
                      )
                    ],
                  ),
                )
              )
            : LayoutBuilder(
                builder: (context, constraints) { 
                  final isWide = constraints.maxWidth >= 600;

                  if (isWide) {
                    return GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 400, 
                        mainAxisExtent: 100, 
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: _daftarLangganan.length,
                      itemBuilder: (context, index) {
                        return _buildLanggananCard(
                            context, _daftarLangganan[index], scheme, text);
                      },
                    );
                  } else {
                    return ListView.builder(
                      itemCount: _daftarLangganan.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: _buildLanggananCard(
                              context, _daftarLangganan[index], scheme, text),
                        );
                      },
                    );
                  }
                },
              ),
          
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LayarTambah(onSimpan: _tambahLangganan),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Tambah'),
      ),
    );
  }

  Widget _buildLanggananCard(BuildContext context, Langganan item, ColorScheme scheme, TextTheme text) {
    final lunas = item.sudahLunas();
    return Card.outlined(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LayarDetail(
                langganan: item,
                onUbah: () {
                  setState(() {});
                },
              ),
            ),
          );
        },
        leading: const Icon(Icons.subscriptions),
        title: Text(
          item.nama, 
          style: text.titleMedium,
          maxLines: 1, 
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Align(
          alignment: Alignment.centerLeft,
          child: Chip(
            label: Text(item.teksStatus()),
            backgroundColor:
                lunas ? scheme.secondaryContainer : scheme.errorContainer,
            side: BorderSide.none,
          ),
        ),
        trailing: Text('Rp ${item.harga}', style: text.titleMedium),
      ),
    );
  }
}