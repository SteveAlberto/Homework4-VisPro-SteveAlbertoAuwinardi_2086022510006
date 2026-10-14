### H1 — Responsive Pass on Every Screen

| Screen | Test | Pass/Fail | Fixes Noted |
| :--- | :--- | :--- | :--- |
| **LayarAwal** | Small phone (320 dp) | Pass | - |
| **LayarAwal** | Large phone (430 dp) | Pass | - |
| **LayarAwal** | Tablet (800 dp) | Pass | Menambahkan `LayoutBuilder`. Jika `maxWidth >= 600`, layout berubah dari `ListView` menjadi `GridView`. |
| **LayarAwal** | Landscape | Pass | - |
| **LayarAwal** | Long text (200 chars) | Pass | Menambahkan `maxLines: 1` dan `overflow: TextOverflow.ellipsis` pada `Text` nama langganan. |
| **LayarAwal** | Empty state (Zero items)| Pass | Menambahkan widget `Center` dengan ikon, pesan, dan action button saat data kosong, dengan `key: Key('empty-state')`. |
| **LayarAwal** | Long list (500 items) | Pass | Tetap aman karena sudah menggunakan `ListView.builder` tanpa menggunakan `shrinkWrap: true`. |
| **LayarAwal** | Keyboard (Text field) | Pass | Tidak ada isu, tidak terdapat text field di layar ini. |
| **LayarAwal** | Dark mode | Pass | Tema gelap berfungsi otomatis menggunakan `darkTheme` di `main.dart`, dan teks tetap terbaca jelas. |
| **LayarTambah** | Keyboard (Text field) | Pass | Saat landscape dan keyboard terbuka, seluruh *form* tetap bisa di-scroll berkat penggunaan `ListView` alih-alih `Column`. |
| **LayarDetail** | Long text (200 chars) | Pass | Perlu dipastikan nama member di `CheckboxListTile` memiliki batas *maxLines* jika kedepannya ada nama yang sangat panjang. |