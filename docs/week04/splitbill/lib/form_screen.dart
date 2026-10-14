import 'package:flutter/material.dart';
import 'models.dart';

class LayarTambah extends StatefulWidget {
  final Function(Langganan) onSimpan;

  const LayarTambah({super.key, required this.onSimpan});

  @override
  State<LayarTambah> createState() => _LayarTambahState();
}

class _LayarTambahState extends State<LayarTambah> {
  final _namaController = TextEditingController();
  final _hargaController = TextEditingController();
  final _tanggalController = TextEditingController();
  final _anggotaController = TextEditingController();

  void _simpan() {
    List<Anggota> daftarAnggota = [];
    List<String> daftarNama = _anggotaController.text.split(',');
    for (int i = 0; i < daftarNama.length; i++) {
      String nama = daftarNama[i].trim();
      if (nama != '') {
        daftarAnggota.add(Anggota(nama, false));
      }
    }

    if (_namaController.text == '' || daftarAnggota.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama dan anggota wajib diisi')),
      );
      return;
    }

    final baru = Langganan(
      _namaController.text,
      int.tryParse(_hargaController.text) ?? 0,
      int.tryParse(_tanggalController.text) ?? 1,
      daftarAnggota,
    );

    widget.onSimpan(baru);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Langganan')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _namaController,
            decoration: const InputDecoration(
              labelText: 'Nama langganan',
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _hargaController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Harga total per bulan',
              prefixText: 'Rp ',
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _tanggalController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Tanggal tagihan (1-31)',
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _anggotaController,
            decoration: const InputDecoration(
              labelText: 'Nama anggota',
              helperText: 'Pisahkan dengan koma, cth: Saya, Andi, Budi',
            ),
          ),
          const SizedBox(height: 24),
          FilledButton(onPressed: _simpan, child: const Text('Simpan')),
        ],
      ),
    );
  }
}