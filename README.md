TUGAS INDIVIDU 7:
1. Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget.
Jawaban:
- Widget tree adalah representasi dari semua widget UI yang ada dalam aplikasi Flutter. Widget direpresentasikan sebagai node dalam tree. UI aplikasi disusun dengan menggabungkan widget-widget ini. Prinsip dasar Flutter adalah "Everything is Widget!". Widget tree dihitung selama proses layout dan kemudian digunakan selama proses rendering dan hit testing. Jika sebuah widget memiliki state yang terkait dengannya, setiap perubahan pada state-nya akan mengakibatkan rebuilding widget tersebut dan widget anak yang terlibat.
- Hubungan Parent-Child (Induk-Anak) Antar Widget:
Widget diletakkan bersama-sama untuk menyusun UI aplikasi.Widget yang membungkus widget lain disebut widget induk (parent), sementara widget yang dibungkus disebut widget anak (child).
> Widget Induk memberikan kontrol tentang bagaimana widget anak harus dibangun dalam tree tersebut.
> Widget Anak (khususnya Stateless Widget) akan menerima deskripsinya dari widget induk. Artinya, widget tersebut tidak berubah dengan sendirinya melalui tindakan atau perilaku internal. Perubahan pada widget anak di trigger oleh peristiwa eksternal pada widget induknya dalam widget tree.

2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.
Jawaban:
> MyApp (extends StatelessWidget): Root app custom yang menyediakan MaterialApp dan ThemeData dan sebagai tempat konfigurasi tema dan entry point UI.
> MyHomePage (extends StatelessWidget): halaman utama aplikasi (dipakai sebagai home di MaterialApp) yang mmbuat struktur layar dengan Scaffold, menampilkan AppBar, info pengguna, dan grid item.
> InfoCard (extends StatelessWidget): menampilkan 1 kartu yang berisi title dan content (dipakai untuk NPM / Name / Class). 
> ItemCard (extends StatelessWidget): widget untuk tiap item pada grid (ikon + nama) yang menampilkan Icon dan Text.
> MaterialApp: mengatur routing, tema (theme), dan home.
> Scaffold: struktur halaman dasar (AppBar, body, snackbars, dll) yang digunakan sebagai layout utama MyHomePage.
> AppBar: bar atas aplikasi yang menampilkan judul (Text) dan background color.
> Text: menampilkan teks di banyak tempat seperti judul AppBar, teks awal, title/isi InfoCard, nama item pada ItemCard, dll.
> Padding: menambahkan ruang (padding) di sekitar widget—dipakai di body untuk memberi jarak dari tepi layar.
> Column: menyusun widget secara vertikal (dipakai untuk layout utama dan di dalam InfoCard dan ItemCard).
> Row: menyusun widget secara horizontal (dipakai untuk menaruh 3 InfoCard berdampingan).
> SizedBox: spacer untuk memberi jarak vertikal (mis. SizedBox(height: 16.0)).
> Center: menempatkan child di tengah (dipakai untuk men-center-kan kolom berisi teks awal + grid).
> GridView.count: menampilkan daftar item dalam grid yang jumlah kolomnya tetap (crossAxisCount: 3). shrinkWrap: true agar tinggi grid menyesuaikan dengan konten.
> Card: dipakai di InfoCard untuk tampilan kotak berbayang.
> Container: untuk ukuran, padding, background, dsb. Digunakan di banyak tempat (mis. di Card, ItemCard).
> Material: memberi surface material dan digunakan sebagai parent di ItemCard supaya warna background + ripple bekerja.
> InkWell: menangani gesture onTap dengan efek ripple dan dipakai pada ItemCard untuk membuat kartu dapat ditekan.
> Icon: menampilkan ikon (dari Icons.*) pada ItemCard.
> SnackBarL widget pesan singkat yang muncul di bawah layar dan dipanggil melalui ScaffoldMessenger ketika ItemCard ditekan.
> ScaffoldMessenger: mekanisme untuk menampilkan SnackBar (dipanggil ScaffoldMessenger.of(context).showSnackBar(...)).

