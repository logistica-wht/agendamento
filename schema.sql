-- ============================================================
-- Wheaton Brasil Vidros - Portal de Agendamento
-- CORREÇÃO / COMPLEMENTO
-- Mantém a estrutura original da tabela
-- ============================================================


-- ============================================================
-- 1. GARANTE QUE A TABELA EXISTE
-- ============================================================

create table if not exists public.agendamentos (
  id                    bigint primary key,
  protocolo             text,
  data                  text,
  horario               text,
  transportadora        text,
  pedido                text,
  motorista             text,
  placa                 text,
  ajudantes             text,
  veiculo               text,
  cliente               text,
  ordem                 text,
  shipment              text,
  telefone              text,
  observacoes           text,
  status                text,
  criado                timestamptz,
  chegada               timestamptz,
  inicio                timestamptz,
  fim                   timestamptz,
  cancelado_em          timestamptz,
  motivo_cancelamento   text
);


-- ============================================================
-- 2. ÍNDICES
-- ============================================================

create index if not exists agendamentos_data_horario_idx
  on public.agendamentos (data, horario);

create index if not exists agendamentos_status_idx
  on public.agendamentos (status);

create index if not exists agendamentos_protocolo_idx
  on public.agendamentos (protocolo);

create index if not exists agendamentos_transportadora_idx
  on public.agendamentos (transportadora);

create index if not exists agendamentos_placa_idx
  on public.agendamentos (placa);

create index if not exists agendamentos_shipment_idx
  on public.agendamentos (shipment);


-- ============================================================
-- 3. RLS
-- ============================================================

alter table public.agendamentos enable row level security;


-- ============================================================
-- 4. POLÍTICA DE LEITURA
-- ============================================================

drop policy if exists "Permitir leitura publica"
on public.agendamentos;

create policy "Permitir leitura publica"
on public.agendamentos
for select
to anon
using (true);


-- ============================================================
-- 5. POLÍTICA DE INSERÇÃO
-- ============================================================

drop policy if exists "Permitir insercao publica"
on public.agendamentos;

create policy "Permitir insercao publica"
on public.agendamentos
for insert
to anon
with check (true);


-- ============================================================
-- 6. POLÍTICA DE ATUALIZAÇÃO
-- ============================================================

drop policy if exists "Permitir atualizacao publica"
on public.agendamentos;

create policy "Permitir atualizacao publica"
on public.agendamentos
for update
to anon
using (true)
with check (true);


-- ============================================================
-- 7. POLÍTICA DE EXCLUSÃO
-- ============================================================

drop policy if exists "Permitir exclusao publica"
on public.agendamentos;

create policy "Permitir exclusao publica"
on public.agendamentos
for delete
to anon
using (true);


-- ============================================================
-- 8. REALTIME
--
-- CORRIGE O ERRO:
-- "agendamentos is already member of publication
--  supabase_realtime"
--
-- Não adiciona novamente se já existir.
-- ============================================================

do $$
begin

  if not exists (
    select 1
    from pg_publication_tables
    where pubname = 'supabase_realtime'
      and schemaname = 'public'
      and tablename = 'agendamentos'
  ) then

    alter publication supabase_realtime
    add table public.agendamentos;

  end if;

end
$$;


-- ============================================================
-- 9. GARANTE REPLICA IDENTITY
--
-- Necessário para o Realtime conseguir entregar
-- corretamente eventos de UPDATE/DELETE.
-- ============================================================

alter table public.agendamentos
replica identity full;


-- ============================================================
-- 10. VALIDAÇÃO
-- ============================================================

select
  'agendamentos' as tabela,
  count(*) as total_registros
from public.agendamentos;


-- ============================================================
-- 11. VERIFICA SE REALTIME ESTÁ ATIVO
-- ============================================================

select
  schemaname,
  tablename
from pg_publication_tables
where pubname = 'supabase_realtime'
  and schemaname = 'public'
  and tablename = 'agendamentos';


-- ============================================================
-- FIM
-- ============================================================
