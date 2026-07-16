-- ============================================================
-- 👥 Maalinex — پاک‌سازی فقط کاربران و نقش‌ها (داده‌ها دست‌نخورده می‌مانند)
-- همه‌ی داده‌ها (مشتریان، کالاها، اسناد، پروژه‌ها و…) باقی می‌مانند؛
-- فقط لیست کاربران/نقش‌ها و ماتریس دسترسی و حساب‌های ورود پاک می‌شوند.
-- پس از این، اولین کسی که ثبت‌نام کند خودکار «ادمین» می‌شود.
-- در Supabase → SQL Editor اجرا کنید.
-- ============================================================

-- ۱) حذف فقط رکورد کاربران/نقش‌ها و ماتریس دسترسی (داده‌ها حذف نمی‌شوند)
alter table public.records disable row level security;
delete from public.records where id in (
  '00000000-0000-4000-8000-00000000aaaa',  -- کاربران و نقش‌ها
  '00000000-0000-4000-8000-00000000cccc'   -- ماتریس سطوح دسترسی
);
alter table public.records enable row level security;
alter table public.records force row level security;

-- ۲) حذف همه‌ی حساب‌های ورود، تا اولین ثبت‌نام از صفر باشد و ادمین شود
delete from auth.users;

-- ۳) بررسی: داده‌ها باید باقی مانده باشند، کاربران صفر
select (select count(*) from public.records) as records_kept,
       (select count(*) from auth.users)     as auth_users_left;
