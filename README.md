# [Game Development - Tutorial 7](https://csui-game-development.github.io/tutorials/tutorial-7/)

## Latihan 1: Gerakan Dasar di Bidang 3D

- Buat sebuah *scene* dengan **root** node berupa `CharacterBody`.
- Tambahkan *child nodes*:
  - `MeshInstance3D`
  - `CollisionShape3D`
  - `Node3D`
- Atur `MeshInstance3D` dan `CollisionShape3D` dengan bentuk *capsule*.
- Di dalam `Node3D`, tambahkan *child node* `Camera3D`.
- Tambahkan *child node* `RayCast3D` di bawah `Camera3D`.
- Sesuaikan rotasi `RayCast3D` agar sejajar dengan arah `Camera3D`.
- Lampirkan *script* ke *root* node agar karakter dapat bergerak.
- Perbarui **Input Map** pada *Project Settings* sesuai dengan *script* yang telah dibuat.

---

## Latihan 2: Interaksi Objek

- Buat *script* dasar baru dengan nama `Interactable`.
- Terapkan *script* tersebut pada node `StaticBody3D` yang terdapat pada *Switch*.
- Konfigurasikan variabel ekspor dengan tipe `PackedScene` agar menunjuk ke `OmniLight3D`.
- Pasang *script* pada `RayCast3D` untuk menangani interaksi dengan objek bertipe `Interactable`.
- Hubungkan *signal* dari `RayCast3D` ke fungsi yang relevan di dalam *script*.

---

## Latihan 3: Pembuatan Level 3D dengan CSG

- Buat file *scene* `Level1.tscn` dengan **root** node `Node3D` dan tambahkan:
  - *Player*
  - `OmniLight3D`
  - *Switch*
- Buat *scene* `World1.tscn` dengan **root** node `Node3D`.
- Rancang dunia Level 1 di dalam `World1.tscn` menggunakan node `CSGBox3D`.
- Buat jurang dengan `CSGBox3D` dan letakkan `Area3D` di bawahnya.
- Pasang *script* pada `Area3D` untuk mendeteksi kehadiran *Player* dan melakukan pemuatan ulang `Level1.tscn`.
- Untuk membantu *Player* melintasi jurang, tambahkan `CSGBox3D` di atasnya.
- Rancang *scene* `Lamp.tscn` dengan **root** node `CSGCombiner3D` dan tambahkan:
  - Dua buah `CSGCylinder3D`
  - Satu buah `CSGPolygon3D`
- Atur kombinasi node-node CSG agar membentuk objek **Lampu**.

---

## Latihan Mandiri: Eksplorasi Mekanika 3D

### 1. Fitur Sprint dan Crouching

- **Variabel Konfigurasi:**
   - `walk_speed`: Kecepatan berjalan normal.
   - `sprint_speed`: Kecepatan lari.
   - `crouch_speed`: Kecepatan merayap.

- **Variabel Status:**
   - `current_speed`: Menyimpan kecepatan aktif.
   - `is_crouching`: Menandakan apakah karakter sedang jongkok.

- **Logika Sprint:**
   - Deteksi input tombol sprint.
   - Atur `current_speed` ke `sprint_speed` kecuali jika `is_crouching` aktif.

- **Logika Crouch:**
   - Implementasikan fungsi `handle_crouch()` untuk:
     - Mengubah tinggi `collision_shape`.
     - Menyesuaikan posisi kepala/kamera.
     - Mengurangi kecepatan gerak ke `crouch_speed`.

5. **Integrasi Gerakan:**
   - Gunakan `current_speed` dalam perhitungan perpindahan.
   - Batasi aksi tertentu (misalnya lompat) saat dalam keadaan jongkok.

### Polishing
1. Menambah `WinScreen` ketika *Player* menyentuh suatu objek `Area3D` yang berada di akhir stage.
2. *Player* akan kembali ke titik awal ketika jatuh ke jurang.
