-- KampusHub admin setup (jalankan sekali setelah setup.sql membuat tabel documents; bisa dijalankan sebelum atau sesudah membuat user admin).
-- Membuat daftar admin yang hanya dapat dikelola pemilik project melalui SQL Editor.
-- Jangan membuat policy publik untuk INSERT/UPDATE/DELETE pada admin_users.

create table if not exists public.admin_users (
  user_id uuid primary key references auth.users(id) on delete cascade,
  email text not null unique,
  created_at timestamptz not null default now()
);

alter table public.admin_users enable row level security;
grant usage on schema public to authenticated;
grant select on public.admin_users to authenticated;

drop policy if exists "Admins can read their own admin record" on public.admin_users;
create policy "Admins can read their own admin record"
on public.admin_users for select to authenticated
using (user_id = auth.uid());

grant delete on public.documents to authenticated;

drop policy if exists "Admins can delete documents" on public.documents;
create policy "Admins can delete documents"
on public.documents for delete to authenticated
using (
  exists (
    select 1
    from public.admin_users a
    where a.user_id = auth.uid()
  )
);

drop policy if exists "Admins can delete KampusHub PDFs" on storage.objects;
create policy "Admins can delete KampusHub PDFs"
on storage.objects for delete to authenticated
using (
  bucket_id = 'kampushub-pdf'
  and exists (
    select 1
    from public.admin_users a
    where a.user_id = auth.uid()
  )
);

-- Cara mendaftarkan admin:
-- 1. Buat user di Supabase Dashboard > Authentication > Users > Add user.
-- 2. Ambil UUID user itu dari kolom ID.
-- 3. Jalankan query berikut dengan UUID dan email yang sesuai:
-- insert into public.admin_users (user_id, email)
-- values ('GANTI-DENGAN-USER-UUID', 'email-admin@example.com')
-- on conflict (user_id) do update set email = excluded.email;
