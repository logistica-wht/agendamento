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
const SUPABASE_ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1pbm5ucXhjamV6cnF2ZGxhcHJxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODczMTc4MTMsImV4cCI6MjEwMjg5MzgxM30.r_96ton7d-vxQgEuUl3dRUudJn56D_y7IY8CcDETmTQ";
