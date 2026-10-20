# The Breach Files — Case 07: The Glasshouse Incident

A five-stage cybersecurity investigation game. All systems, people and data are fictional.
Google sign-in and progress storage use Supabase. Built with Vite and plain JavaScript.

## Run locally
1. `npm install`
2. Copy `.env.example` to `.env` and fill in your Supabase project URL and **anon** key.
3. `npm run dev`

## Supabase setup
1. Run `supabase/migrations/0001_init.sql` in the SQL Editor.
2. Authentication → Providers → Google: enable it with your Google Cloud OAuth client ID and secret.
   In Google Cloud, add `https://<project>.supabase.co/auth/v1/callback` as an authorized redirect URI.
3. Authentication → URL Configuration: set Site URL to your deployed address and add
   `http://localhost:5173` and your Vercel URL to the redirect URLs.

## Deploy to GitHub and Vercel
1. Create a GitHub repo and push this folder (`.env` is ignored).
2. Import the repo in Vercel. Framework preset: Vite. Add `VITE_SUPABASE_URL` and `VITE_SUPABASE_ANON_KEY`.
3. Deploy, then add the Vercel URL to Supabase's redirect URLs.

## Known limitations
- Scoring and stage unlocks run in the browser. Progress is stored per user with row-level security,
  but a user could edit their own saved state. Server-side scoring is not implemented.
- Teams, join codes, an organizer dashboard and hidden answer keys are not implemented.
- No automated tests yet.
Never put the Supabase service-role key in this project.
