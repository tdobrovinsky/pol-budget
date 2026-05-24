# Deployment Guide

## What you need (all free)
- Supabase account — database + auth
- Netlify account — web hosting

---

## Step 1 — Run the database SQL

1. Open your Supabase project → **SQL Editor** (left sidebar)
2. Click **New query**
3. Paste the contents of `supabase-setup.sql`
4. Click **Run**

You should see "Success. No rows returned."

---

## Step 2 — Configure Auth settings (optional but recommended)

In Supabase → **Authentication** → **Settings**:

- **Email confirmations** → turn OFF if you want family/friends to sign in immediately without clicking a confirmation email. Leave ON for more security.
- Leave everything else as default for now.

---

## Step 3 — Deploy to Netlify

1. Go to [netlify.com](https://netlify.com) and sign up (free)
2. From your dashboard, look for **"Deploy manually"** or drag-and-drop area
3. Drag the `budget.html` file onto the Netlify drop zone
4. Netlify gives you a URL like `https://random-name-123.netlify.app`

**That's your app URL.** Share it with anyone you want to give access.

---

## Step 4 — Set your Netlify URL in Supabase

1. Copy your Netlify URL (e.g. `https://random-name-123.netlify.app`)
2. Supabase → **Authentication** → **URL Configuration**
3. Set **Site URL** to your Netlify URL
4. Add it to **Redirect URLs** as well

This ensures auth confirmation emails link back to your app.

---

## How it works for users

1. User visits your Netlify URL
2. They see a **Sign In / Create Account** screen
3. They create an account with email + password
4. Their data is saved privately in the cloud — no one else can see it
5. They can log in from any device and their budget is there

---

## Giving someone access

Just send them the Netlify URL. They sign up themselves.
If you turned off email confirmation, they can use it immediately.
If email confirmation is on, they click the link in the email first.

---

## Custom domain (optional)

Netlify lets you connect a custom domain (e.g. `budget.yourname.com`) for free if you own a domain. Go to Netlify → your site → **Domain settings**.

---

## Pushing updates (after first-time setup)

The repo is connected to GitHub → Netlify for auto-deploy.

1. Edit `budget.html` (the source of truth).
2. Copy it to `index.html` (Netlify serves `index.html`):
   ```
   cp budget.html index.html
   ```
3. Commit and push:
   ```
   git add budget.html index.html
   git commit -m "your message"
   git push
   ```
4. Netlify rebuilds in ~30s. Hard-refresh the live app to see changes (Cmd-Shift-R on Mac).

### If git complains about a stuck lock
Sometimes the Cowork sandbox leaves a stale `.git/HEAD.lock` or `.git/index.lock`. Clear and retry from your own terminal:
```
cd ~/Documents/Claude/Projects/"Pol Budgeting"
rm -f .git/HEAD.lock .git/index.lock
```

### Editing the deployed app's database / auth
- DB tables live in Supabase → SQL Editor (`supabase-setup.sql` is the schema)
- Auth users: Supabase → Authentication → Users
- App URL whitelist: Supabase → Authentication → URL Configuration
