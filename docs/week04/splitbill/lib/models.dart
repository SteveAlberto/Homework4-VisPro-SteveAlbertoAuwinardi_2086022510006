class Anggota {
  String nama;
  bool sudahBayar;

  Anggota(this.nama, this.sudahBayar);
}

class Langganan {
  String nama;
  int harga;
  int tanggalTagihan;
  List<Anggota> anggota;

  Langganan(this.nama, this.harga, this.tanggalTagihan, this.anggota);

  int hitungSudahBayar() {
    int jumlah = 0;
    for (int i = 0; i < anggota.length; i++) {
      if (anggota[i].sudahBayar) {
        jumlah = jumlah + 1;
      }
    }
    return jumlah;
  }

  int hitungIuran() {
    return harga ~/ anggota.length;
  }

  bool sudahLunas() {
    return hitungSudahBayar() == anggota.length;
  }

  String teksStatus() {
    if (sudahLunas()) {
      return 'Lunas semua';
    }
    return '${hitungSudahBayar()}/${anggota.length} lunas';
  }
}