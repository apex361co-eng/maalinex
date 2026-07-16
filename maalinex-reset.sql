-- ============================================================
-- ⚠️ Maalinex — پاک‌سازی کاملِ دیتابیس (غیرقابل بازگشت!)
-- همه‌ی داده‌ها (مشتریان، کالاها، اسناد، کاربران، نقش‌ها و…) حذف می‌شوند.
-- پس از این، اولین کسی که ثبت‌نام کند خودکار «ادمین» می‌شود.
-- این فایل را در Supabase → SQL Editor اجرا کنید.
-- ============================================================

-- ۱) پاک‌سازی همه‌ی رکوردهای برنامه (شامل رکورد کاربران/نقش‌ها)
alter table public.records disable row level security;   -- تا حذف بدون مانع انجام شود
delete from public.records;
alter table public.records enable row level security;
alter table public.records force row level security;

-- ۲) حذف همه‌ی حساب‌های ورود، تا «اولین ثبت‌نام از صفر» باشد و همان نفر ادمین شود
--    (سشن‌ها و هویت‌ها هم به‌صورت آبشاری پاک می‌شوند)
delete from auth.users;

-- ۳) بررسی: هر دو باید صفر باشند
select (select count(*) from public.records) as records_left,
       (select count(*) from auth.users)    as users_left;
