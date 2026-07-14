-- Maalinex — Supabase setup
-- این فایل را در Supabase → SQL Editor اجرا کنید (Run).

create table if not exists public.records (
  id uuid primary key default gen_random_uuid(),
  entity text not null,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now(),
  deleted boolean not null default false
);

create index if not exists records_entity_idx on public.records(entity);
create index if not exists records_updated_idx on public.records(updated_at);

alter table public.records enable row level security;

-- فقط کاربران لاگین‌شده دسترسی کامل دارند
drop policy if exists "authenticated full access" on public.records;
create policy "authenticated full access" on public.records
  for all to authenticated using (true) with check (true);

-- فعال‌سازی Realtime برای سینک لحظه‌ای بین دستگاه‌ها
do $$
begin
  begin
    alter publication supabase_realtime add table public.records;
  exception when duplicate_object then null;
  end;
end $$;
