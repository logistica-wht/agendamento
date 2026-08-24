/*
  CONFIGURAÇÃO DO SUPABASE
  ------------------------
  Preencha os dois valores abaixo com os dados do seu projeto Supabase.

  SUPABASE_URL   -> Painel Supabase > Settings > API > "Project URL"
                    (ex.: https://minnnqxcjezrqvdlaprq.supabase.co)

  SUPABASE_ANON_KEY -> Painel Supabase > Settings > API > "Project API keys"
                       use a chave "anon public" (NÃO use a "service_role").

  A chave "anon public" é feita para ficar no navegador/front-end — ela é
  protegida pelas regras de RLS (Row Level Security) definidas em schema.sql,
  não pela sua confidencialidade. Veja o README.md para mais detalhes.
*/

const SUPABASE_URL = "https://minnnqxcjezrqvdlaprq.supabase.co";
const SUPABASE_ANON_KEY = "sb_publishable_XCSxYHxRTYGysJcnhlF49g_Hq64-GpO";
