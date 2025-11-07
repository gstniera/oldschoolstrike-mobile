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


TUGAS INDIVIDU 8:
1. Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement() pada Flutter. Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Football Shop kamu?
a. Navigator.push()
Metode push() menambahkan suatu route baru ke dalam stack route yang dikelola oleh Navigator. Route yang baru ditambahkan akan berada di posisi paling atas stack, sehingga route tersebut akan muncul dan ditampilkan kepada user. Karena halaman sebelumnya tetap berada di bawah halaman baru dalam stack, user bisa balik ke halaman sebelumnya (misal dengan tombol Back di hp).
> Kapan pake Navigator.push()?
Navigator.push() digunakan ketika kita ingin menambah halaman sementara di atas halaman saat ini dan kita ingin user memiliki opsi untuk kembali:
Ketika user milih opsi 'Add Product' dari drawer, Navigator.push() digunakan untuk menavigasi ke ProductFormPage. Dengan menggunakan push(), halaman Menu (MyHomePage) tetap berada di bawah halaman Formulir dalam stack. Ini membuat user untuk menekan tombol Back dan kembali ke halaman Menu tanpa menutup aplikasi.
b. Navigator.pushReplacement()
Metode pushReplacement() menghapus route yang sedang ditampilkan kepada user (yang berada di paling atas stack) dan menggantinya secara langsung dengan route yang baru. Route lama pada atas stack digantikan oleh route baru tanpa mengubah kondisi elemen stack yang berada di bawahnya. Karena halaman sebelumnya udah dihapus dari stack dan diganti, user ga bisa balik ke halaman yang baru diganti tersebut.
> Kapan pake Navigator.pushReplacement()?
Navigator.pushReplacement() dipake ketika kita ingin mengganti halaman sekarang dengan halaman baru, dan kita ga ingin user bisa balik ke halaman yang baru saja ditinggalkan. Ini sering digunakan untuk navigasi ke halaman utama atau setelah proses otentikasi (login/signup):
Ketika user mengklik opsi 'Home' dari LeftDrawer, Navigator.pushReplacement() digunakan untuk menavigasi ke MyHomePage. Menggunakan pushReplacement() akan membersihkan stack di atasnya dan mastiin user tidak dapat menekan "Back" untuk kembali ke form yang baru saja mereka buat. 

2. Bagaimana kamu memanfaatkan hierarchy widget seperti Scaffold, AppBar, dan Drawer untuk membangun struktur halaman yang konsisten di seluruh aplikasi?
a. Scaffold adalah widget yang menyediakan kerangka struktur dasar untuk sebuah halaman atau layar.Dengan menggunakan Scaffold pada setiap halaman (misalnya MyHomePage dan ProductFormPage), kita memastiin setiap layar punya fondasi standar yang memungkinkan penambahan komponen utama seperti AppbBar (bagian atas halaman), body (konten utama), dan Drawer (menu disamping) secara konsisten,
b. AppBar adalah bagian atas halaman yang biasanya menampilkan judul aplikasi. Untuk konsistensi, setiap Scaffold menyertakan properti appBar dan meskipun detail di dalamnya (seperti judul teks atau warna latar belakang) dapat disesuaikan untuk setiap halaman (misalnya MyHomePage memiliki judul 'Oldschool Strike', sementara halaman formul memiliki judul 'Create New Product'), kegunaan header di lokasi yang sama memberikan tampilan yang konsisten.
c. Drawer adalah menu yang muncul dari sisi kiri atau kanan layar dan biasanya berisi tautan navigasi ke halaman lain dalam aplikasi. Misalnya, di dalam LeftDrawer, navigasi ke halaman 'Home' menggunakan Navigator.pushReplacement, sementara navigasi ke halaman 'Add Product' menggunakan Navigator.push. Karena definisi navigasi ini terpusat di satu tempat (LeftDrawer.dart), semua halaman yang menggunakannya akan memiliki perilaku navigasi yang sama.

3. Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti Padding, SingleChildScrollView, dan ListView saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi kamu.
a. Padding adalah widget yang berfungsi untuk memberikan jarak kosong di sekeliling child widget-nya.
> Kelebihan:
- Readability: mastiin elemen-elemen form ga saling menempel untuk ningkatin keterbacaan dan membuat interface terlihat lebih rapi.
- Aksesibilitas: Dengan adanya jarak, user lebih mudah berinteraksi dengan satu elemen input tanpa tidak sengaja menekan elemen di sebelahnya.
> Contoh Penggunaan:
Di ProductFormPage, setiap elemen input selalu dibungkus oleh Padding (Name, Price, Description, Category, dan tombol "Save"). Hal ini membuat form terstruktur dan ga berimpitan.
b. SingleChildScrollView adalah widget yang berfungsi untuk membuat konten di dalamnya bisa scrollable.
> Kelebihan:
- Pencegahan Overflow: ketika user mengklik input field, keyboard virtual akan muncul dan mengurangi ruang layar yang tersedia. Tanpa SingleChildScrollView, jika elemen form melebihi sisa ruang layar, aplikasi akan mengalami render overflow error (konten tumpah/melebihi batas).
- Dukungan Konten Panjang: Memungkinkan kita menempatkan banyak input field yang mungkin melebihi tinggi fisik layar perangkat tetapi tetap dapat diakses dengan cara di scroll ke atas atau bawah.
> Contoh Penggunaan:
Di ProductFormPage, seluruh konten form utama dibungkus di dalam SingleChildScrollView dimana widget tsb mastiin bahwa semua field (termasuk validasi dan tombol "Save") tetap terlihat, meskipun pada layar kecil atau saat keyboard muncul.
c. ListView adalah widget yang mengatur child widget sebagai scrollable list. Mirip dengan SingleChildScrollView tetapi secara default mengoptimalkan untuk tampilan daftar yang sangat panjang.
> Kelebihan:
ListView dominan dalam struktur yang membutuhkan daftar item yang mungkin melebihi layar, seperti menu navigasi untuk 
- Efisiensi List: Menyediakan daftar vertikal elemen yang dapat di scroll.
- Struktur Navigasi: Cocok digunakan untuk membuat daftar navigasi yang konsisten.
> Contoh Penggunaan:
Dalam widget Drawer (LeftDrawer) dimana dengan menggunakan ListView, jika jumlah menu (ListTile) bertambah, menu samping tersebut akan otomatis bisa di scroll, menjaga konsistensi dan fungsionalitas navigasi

4. Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?
- Menggunakan Theme Color Scheme
Beberapa bagian aplikasi menggunakan referensi ke colorScheme aplikasi secara keseluruhan. Jika warna brand toko diatur pada scheme ini, maka semua widget yang merujuk padanya akan konsisten. Latar belakang AppBar pada halaman utama (MyHomePage) diatur untuk mengambil warna dari tema aplikasi.
- Mengatur Warna Eksplisit
Beberapa elemen yang berfungsi sebagai navigasi dan interaksi menggunakkan hardcoding. Ini memastikan bahwa elemen tersebut selalu menampilkan warna brand yang spesifik, terlepas dari scheme warna utama lainnya (misalnya tombol all products, my products, and create products).