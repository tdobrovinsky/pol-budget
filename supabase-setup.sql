-- ============================================================
-- Monthly Budget App — Supabase Database Setup
-- Run this once in: Supabase Dashboard → SQL Editor → New Query
-- ============================================================

-- 1. Create the data table
--    One row per user per data key (mirrors localStorage structure)
create table if not exists budget_data (
  id          uuid        default gen_random_uuid() primary key,
  user_id     uuid        references auth.users not null,
  data_key    text        not null,
  data        jsonb       not null,
  updated_at  timestamptz default now(),
  unique(user_id, data_key)
);

-- 2. Enable Row Level Security
--    This is what makes each user's data private and isolated
alter table budget_data enable row level security;

-- 3. Policy: users can only read/write their own rows
create policy "Users manage their own data"
  on budget_data for all
  using  (auth.uid() = user_id)
  with check (auth.uid() = user_id);

-- ============================================================
-- That's it! Now go to Authentication → Settings in your
-- Supabase dashboard and consider:
--
--   • "Confirm email" → OFF (easier for family/friends)
--     OR leave ON and they'll get a confirmation email
--
--   • Site URL → set to your Netlify URL after deploying
-- ============================================================
