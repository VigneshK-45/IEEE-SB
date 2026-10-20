-- The Breach Files: run in Supabase SQL Editor
create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  email text, full_name text, created_at timestamptz default now());
create table if not exists public.game_progress (
  user_id uuid primary key references auth.users(id) on delete cascade,
  state jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now());
alter table public.profiles enable row level security;
alter table public.game_progress enable row level security;
create policy "own profile read" on public.profiles for select using (auth.uid() = id);
create policy "own progress read" on public.game_progress for select using (auth.uid() = user_id);
create policy "own progress insert" on public.game_progress for insert with check (auth.uid() = user_id);
create policy "own progress update" on public.game_progress for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
create or replace function public.handle_new_user() returns trigger
language plpgsql security definer set search_path = public as $$
begin
  insert into public.profiles(id,email,full_name)
  values (new.id,new.email,new.raw_user_meta_data->>'full_name') on conflict do nothing;
  return new;
end $$;
drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created after insert on auth.users
  for each row execute function public.handle_new_user();
