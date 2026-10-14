H1 — Seed colour: Teal (#00897B)

Pengguna aplikasi ini adalah mahasiswa dan anak muda yang patungan akun langganan bersama teman temannya, dengan masalah utamanya adalah rasa canggung saat harus menagih tagihan melalui chat. Karena aplikasi ini berurusan dengan uang sekaligus hubungan pertemanan, warnanya harus terasa tenang, tepercaya, dan tidak menghakimi. Teal berada di antara biru (kepercayaan) dan hijau (uang dan status "lunas"), sehingga pengguna langsung mengasosiasikannya dengan transaksi yang aman tanpa kesan agresif seperti merah atau oranye. Warna yang tidak mengintimidasi ini membuat tagihan terasa seperti informasi netral dari sistem, bukan teguran dari teman. Teal juga tidak identik dengan merek langganan yang dipatungankan (merah Netflix, hijau Spotify, biru Canva), sehingga identitas aplikasi tidak bertabrakan dengan kontennya.

H2 — Hierarchy pass

1. Layar Awal
Elemen terpenting di layar ini adalah Total Tagihan, karena itu adalah informasi pertama yang dicari pengguna. Saya membuatnya dominan dengan memperbesar teks jumlah tagihan memakai `displaySmall` yang ditebalkan, lalu menaruhnya di kartu berwarna `primaryContainer`. Judul dan harga tiap langganan tidak diperkecil, tetapi status pembayarannya sekarang memakai Chip berwarna (`errorContainer` untuk belum lunas, dan `secondaryContainer` untuk lunas) supaya mudah dibedakan. 
Screenshot: `home_before.png` dan `home_after.png`.

2. Layar Detail Patungan
Elemen terpentingnya adalah progres pembayaran, karena tujuan utama aplikasi ini adalah melacak siapa yang belum bayar. Teksnya saya buat besar dan tebal dengan `headlineMedium`, ditaruh di kartu `primaryContainer`, dan ditambah progress bar. Daftar anggota tetap memakai ukuran teks normal.
Screenshot: `detail_before.png` dan `detail_after.png`.


3. Layar Tambah Langganan
Elemen terpentingnya adalah tombol Simpan, karena itu aksi utama di form. Saya mengubahnya dari `TextButton` menjadi `FilledButton` yang berwarna solid, jadi hanya tombol ini yang memiliki warna penuh di layar tersebut. Kolom isian tidak diubah ukurannya.
Screenshot: `form_before.png` dan `form_after.png`.

Catatan : Layar Detail dan Layar Tambah Langganan baru saya buat minggu ini, jadi keduanya tidak punya versi sebelumnya. Screenshot "before" untuk kedua layar itu adalah versi pembanding yang saya buat tanpa penekanan hierarki, yaitu semua teks berukuran sama dan tombol Simpan berupa `TextButton`. Hanya Layar Awal yang punya "before" asli dari minggu lalu.