3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root.
Jawaban:
MaterialApp adalah widget yang digunakan sebagai root dari seluruh interface aplikasi Flutter. Ini adalah widget yang pertama kali dibangun dalam widget tree dan mengatur banyak konfigurasi yang mempengaruhi seluruh aplikasi dan menyediakan fungsi-fungsi penting seperti pengaturan tema global, manajemen routing, dan menyediakan kerangka dasar aplikasi seperti Scaffold dan AppBar. Widget ini sering menjadi root karena mengatur konfigurasi penting yang akan diwarisi oleh seluruh aplikasi di bawahnya, sehingga menciptakan tampilan yang konsisten dan menyederhanakan proses development.
- reference:
https://www.idn.id/basic-widgets-materialapp-scaffold/#:~:text=MaterialApp%20adalah%20widget%20yang%20digunakan,dapat%20menentukannya%20menggunakan%20properti%20ini.  

4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?
Jawaban:
Sesuai namanya sendiri, Stateless Widget adalah widget yang tidak memiliki keadaan (state) sedangkan Stateful Widget adalah widget yang mengubah keadaan nya secara dinamis selama masa pakainya.
- Perubahan
a. Stateless: tidak berubah dengan sendirinya melalui tindakan atau perilaku internal. Perubahan hanya dipicu oleh peristiwa eksternal pada widget induknya dalam widget tree.
b. Stateful: dirancang untuk menangani perubahan interaktif dan data internal dari waktu ke waktu.
- Sifat
a. Stateless: hanya memiliki properti final (tetap) yang didefinisikan selama konstruksi.
b. Stateful: bersifat Immutable (tidak dapat diubah), tetapi memiliki kelas State pendamping yang mewakili keadaan widget saat ini.
- Tujuan
a. Stateless: memberikan kontrol tentang bagaimana mereka dibangun kepada widget induk di tree.
b. Stateful: memungkinkan widget untuk kembali (rebuild) setiap kali data atau state internalnya berubah.
- Implementasi
a. Stateless: hanya perlu mengimplementasikan metode build().
b. Stateful: harus mengimplementasikan metode createState() yang mengembalikan objek State yang valid.
> Kapan Memilih?
a. Stateless Widget: ketika widget tersebut hanya berfungsi untuk menampilkan data yang sudah ditetapkan dan tidak perlu mengubah tampilannya sebagai respons terhadap input pengguna atau perubahan data internal.
b. Stateful Widget:  ketika widget perlu memelihara dan mengelola data yang dapat berubah dan kemudian memperbarui UI-nya untuk mencerminkan perubahan data tersebut.

5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?
Jawaban: 
- BuildContext adalah objek yang digunakan Flutter untuk memberikan informasi tentang lokasi widget di pohon widget. Objek ini merepresentasikan konteks build saat ini tempat widget sedang dibangun atau diperbarui. Intinya, ini adalah referensi ke lokasi widget dalam hierarki widget. 
- BuildContext dibuat secara otomatis ketika widget dimasukkan ke dalam pohon widget. Setiap metode build widget menerima BuildContext yang terkait sebagai argumen. Di dalam metode build, argumen BuildContext yang diterima digunakan untuk merender UI, mencari ancestor widget, dan mengakses nilai dari InheritedWidget. 
- reference:
https://medium.com/@dihsar/understanding-flutter-buildcontext-a-guide-for-developers-367579309f3a

6. Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".
Jawaban: 
> Hot Reload adalah fitur yang memungkinkan pengembang melihat hasil perubahan kode secara instan di aplikasi yang sedang berjalan tanpa harus menghentikan dan memulai ulang aplikasi sepenuhnya. Mekanisme ini memuat ulang perubahan kode ke dalam mesin virtual (VM) atau browser dan memperbarui antarmuka pengguna secara efisien, sering kali sambil mempertahankan status aplikasi saat ini. 
> Perbedaan hot reload dengan hot restart adalah hot reload menyuntikkan perubahan kode secara langsung ke dalam aplikasi yang sedang berjalan dan mempertahankan status aplikasi, sementara hot restart menghentikan aplikasi lalu memulai kembali dari awal tanpa mempertahankan status sebelumnya. Hot reload ideal untuk perubahan cepat pada UI dan logika kecil, sedangkan hot restart lebih cocok untuk perubahan besar seperti struktur aplikasi. 
- reference:
https://alan.co.id/perbedaan-antara-hot-reload-dan-hot-restart-di-flutter/#:~:text=Perbedaan%20Hot%20Reload%20dan%20Hot%20Restart%20*,hot%20reload%20dengan%20menggunakan%20tombol%20keyboard%20ctrl+/.