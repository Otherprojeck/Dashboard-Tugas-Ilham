# KampusHub — Panduan pemasangan database

Website statis berada di `index.html`. File tersebut sudah disiapkan untuk memakai Supabase sebagai database dan penyimpanan PDF. **Agar upload lintas perangkat aktif, Supabase tetap harus dibuat dan dikonfigurasi.**

## 1. Buat project Supabase
1. Buka https://supabase.com/ dan login.
2. Buat project baru, misalnya `KampusHub`.
3. Dari pengaturan project, salin **Project URL** serta **anon/public/publishable key**. Nama menu dapat berbeda sesuai versi dashboard.

## 2. Jalankan SQL
1. Di dashboard Supabase, buka **SQL Editor → New query**.
2. Buka file `setup.sql` dalam repository ini dan salin seluruh isinya ke editor.
3. Klik **Run** dan pastikan skrip selesai tanpa error. Skrip ini membuat tabel `documents`, bucket `kampushub-pdf`, serta policy akses.

## 3. Masukkan konfigurasi ke website
1. Kembali ke file `index.html` pada repository ini, klik ikon edit (pensil).
2. Cari dua konstanta berikut dekat bagian bawah file:
   ```js
   const SUPABASE_URL = 'PASTE_SUPABASE_PROJECT_URL_HERE';
   const SUPABASE_ANON_KEY = 'PASTE_SUPABASE_ANON_OR_PUBLISHABLE_KEY_HERE';
   ```
3. Ganti nilai placeholder dengan Project URL dan anon/public/publishable key project milikmu.
4. Klik **Commit changes** untuk menyimpan.
5. **Jangan pernah** memasukkan `service_role` atau secret key ke `index.html`. Website ini berjalan di browser publik.

## 4. Aktifkan GitHub Pages
1. Buka **Settings → Pages** di repository `Dashboard-Tugas-Ilham`.
2. Di bagian Build and deployment, pilih **Deploy from a branch**.
3. Pilih branch `main` dan folder `/(root)`, lalu **Save**.
4. Setelah deployment selesai, buka alamat Pages yang ditampilkan GitHub. Biasanya berupa `https://otherprojeck.github.io/Dashboard-Tugas-Ilham/`.

## Fitur saat ini
- Form upload materi atau tugas kuliah (PDF maksimum 10 MB).
- Menyimpan metadata dokumen ke tabel Supabase.
- Menyimpan file PDF ke Supabase Storage.
- Arsip, pencarian judul/nama/NIM, filter materi/tugas, dan unduhan.
- Tampilan responsif untuk desktop dan ponsel.

## Batasan dan keamanan
- Pengiriman dan membaca arsip disiapkan untuk publik dalam versi awal; siapa pun yang mengakses situs dapat mengirim dan membaca dokumen. Jangan unggah data rahasia.
- Tombol Admin hanya menampilkan informasi; login admin dan penghapusan dokumen **belum diaktifkan**. Jangan mengandalkan PIN di kode frontend sebagai keamanan.
- Untuk penggunaan nyata, tambahkan Supabase Auth, role admin di database, policy hapus/ubah khusus admin, perlindungan spam, dan kebijakan privasi.
- GitHub Pages adalah hosting situs, bukan database. Upload lintas perangkat baru berfungsi setelah konfigurasi Supabase selesai.
