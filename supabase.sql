-- Выполнить один раз в Supabase: SQL Editor → New query → вставить → Run.

create table if not exists public.board (
  id         text primary key,
  data       jsonb       not null default '{}'::jsonb,
  who        text,
  updated_at timestamptz not null default now()
);

create table if not exists public.activity (
  id   bigserial primary key,
  at   timestamptz not null default now(),
  who  text,
  what text
);

alter table public.board    enable row level security;
alter table public.activity enable row level security;

drop policy if exists "board select" on public.board;
drop policy if exists "board insert" on public.board;
drop policy if exists "board update" on public.board;
drop policy if exists "board delete" on public.board;
create policy "board select" on public.board for select using (true);
create policy "board insert" on public.board for insert with check (true);
create policy "board update" on public.board for update using (true) with check (true);
create policy "board delete" on public.board for delete using (true);

drop policy if exists "activity select" on public.activity;
drop policy if exists "activity insert" on public.activity;
create policy "activity select" on public.activity for select using (true);
create policy "activity insert" on public.activity for insert with check (true);
