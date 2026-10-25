# Menyiapkan Login Admin KampusHub

File ini menyiapkan login admin dan izin penghapusan dokumen. Jalankan sekali setelah tabel `documents` dari `setup.sql` berhasil dibuat.

## A. Pasang policy admin
1. Buka Supabase Dashboard untuk project KampusHub.
2. Masuk ke **SQL Editor → New query**.
3. Buka file `admin_setup.sql` dalam repository GitHub, salin seluruh isinya, tempel ke SQL Editor.
4. Klik **Run** dan pastikan hasilnya berhasil.

## B. Buat akun admin di Supabase
1. Di Supabase, buka **Authentication → Users**.
2. Klik **Add user** dan buat akun dengan email admin kamu dan password yang kuat. Jika tersedia, pilih opsi untuk mengonfirmasi email secara otomatis.
3. Setelah user dibuat, salin **ID/UUID** user dari daftar Users. Jangan gunakan database password di sini.

## C. Daftarkan user sebagai admin
Di SQL Editor, jalankan perintah berikut setelah mengganti ID dan email contoh dengan milik user yang baru dibuat:

```sql
insert into public.admin_users (user_id, email)
values ('GANTI-DENGAN-USER-UUID', 'email-admin@example.com')
on conflict (user_id) do update set email = excluded.email;
```

Gunakan UUID dan email yang sama persis dengan akun pada Authentication → Users.

## D. Uji dari website
1. Buka https://otherprojeck.github.io/Dashboard-Tugas-Ilham/
2. Klik **Admin**.
3. Login dengan email dan password tadi.
4. Jika user terverifikasi sebagai admin, tombol **Hapus** muncul pada tiap dokumen. Hanya admin terdaftar yang boleh menghapus; RLS database/storage juga memeriksa izin ini.
5. Klik **Keluar dari akun admin** setelah selesai. Tombol hapus harus hilang.

## Keamanan yang perlu diketahui
- Jangan buat pendaftaran admin publik. Baris admin hanya ditambahkan melalui SQL Editor oleh pemilik project.
- Jangan pernah masukkan password database, secret key atau service-role key ke HTML/JavaScript website.
- Arsip dan unggah dokumen masih publik dalam konfigurasi awal. Pengunjung dapat mengirim dan membaca dokumen; jangan unggah file rahasia atau berisi informasi pribadi sensitif.
- Untuk pengujian pertama, gunakan dokumen contoh. Pastikan login dan logout bekerja sebelum menghapus dokumen penting.
