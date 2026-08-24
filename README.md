# Portal de Agendamento — Wheaton Brasil Vidros

Site estático (HTML puro) com os dados de agendamento salvos no **Supabase**
(compartilhados entre todos os acessos) e as **senhas de login guardadas
apenas no navegador** (localStorage), sem nenhuma senha gravada no banco de
dados.

## Arquivos

- `index.html` — o portal completo (interface, regras de horário/feriados, login, painel operacional, cancelamento).
- `config.js` — único arquivo que você precisa editar: URL e chave do Supabase.
- `schema.sql` — script para criar a tabela `agendamentos` no Supabase.
- `README.md` — este guia.

## Passo 1 — Criar a tabela no Supabase

1. Acesse [supabase.com](https://supabase.com) e entre no projeto
   `wdsvvbfjwvqjdezefmdj` (o mesmo cuja URL você já tem).
2. No menu lateral, abra **SQL Editor** → **New query**.
3. Copie todo o conteúdo do arquivo `schema.sql` deste pacote, cole no editor
   e clique em **Run**.
4. Isso cria a tabela `agendamentos` (ou reaproveita, se já existir), as
   políticas de acesso (RLS) e ativa o **Realtime** para essa tabela — é o
   que permite que os agendamentos apareçam automaticamente em todas as
   telas abertas, sem precisar recarregar a página. O script pode ser
   rodado novamente sem problema a qualquer momento (ele não duplica nada).

## Passo 2 — Pegar a "anon key" do projeto

1. No painel do Supabase, vá em **Settings** (ícone de engrenagem) → **API**.
2. Copie o valor de **Project URL** (deve ser
   `https://wdsvvbfjwvqjdezefmdj.supabase.co`).
3. Copie o valor da chave **anon / public** (não use a `service_role`, que é
   secreta e nunca deve ir para um site público).

## Passo 3 — Configurar o `config.js`

Abra `config.js` e preencha:

```js
const SUPABASE_URL = "https://wdsvvbfjwvqjdezefmdj.supabase.co";
const SUPABASE_ANON_KEY = "cole_aqui_a_sua_anon_key";
```

Salve o arquivo. Pronto — o `index.html` já está preparado para usar essas
duas informações automaticamente.

## Passo 4 — Publicar no GitHub Pages

1. Crie um repositório novo no GitHub (pode ser público ou privado, desde
   que o GitHub Pages esteja disponível no seu plano).
2. Envie os 3 arquivos (`index.html`, `config.js`, `schema.sql`) para o
   repositório — pela interface web do GitHub ("Add file → Upload files")
   ou via git:

   ```bash
   git init
   git add index.html config.js schema.sql README.md
   git commit -m "Portal de agendamento Wheaton"
   git branch -M main
   git remote add origin https://github.com/SEU_USUARIO/SEU_REPOSITORIO.git
   git push -u origin main
   ```

3. No repositório, vá em **Settings → Pages**.
4. Em **Source**, selecione a branch `main` e a pasta `/ (root)`.
5. Clique em **Save**. Em alguns minutos o GitHub mostrará o link do site,
   algo como `https://SEU_USUARIO.github.io/SEU_REPOSITORIO/`.

## Como funciona o login (sem senha no banco)

- As credenciais padrão (usuário/senha de "Transportadora" e
  "Administrador") ficam definidas no próprio `index.html` e, assim que
  alguém troca a senha pela tela de acesso, o novo valor é salvo em
  `localStorage` **do navegador de quem alterou** — nunca é enviado ao
  Supabase.
- Isso significa que a troca de senha vale só naquele navegador/computador.
  Para trocar a senha "para todo mundo", seria preciso um outro mecanismo
  (por exemplo, Supabase Auth de verdade) — o que pode ser feito depois, se
  fizer sentido para o seu caso.

## O que fica no Supabase

Somente a tabela `agendamentos`, com os dados de cada coleta/entrega
(protocolo, data, horário, transportadora, motorista, placa, status,
horários de chegada/carregamento/finalização, cancelamentos, etc.). Todos
os usuários que abrirem o site enxergam os mesmos agendamentos **em tempo
real**: o portal usa o recurso "Realtime" do Supabase, então assim que
alguém cria, altera ou cancela um agendamento, todas as telas abertas
atualizam sozinhas, sem precisar recarregar a página. Como reserva, existe
também uma sincronização automática a cada 20 segundos, caso a conexão em
tempo real caia por algum motivo.

## Aviso importante sobre segurança

Como não há um backend/servidor próprio — só o site estático conversando
direto com o Supabase — a chave "anon key" fica visível para quem abrir o
código-fonte da página. Ela dá acesso de leitura e escrita à tabela
`agendamentos` (é assim que o site consegue funcionar sem senha no banco).
Isso é adequado para um portal operacional interno, mas **não é o mesmo
nível de proteção de um sistema com login de verdade no servidor**. Se este
portal crescer ou passar a lidar com dados mais sensíveis, vale considerar
migrar para o Supabase Auth com políticas de RLS por usuário.
