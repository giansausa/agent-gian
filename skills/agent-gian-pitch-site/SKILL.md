---
name: agent-gian-pitch-site
version: 0.1.0
description: |
  Scaffold and ship a complete pitch-grade marketing website for any small
  business — offroad shop, salon, restaurant, dental clinic, café — using the
  exact architecture, design system, motion language, and pitch-flow proven on
  Carnage Off-road Autoshop (carnageautoshop.vercel.app). Output: Next.js 16 +
  Tailwind v4 + Vercel, deployable in one git push. Use when the user says
  "build a pitch site", "scaffold a marketing website for [business]",
  "I want a Carnage-style site", or describes selling a service-business
  website to a real Filipino SMB.
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
  - WebFetch
  - AskUserQuestion
triggers:
  - pitch site
  - marketing website
  - carnage-style site
  - scaffold a website
  - build a website for
  - sell a website to
---

# Agent Gian — Pitch Site

A pitch site is a paid deliverable for a Filipino small business: one Next.js + Tailwind v4 codebase, deployed to Vercel under a free `*.vercel.app` URL or a real domain, that loads under a second on phones and looks like a 7-figure brand. This skill captures every decision, every code template, and every Gemini prompt from the Carnage build so you never re-explain.

The reference build: **carnageautoshop.vercel.app** · source: `C:/Users/gians/OneDrive/Desktop/Carnage Offroad Autoshop/carnage-offroad/`.

## When to invoke

Trigger this skill when the user says any of:
- "Build a pitch site for [business]"
- "Scaffold a marketing website for [business]"
- "I want a Carnage-style site"
- "Make a website I can sell to a small business"
- "Set up a one-page marketing site for my client"
- "Ship a 9-section marketing site"

Skip if the user wants a generic Next.js starter, an admin dashboard, an e-commerce checkout, or anything that needs a backend, auth, or DB writes. This is a pitch / marketing site only — every CTA is a phone call, FB DM, SMS, or email; no booking system, no payment, no user accounts.

## Onboarding interview — one question at a time

Run via `AskUserQuestion`. Single multiple-choice per turn. Recommend one option in the question prose. **Never** combine the visual companion offer with other content.

Before question 1, explore project context: run `pwd`, check for an existing repo, read CLAUDE.md if present.

### Q1 — business name + city

> What's the business name and city? (e.g. "Bayan Coffee Roasters · Quezon City")

Free-text. Save as `BUSINESS_NAME` and `BUSINESS_CITY`.

### Q2 — brand personality (visual companion required)

Offer the visual companion as its own message first: "I'll mock up 3 brand-personality directions side-by-side before we lock the look. One sec."

Then present:

> **A · Clean Pro** — Inter throughout, charcoal + white, accent blue, gentle rounded corners. Reads like a Stripe / Linear pricing page. Best for: clinics, dental, accounting, B2B services.
>
> **B · Edgy Garage (Carnage's pick)** — Anton display + Inter body, white + red accent, square clip-angle CTAs, italic skewed wordmark, Ken Burns hero. Reads like Off-road Magazine. Best for: workshops, autoshops, gyms, barbers, anything blue-collar premium.
>
> **C · Premium Build** — Playfair Display + Inter, ivory + warm-black + brass accent, generous whitespace, pinned hero photography, no clip-angle. Reads like a Michelin-recommended restaurant or a boutique salon. Best for: cafés, salons, restaurants, boutique retail.
>
> **My pick:** Edgy Garage if they sell trucks/tools/builds. Premium Build for everything else (cafés, beauty, food, hospitality). Clean Pro for clinics/B2B.

Save as `BRAND_PERSONALITY`.

### Q3 — brand colors

> The default for [BRAND_PERSONALITY] is [defaults below]. Override?
> - Edgy Garage default: white #ffffff + red accent #ff1f1f, deep #c8102e
> - Premium Build default: ivory #f8f5ee + warm-black #1a1612 + brass #b8893d
> - Clean Pro default: white #ffffff + charcoal #111111 + blue accent #2563eb

Save 4 hex codes: `--color-bg-base`, `--color-bg-dark`, `--color-accent`, `--color-accent-deep`.

### Q4 — 3-line motto

> The hero shows a 3-line motto, all-caps, with the **last line in the accent color**. Carnage's is `BUILD IT. / LIFT IT. / DOMINATE ANY TERRAIN.` What are yours?

Constraint: each line ≤ 4 short words. The last line is the punchline.

### Q5 — tagline

> One sentence: what they sell, for whom. Sub-15 words. Carnage's: "Lifts. Bumpers. Mags. Builds — for Hilux, Ranger, D-Max, Triton, BT-50."

### Q6 — categories (5 to 9)

> List 5–9 product or service categories. For each, give: slug · name · short label · 1-line tagline · 2–3 brand/sub-product samples.
>
> Example (Carnage): `lift-kits · Lift Kits · 2" Suspension · Trail clearance for Hilux, Ranger, D-Max, Triton, BT-50. · 2" · OME · Bilstein`

Save as `CATEGORIES[]`.

### Q7 — 3 trust pillars

> The "Why [Business]" section uses 3 cards with red Anton numbers (01 / 02 / 03). Each card has a 3–6 word title and a 20-word body. What are your 3 pillars? Carnage's are: Free labor installation · Installment terms accepted · Trail-tested brands.

### Q8 — brand-strip partners

> List 6–10 brand-name partners shown in greyscale on the brand strip. These are name-drops — they don't need logos. Carnage's: Profender · ARB · Bilstein · Fox · Fuel Off-Road · Old Man Emu · Panther · Roll-N-Lock.

### Q9 — process steps (4)

> The Process section has 4 steps with icons (chat / key / wrench / truck). Adapt the verbs to the business. Carnage's: Inquire · Drop off · Build · Drive away. Coffee shop: Order · Roast · Brew · Sip. Salon: Consult · Cleanse · Style · Glow up.

### Q10 — shop info

> Need 7 fields:
> - Address line 1 + line 2
> - City + zip + region
> - Mobile / primary phone (with country code, e.g. +639...)
> - Landline (optional)
> - FB page URL + handle (the part after fb.com/)
> - Email (optional — leave blank to hide email button in quote modal)
> - Hours (e.g. "Mon–Sat · 9:30am–5:30pm")
> - Google Maps embed URL (Maps → Share → Embed a map → copy the iframe `src`)
> - Google Maps share URL (Maps → Share → Copy link)

### Q11 — vehicle / customer filter list

> The product detail pages have filter chips (`All · Filter1 · Filter2 · …`). For Carnage these were vehicle fitments: All · Hilux · Ranger · D-Max · Triton · BT-50 · Other. What's the equivalent for your business?
>
> - Salon: All · Long hair · Short hair · Color · Bridal
> - Café: All · Hot · Iced · Pastry · Single-origin
> - Clinic: All · General · Pediatric · Cosmetic · Emergency

If the business doesn't need filters, skip this — the FilterChips component can be omitted from product pages.

### Q12 — selling points

> Three yes/no toggles:
> - Free labor / free consultation? (booleans displayed in trust pillars)
> - Installment plans? (booleans displayed in trust pillars)
> - Best-seller badges on certain products? (red corner-cut badges)

### Q13 — quote modal config

> The Request a Quote modal sends via SMS (always) + Email (only if `SHOP.email` is set). Messenger was tried for Carnage and kept failing — it stays disabled. Confirm:
> - Keep the floating quote button? (default yes)
> - Use SMS as primary channel? (default yes — universal, works on every PH phone)
> - Need email button? (only if owner has a real address)

After Q13, proceed straight to scaffolding. Do not ask for confirmation — the user has answered enough.

## Architecture — file tree to scaffold

Mirror Carnage exactly:

```
<slug>/
├── app/
│   ├── globals.css
│   ├── layout.tsx
│   ├── page.tsx                      # 9-section homepage
│   ├── not-found.tsx                 # site-wide 404
│   └── products/
│       └── [slug]/
│           ├── page.tsx              # generateStaticParams over CATEGORIES
│           └── not-found.tsx
├── components/
│   ├── Nav.tsx
│   ├── Footer.tsx
│   ├── DemoRibbon.tsx                # "Sample demo · created by [you]"
│   ├── RequestQuote.tsx              # client modal
│   ├── primitives/
│   │   ├── PrimaryCTA.tsx
│   │   ├── SecondaryCTA.tsx
│   │   ├── Microlabel.tsx
│   │   ├── SectionHeader.tsx
│   │   └── Reveal.tsx                # client, IntersectionObserver
│   ├── home/
│   │   ├── Hero.tsx                  # client, 3-image rotation + Ken Burns
│   │   ├── ProductsGrid.tsx
│   │   ├── WhyCarnage.tsx            # rename to Why<Business>
│   │   ├── BrandStrip.tsx
│   │   ├── HotPicks.tsx
│   │   ├── Process.tsx
│   │   ├── FacebookFeed.tsx
│   │   ├── Gallery.tsx               # client, lightbox
│   │   └── Location.tsx
│   └── product/
│       ├── CategoryHero.tsx
│       ├── FilterChips.tsx           # client, useState
│       ├── ProductCard.tsx
│       └── EmptyState.tsx
├── data/
│   ├── shop.ts                       # single source of truth
│   ├── copy.ts                       # every user-facing string
│   ├── categories.ts
│   ├── products.ts
│   └── gallery.ts
├── lib/
│   └── cn.ts                         # className joiner
├── public/
│   ├── hero/                         # 3 hero variants (PNG, ~3840×1644)
│   ├── sections/                     # 2 section banners
│   ├── categories/                   # 1 image per category
│   ├── products/
│   │   └── placeholder.svg
│   ├── gallery/                      # 8–12 real photos from FB
│   └── logo/                         # favicon + OG image
├── tests/
│   └── smoke.spec.ts
├── package.json
├── tsconfig.json
├── next.config.ts
├── playwright.config.ts
├── postcss.config.mjs
├── eslint.config.mjs
└── README.md
```

## Tech stack + startup commands

```bash
# Working dir example: C:/Users/gians/Downloads/<slug>/  (mind path-with-space quoting on Windows)
npx create-next-app@latest <slug> --ts --tailwind --eslint --app --no-src-dir --turbopack --import-alias "@/*" --use-npm --no-git
cd <slug>

# init repo
git init
git branch -M main

# install runtime deps
npm install yet-another-react-lightbox @vercel/analytics

# install playwright (dev)
npm install -D @playwright/test
npx playwright install --with-deps chromium

# type-check gate (run after every file edit)
npx tsc --noEmit
```

After every task step: `npx tsc --noEmit && git add <specific files> && git commit -m "feat(<area>): <change>"`. **Never** `git add -A` — stage by name. One logical change per commit (Agent Gian rule §V). Auto-push if user opted in.

## Tailwind v4 brand tokens — full `app/globals.css`

Tailwind v4 uses CSS-only config — no `tailwind.config.js`. All tokens live inside the `@theme` block and become utilities automatically (`bg-bg-base`, `text-accent`, etc.). Replace the four color hexes with the user's picks from Q3.

```css
@import "tailwindcss";

@theme {
  --color-bg-base: #ffffff;        /* page background */
  --color-bg-alt: #f9f9f9;         /* alternating section background */
  --color-bg-dark: #0a0a0a;        /* dark sections (Why / Gallery / EmptyState) */
  --color-accent: #ff1f1f;         /* primary accent — links, CTAs, microlabels */
  --color-accent-deep: #c8102e;    /* CTA hover */
  --color-ink: #111111;            /* body text */
  --color-ink-muted: #666666;      /* secondary text */
  --color-ink-faint: #888888;      /* tertiary text + dark-section sub */
  --color-border-soft: #eeeeee;    /* hairline borders */

  --font-display: var(--font-anton), 'Impact', 'Arial Black', sans-serif;
  --font-body: var(--font-inter), -apple-system, BlinkMacSystemFont, sans-serif;
}

* {
  box-sizing: border-box;
}

html, body {
  margin: 0;
  padding: 0;
  background: var(--color-bg-base);
  color: var(--color-ink);
  font-family: var(--font-body);
  -webkit-font-smoothing: antialiased;
}

/* Hero animation: Ken Burns drift */
@keyframes ken-burns {
  0%   { transform: scale(1) translate(0, 0); }
  100% { transform: scale(1.12) translate(-2%, -1.5%); }
}

.ken-burns {
  animation: ken-burns 8s ease-in-out infinite alternate;
  transform-origin: 60% 70%;
  will-change: transform;
}

/* Angled-cut button (garage feel — drop for Premium Build personality) */
.clip-angle {
  clip-path: polygon(6% 0, 100% 0, 94% 100%, 0 100%);
}

/* Skew helper for the logo wordmark */
.skew-logo {
  transform: skew(-5deg);
}

/* Parallax background — works on desktop, fallback handled per-component on iOS */
.bg-fixed-cover {
  background-attachment: fixed;
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
}

/* Reduced motion — kill animations */
@media (prefers-reduced-motion: reduce) {
  .ken-burns { animation: none; }
  .bg-fixed-cover { background-attachment: scroll; }
  * { transition: none !important; }
}

/* Skip-to-content link (a11y) */
.skip-link {
  position: absolute;
  top: -100px;
  left: 0;
  background: var(--color-accent);
  color: #fff;
  padding: 8px 12px;
  z-index: 100;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 1px;
  font-size: 12px;
}
.skip-link:focus { top: 0; }
```

For **Premium Build**, swap `--font-display` to Playfair Display, drop `.clip-angle` and `.skew-logo`, swap `.ken-burns` for a softer 12s zoom-out keyframe. For **Clean Pro**, drop the display font (Inter throughout), drop `.clip-angle`, soften the Ken Burns to a 14s pan.

## Fonts — `next/font/google` setup

```tsx
// app/layout.tsx (top portion)
import { Anton, Inter } from 'next/font/google';

const anton = Anton({
  subsets: ['latin'],
  weight: '400',
  variable: '--font-anton',
  display: 'swap',
});

const inter = Inter({
  subsets: ['latin'],
  variable: '--font-inter',
  display: 'swap',
});

// then on <html>
<html lang="en" className={`${anton.variable} ${inter.variable}`}>
```

For Premium Build, replace `Anton` with `Playfair_Display`. For Clean Pro, drop the display font import — pass only `inter.variable`.

## Root layout — full `app/layout.tsx`

```tsx
import type { Metadata } from 'next';
import { Anton, Inter } from 'next/font/google';
import { Analytics } from '@vercel/analytics/next';
import { RequestQuote } from '@/components/RequestQuote';
import { DemoRibbon } from '@/components/DemoRibbon';
import './globals.css';

const anton = Anton({
  subsets: ['latin'],
  weight: '400',
  variable: '--font-anton',
  display: 'swap',
});

const inter = Inter({
  subsets: ['latin'],
  variable: '--font-inter',
  display: 'swap',
});

export const metadata: Metadata = {
  title: '<BUSINESS_NAME> · <BUSINESS_CITY>',
  description: '<TAGLINE>',
  metadataBase: new URL('https://<DOMAIN-OR-VERCEL-URL>'),
  icons: {
    icon: '/logo/<slug>.jpg',
    apple: '/logo/<slug>.jpg',
  },
  openGraph: {
    title: '<BUSINESS_NAME>',
    description: '<TAGLINE>',
    type: 'website',
    images: [{ url: '/logo/<slug>.jpg', width: 1200, height: 630, alt: '<BUSINESS_NAME>' }],
  },
  twitter: {
    card: 'summary_large_image',
    title: '<BUSINESS_NAME>',
    description: '<TAGLINE>',
    images: ['/logo/<slug>.jpg'],
  },
  robots: { index: true, follow: true },
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en" className={`${anton.variable} ${inter.variable}`}>
      <body>
        <a href="#main" className="skip-link">Skip to content</a>
        <DemoRibbon />
        {children}
        <RequestQuote />
        <Analytics />
      </body>
    </html>
  );
}
```

## Homepage composition — `app/page.tsx`

```tsx
import { Nav } from '@/components/Nav';
import { Footer } from '@/components/Footer';
import { Hero } from '@/components/home/Hero';
import { ProductsGrid } from '@/components/home/ProductsGrid';
import { WhyCarnage } from '@/components/home/WhyCarnage';
import { BrandStrip } from '@/components/home/BrandStrip';
import { HotPicks } from '@/components/home/HotPicks';
import { Process } from '@/components/home/Process';
import { FacebookFeed } from '@/components/home/FacebookFeed';
import { Gallery } from '@/components/home/Gallery';
import { Location } from '@/components/home/Location';

export default function HomePage() {
  return (
    <>
      <Nav />
      <main id="main">
        <Hero />
        <ProductsGrid />
        <WhyCarnage />
        <BrandStrip />
        <HotPicks />
        <Process />
        <FacebookFeed />
        <Gallery />
        <Location />
      </main>
      <Footer />
    </>
  );
}
```

## Section 1 — Hero (`components/home/Hero.tsx`)

Client component. Three images crossfade every 7s with parallax + Ken Burns. 3-line motto in Anton uppercase, last line in accent color. Two CTAs (call + catalog). Indicator dots bottom-right.

```tsx
'use client';

import { useEffect, useState } from 'react';
import { COPY } from '@/data/copy';
import { SHOP } from '@/data/shop';
import { PrimaryCTA } from '@/components/primitives/PrimaryCTA';
import { SecondaryCTA } from '@/components/primitives/SecondaryCTA';
import { cn } from '@/lib/cn';

const HERO_IMAGES: string[] = [
  '/hero/<slug>-golden.png',
  '/hero/<slug>-stormy.png',
  '/hero/<slug>-shop.png',
];

const ROTATION_MS = 7000;
const FADE_MS = 1200;

export function Hero() {
  const [active, setActive] = useState(0);

  useEffect(() => {
    if (HERO_IMAGES.length <= 1) return;
    const id = setInterval(() => {
      setActive((prev) => (prev + 1) % HERO_IMAGES.length);
    }, ROTATION_MS);
    return () => clearInterval(id);
  }, []);

  return (
    <section
      id="hero"
      className="relative h-[80vh] min-h-[540px] overflow-hidden text-white bg-[var(--color-bg-dark)]"
    >
      {HERO_IMAGES.map((src, i) => (
        <div
          key={src}
          aria-hidden="true"
          className={cn(
            'absolute inset-0 bg-fixed-cover transition-opacity ease-in-out',
            i === active ? 'opacity-100' : 'opacity-0',
          )}
          style={{ backgroundImage: `url(${src})`, transitionDuration: `${FADE_MS}ms` }}
        >
          <div
            className="absolute inset-0 ken-burns bg-cover bg-center"
            style={{ backgroundImage: `url(${src})` }}
          />
        </div>
      ))}

      <div aria-hidden="true" className="absolute inset-0 bg-gradient-to-b from-black/30 via-black/10 to-black/80 z-[1]" />

      <div className="relative z-10 max-w-6xl mx-auto h-full px-5 flex flex-col justify-end pb-10">
        <span className="inline-block w-fit bg-[var(--color-accent)] text-white text-[10px] font-bold uppercase tracking-[2px] px-2 py-1 mb-3">
          {COPY.hero.badge}
        </span>
        <h1 className="font-[family-name:var(--font-display)] uppercase tracking-wide text-4xl sm:text-5xl md:text-6xl leading-[0.95] drop-shadow-lg">
          {COPY.hero.h1Line1}
          <br />
          {COPY.hero.h1Line2}
          <br />
          <span className="text-[var(--color-accent)]">{COPY.hero.h1Line3}</span>
        </h1>
        <p className="text-sm md:text-base mt-3 opacity-90 drop-shadow-md">{COPY.hero.tagline}</p>
        <div className="flex gap-3 mt-5">
          <PrimaryCTA href={`tel:${SHOP.phone}`}>{COPY.hero.ctaPrimary}</PrimaryCTA>
          <SecondaryCTA href="#products" variant="light">{COPY.hero.ctaSecondary}</SecondaryCTA>
        </div>
      </div>

      {HERO_IMAGES.length > 1 && (
        <div className="absolute bottom-3 right-5 z-10 flex gap-1.5">
          {HERO_IMAGES.map((src, i) => (
            <span
              key={src}
              aria-hidden="true"
              className={cn(
                'block w-1.5 h-1.5 rounded-full transition-all duration-500',
                i === active ? 'bg-[var(--color-accent)] w-4' : 'bg-white/40',
              )}
            />
          ))}
        </div>
      )}
    </section>
  );
}
```

## Section 2 — Products grid (`components/home/ProductsGrid.tsx`)

Full-bleed banner above + 9 image-backed cards with dark gradient, red left bar, hover zoom. Cards without an image fall back to a label-only tile.

```tsx
import Image from 'next/image';
import Link from 'next/link';
import { CATEGORIES } from '@/data/categories';
import { COPY } from '@/data/copy';
import { SectionHeader } from '@/components/primitives/SectionHeader';
import { Reveal } from '@/components/primitives/Reveal';

export function ProductsGrid() {
  return (
    <section id="products" className="py-12">
      <Reveal direction="fade" duration={900}>
        <div className="relative w-full aspect-[21/9] sm:aspect-[21/9] md:aspect-[21/8] max-h-[420px] overflow-hidden">
          <Image
            src="/sections/<N>-categories.jpg"
            alt="<BUSINESS_NAME> interior — all categories in one place"
            fill
            sizes="100vw"
            priority={false}
            className="object-cover"
          />
          <div aria-hidden="true" className="absolute inset-0 bg-gradient-to-t from-white via-white/30 to-transparent" />
        </div>
      </Reveal>

      <div className="px-5 max-w-6xl mx-auto -mt-6 md:-mt-10 relative z-10">
        <Reveal>
          <SectionHeader
            label={COPY.products.label}
            title={<>{COPY.products.h2Line1}<br />{COPY.products.h2Line2}</>}
            sub={COPY.products.sub}
          />
        </Reveal>
        <div className="grid grid-cols-2 md:grid-cols-3 gap-2 md:gap-4">
          {CATEGORIES.map((cat, i) => (
            <Reveal key={cat.slug} delay={i * 60}>
              <Link
                href={`/products/${cat.slug}`}
                className={
                  cat.image
                    ? 'group relative block rounded-md overflow-hidden h-32 md:h-40 hover:-translate-y-0.5 hover:shadow-lg transition-all'
                    : 'relative bg-[#f6f6f6] border border-[var(--color-border-soft)] rounded-md p-3 md:p-4 pl-5 md:pl-6 h-24 md:h-28 hover:-translate-y-0.5 hover:shadow-md transition-all flex flex-col justify-between'
                }
              >
                {cat.image ? (
                  <>
                    <Image
                      src={cat.image}
                      alt={`${cat.name} — <BUSINESS_NAME>`}
                      fill
                      sizes="(max-width: 768px) 50vw, 33vw"
                      className="object-cover transition-transform duration-500 group-hover:scale-105"
                    />
                    <div aria-hidden="true" className="absolute inset-0 bg-gradient-to-t from-black/80 via-black/30 to-transparent" />
                    <span aria-hidden="true" className="absolute top-0 left-0 h-full w-1 bg-[var(--color-accent)] z-10" />
                    <div className="absolute bottom-2.5 left-3 right-3 z-10">
                      <div className="text-xs md:text-sm font-bold uppercase tracking-wide text-white drop-shadow-lg">{cat.name}</div>
                      <div className="text-[10px] text-white/80 mt-0.5 drop-shadow">{cat.brandSamples}</div>
                    </div>
                    <div aria-hidden="true" className="absolute bottom-2 right-3 text-[var(--color-accent)] text-base z-10 drop-shadow">→</div>
                  </>
                ) : (
                  <>
                    <span className="absolute top-0 left-0 h-full w-1 bg-[var(--color-accent)]" aria-hidden="true" />
                    <div>
                      <div className="text-xs md:text-sm font-bold uppercase tracking-wide text-[var(--color-ink)]">{cat.name}</div>
                      <div className="text-[10px] text-[var(--color-ink-faint)] mt-0.5">{cat.brandSamples}</div>
                    </div>
                    <div className="text-[var(--color-accent)] text-base self-end" aria-hidden="true">→</div>
                  </>
                )}
              </Link>
            </Reveal>
          ))}
        </div>
      </div>
    </section>
  );
}
```

## Section 3 — Why [Business] (`components/home/WhyCarnage.tsx` → rename)

Dark section, 3 cards with red Anton numbers, copy lifted from Q7.

```tsx
import { COPY } from '@/data/copy';
import { SectionHeader } from '@/components/primitives/SectionHeader';
import { Reveal } from '@/components/primitives/Reveal';

export function WhyCarnage() {
  return (
    <section className="bg-[var(--color-bg-dark)] text-white px-5 py-12">
      <div className="max-w-6xl mx-auto">
        <Reveal>
          <SectionHeader
            label={COPY.why.label}
            title={<>{COPY.why.h2Line1}<br />{COPY.why.h2Line2}</>}
            light
          />
        </Reveal>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-3 md:gap-4">
          {COPY.why.cards.map((card, i) => (
            <Reveal key={card.title} delay={i * 100} direction="up">
              <div className="bg-black/40 border border-white/5 rounded-md p-4 h-full">
                <div className="font-[family-name:var(--font-display)] text-[var(--color-accent)] text-2xl leading-none">
                  {String(i + 1).padStart(2, '0')}
                </div>
                <h4 className="text-xs font-bold uppercase tracking-wide mt-2">{card.title}</h4>
                <p className="text-[11px] text-[var(--color-ink-faint)] mt-1.5 leading-snug">{card.body}</p>
              </div>
            </Reveal>
          ))}
        </div>
      </div>
    </section>
  );
}
```

If renaming the file/export to `Why<Business>`, update the import in `app/page.tsx` and the `cards` source in `data/copy.ts`. Carnage-style works fine for any business — no rename strictly required.

## Section 4 — Brand strip (`components/home/BrandStrip.tsx`)

Greyscale + opacity-60 by default, restores on hover.

```tsx
import { COPY } from '@/data/copy';
import { Microlabel } from '@/components/primitives/Microlabel';
import { Reveal } from '@/components/primitives/Reveal';

export function BrandStrip() {
  return (
    <section className="bg-[var(--color-bg-alt)] px-5 py-6">
      <div className="max-w-6xl mx-auto">
        <Reveal>
          <Microlabel className="text-center">{COPY.brands.label}</Microlabel>
        </Reveal>
        <div className="mt-4 flex flex-wrap items-center justify-center gap-4 md:gap-8 grayscale opacity-60 hover:opacity-100 hover:grayscale-0 transition-all">
          {COPY.brands.list.map((brand, i) => (
            <Reveal key={brand} delay={i * 60} as="span">
              <span className="text-sm md:text-base font-extrabold uppercase tracking-wider text-[var(--color-ink)] inline-block">
                {brand}
              </span>
            </Reveal>
          ))}
        </div>
      </div>
    </section>
  );
}
```

## Section 5 — Hot picks (`components/home/HotPicks.tsx`)

Full-bleed banner + horizontal-scroll carousel of `featured: true` products.

```tsx
import Image from 'next/image';
import { COPY } from '@/data/copy';
import { getFeaturedProducts } from '@/data/products';
import { SectionHeader } from '@/components/primitives/SectionHeader';
import { ProductCard } from '@/components/product/ProductCard';
import { Reveal } from '@/components/primitives/Reveal';

export function HotPicks() {
  const items = getFeaturedProducts(8);
  return (
    <section className="bg-[var(--color-bg-alt)] py-12">
      <Reveal direction="fade" duration={900}>
        <div className="relative w-full aspect-[21/9] md:aspect-[21/8] max-h-[420px] overflow-hidden">
          <Image
            src="/sections/moving-fast.jpg"
            alt="<BUSINESS_NAME> hot picks"
            fill
            sizes="100vw"
            className="object-cover"
          />
          <div aria-hidden="true" className="absolute inset-0 bg-gradient-to-t from-[var(--color-bg-alt)] via-[var(--color-bg-alt)]/30 to-transparent" />
        </div>
      </Reveal>

      <div className="px-5 max-w-6xl mx-auto -mt-6 md:-mt-10 relative z-10">
        <Reveal>
          <SectionHeader label={COPY.hotPicks.label} title={COPY.hotPicks.h2} sub={COPY.hotPicks.sub} />
        </Reveal>
        <Reveal delay={120}>
          <div
            className="flex gap-3 overflow-x-auto pb-2 -mx-5 px-5"
            style={{ scrollSnapType: 'x mandatory' }}
          >
            {items.map((p) => (
              <div key={p.id} style={{ scrollSnapAlign: 'start' }}>
                <ProductCard product={p} variant="carousel" />
              </div>
            ))}
          </div>
        </Reveal>
      </div>
    </section>
  );
}
```

## Section 6 — Process (`components/home/Process.tsx`)

4 steps with red Anton numbers + outlined SVG icons (paste exact paths). Icons are `currentColor` so they inherit the accent.

```tsx
import { COPY } from '@/data/copy';
import { SectionHeader } from '@/components/primitives/SectionHeader';
import { Reveal } from '@/components/primitives/Reveal';

const STEP_ICONS = [
  // 01 — Inquire (chat bubble)
  (
    <svg key="inquire" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" aria-hidden="true">
      <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z" />
      <line x1="8" y1="10" x2="16" y2="10" />
      <line x1="8" y1="13" x2="13" y2="13" />
    </svg>
  ),
  // 02 — Drop off (key)
  (
    <svg key="dropoff" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" aria-hidden="true">
      <circle cx="7" cy="15" r="4" />
      <line x1="9.83" y1="12.17" x2="22" y2="0" />
      <line x1="17" y1="5" x2="20" y2="8" />
      <line x1="14" y1="8" x2="17" y2="11" />
    </svg>
  ),
  // 03 — Build (wrench)
  (
    <svg key="build" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" aria-hidden="true">
      <path d="M14.7 6.3a1 1 0 0 0 0 1.4l1.6 1.6a1 1 0 0 0 1.4 0l3.77-3.77a6 6 0 0 1-7.94 7.94l-6.91 6.91a2.121 2.121 0 0 1-3-3l6.91-6.91a6 6 0 0 1 7.94-7.94l-3.76 3.76z" />
    </svg>
  ),
  // 04 — Drive away (truck)
  (
    <svg key="drive" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" aria-hidden="true">
      <path d="M1 3h13v13H1z" />
      <path d="M14 8h4l3 3v5h-7V8z" />
      <circle cx="5.5" cy="18.5" r="2.5" />
      <circle cx="18.5" cy="18.5" r="2.5" />
    </svg>
  ),
];

export function Process() {
  return (
    <section className="px-5 py-12 max-w-6xl mx-auto">
      <Reveal>
        <SectionHeader
          label={COPY.process.label}
          title={<>{COPY.process.h2Line1}<br />{COPY.process.h2Line2}</>}
        />
      </Reveal>
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4 md:gap-6">
        {COPY.process.steps.map((step, i) => (
          <Reveal key={step.n} delay={i * 120} direction="up">
            <div className="flex md:flex-col gap-3 md:gap-2">
              <div className="flex md:flex-col items-start gap-2 md:gap-1">
                <div className="text-[var(--color-accent)] w-9 h-9 md:w-10 md:h-10">
                  {STEP_ICONS[i]}
                </div>
                <div className="font-[family-name:var(--font-display)] text-[var(--color-ink-faint)] text-base md:text-sm leading-none mt-1">
                  {step.n}
                </div>
              </div>
              <div className="flex-1">
                <h4 className="text-xs font-bold uppercase tracking-wide text-[var(--color-ink)]">{step.title}</h4>
                <p className="text-[11px] text-[var(--color-ink-muted)] mt-1 leading-snug">{step.body}</p>
              </div>
            </div>
          </Reveal>
        ))}
      </div>
    </section>
  );
}
```

For non-Carnage businesses, swap the icon paths: coffee shop = mug / bag-of-beans / pour-over / cup. Salon = scissors / wash / comb / mirror. Use [feathericons.com](https://feathericons.com) — copy 24×24 viewBox, stroke-width 1.5.

## Section 7 — Facebook feed (`components/home/FacebookFeed.tsx`)

```tsx
import { COPY } from '@/data/copy';
import { SHOP } from '@/data/shop';
import { SectionHeader } from '@/components/primitives/SectionHeader';
import { Reveal } from '@/components/primitives/Reveal';

export function FacebookFeed() {
  const fbPluginUrl = `https://www.facebook.com/plugins/page.php?href=${encodeURIComponent(
    SHOP.fbUrl,
  )}&tabs=timeline&width=500&height=500&small_header=true&adapt_container_width=true&hide_cover=false&show_facepile=true`;
  return (
    <section id="updates" className="px-5 py-12 max-w-6xl mx-auto">
      <Reveal>
        <SectionHeader label={COPY.facebook.label} title={COPY.facebook.h2} />
      </Reveal>
      <Reveal delay={120}>
        <div className="flex justify-center">
          <iframe
            src={fbPluginUrl}
            title="<BUSINESS_NAME> Facebook page"
            width={500}
            height={500}
            style={{ border: 'none', overflow: 'hidden', minHeight: 500, maxWidth: '100%' }}
            loading="lazy"
            allow="encrypted-media"
          />
        </div>
        <noscript>
          <p className="text-center text-sm mt-4">
            <a href={SHOP.fbUrl} target="_blank" rel="noopener" className="text-[var(--color-accent)] underline">
              Visit our Facebook page
            </a>
          </p>
        </noscript>
      </Reveal>
    </section>
  );
}
```

If the business has Instagram instead of FB, swap the iframe for [SnapWidget](https://snapwidget.com) free embed and rename labels accordingly.

## Section 8 — Gallery (`components/home/Gallery.tsx`)

Client component. 3-col mobile / 4-col desktop. `wide` items span 2 cols. Video tiles get a red play badge. Lightbox is `yet-another-react-lightbox` with the Video plugin.

```tsx
'use client';

import { useState } from 'react';
import Image from 'next/image';
import Lightbox from 'yet-another-react-lightbox';
import Video from 'yet-another-react-lightbox/plugins/video';
import 'yet-another-react-lightbox/styles.css';

import { COPY } from '@/data/copy';
import { GALLERY } from '@/data/gallery';
import { SectionHeader } from '@/components/primitives/SectionHeader';
import { Reveal } from '@/components/primitives/Reveal';
import { cn } from '@/lib/cn';

export function Gallery() {
  const [openIndex, setOpenIndex] = useState<number | null>(null);

  const slides = GALLERY.map((item) => {
    if (item.type === 'video') {
      return {
        type: 'video' as const,
        sources: [{ src: item.src, type: 'video/mp4' }],
        poster: item.thumb,
        autoPlay: true,
      };
    }
    return { src: item.src, alt: item.caption ?? '' };
  });

  return (
    <section id="gallery" className="bg-[var(--color-bg-dark)] text-white px-5 py-12">
      <div className="max-w-6xl mx-auto">
        <Reveal>
          <SectionHeader label={COPY.gallery.label} title={COPY.gallery.h2} sub={COPY.gallery.sub} light />
        </Reveal>
        <div className="grid grid-cols-3 md:grid-cols-4 gap-1 md:gap-2">
          {GALLERY.map((item, i) => (
            <Reveal
              key={`${item.src}-${i}`}
              delay={i * 50}
              className={cn(item.wide && 'col-span-2')}
            >
              <button
                type="button"
                onClick={() => setOpenIndex(i)}
                className={cn(
                  'relative w-full bg-gray-800 rounded-sm overflow-hidden aspect-square transition-transform duration-300 hover:scale-[1.02]',
                  item.wide && 'aspect-[2/1]',
                )}
                aria-label={item.caption ?? `Gallery item ${i + 1}`}
              >
                <Image
                  src={item.thumb ?? item.src}
                  alt={item.caption ?? ''}
                  fill
                  sizes="(max-width: 768px) 33vw, 25vw"
                  className="object-cover"
                />
                {item.type === 'video' && (
                  <span aria-hidden="true" className="absolute inset-0 flex items-center justify-center">
                    <span className="w-8 h-8 rounded-full bg-[var(--color-accent)] flex items-center justify-center">
                      <span className="block w-0 h-0 border-l-[8px] border-l-white border-y-[5px] border-y-transparent ml-0.5" />
                    </span>
                  </span>
                )}
              </button>
            </Reveal>
          ))}
        </div>
        <Lightbox
          open={openIndex !== null}
          index={openIndex ?? 0}
          close={() => setOpenIndex(null)}
          slides={slides}
          plugins={[Video]}
        />
      </div>
    </section>
  );
}
```

## Section 9 — Location (`components/home/Location.tsx`)

```tsx
import { COPY } from '@/data/copy';
import { SHOP, formatAddress } from '@/data/shop';
import { SectionHeader } from '@/components/primitives/SectionHeader';
import { PrimaryCTA } from '@/components/primitives/PrimaryCTA';
import { SecondaryCTA } from '@/components/primitives/SecondaryCTA';
import { Reveal } from '@/components/primitives/Reveal';

export function Location() {
  return (
    <section id="visit" className="px-5 py-12 max-w-6xl mx-auto">
      <Reveal>
        <SectionHeader label={COPY.location.label} title={COPY.location.h2} />
      </Reveal>
      <div className="grid gap-4 md:grid-cols-[3fr_2fr]">
        <Reveal direction="left" delay={80}>
          <div className="rounded-md overflow-hidden border border-[var(--color-border-soft)] aspect-[4/3] md:aspect-auto md:h-[300px]">
            <iframe
              src={SHOP.mapsEmbedUrl}
              title="<BUSINESS_NAME> on Google Maps"
              width="100%"
              height="100%"
              style={{ border: 0 }}
              loading="lazy"
              referrerPolicy="no-referrer-when-downgrade"
              allowFullScreen
            />
          </div>
        </Reveal>
        <Reveal direction="right" delay={160}>
          <div className="text-sm">
            <div className="mb-4">
              <div className="text-[10px] font-bold uppercase tracking-widest text-[var(--color-accent)]">Address</div>
              <p className="mt-1 text-[var(--color-ink)]">{formatAddress()}</p>
            </div>
            <div className="mb-4">
              <div className="text-[10px] font-bold uppercase tracking-widest text-[var(--color-accent)]">Hours</div>
              <p className="mt-1 text-[var(--color-ink)]">{SHOP.hours}</p>
            </div>
            <div className="flex flex-wrap gap-2 mt-4">
              <SecondaryCTA href={SHOP.mapsUrl} variant="dark" external>
                {COPY.location.ctaMaps}
              </SecondaryCTA>
              <PrimaryCTA href={`tel:${SHOP.phone}`}>{COPY.location.ctaCall}</PrimaryCTA>
            </div>
          </div>
        </Reveal>
      </div>
    </section>
  );
}
```

## Product detail pages — `app/products/[slug]/page.tsx`

Async server component. `generateStaticParams` over `CATEGORIES`. `generateMetadata` per category. `notFound()` on unknown slug.

```tsx
import { notFound } from 'next/navigation';
import type { Metadata } from 'next';
import { CATEGORIES, getCategoryBySlug } from '@/data/categories';
import { getProductsByCategory } from '@/data/products';
import { Nav } from '@/components/Nav';
import { Footer } from '@/components/Footer';
import { CategoryHero } from '@/components/product/CategoryHero';
import { FilterChips } from '@/components/product/FilterChips';
import { EmptyState } from '@/components/product/EmptyState';

type Params = { slug: string };

export function generateStaticParams(): Params[] {
  return CATEGORIES.map((c) => ({ slug: c.slug }));
}

export async function generateMetadata({ params }: { params: Promise<Params> }): Promise<Metadata> {
  const { slug } = await params;
  const category = getCategoryBySlug(slug);
  if (!category) return { title: 'Category not found · <BUSINESS_NAME>' };
  return {
    title: `${category.name} · <BUSINESS_NAME>`,
    description: category.tagline,
  };
}

export default async function CategoryPage({ params }: { params: Promise<Params> }) {
  const { slug } = await params;
  const category = getCategoryBySlug(slug);
  if (!category) notFound();
  const products = getProductsByCategory(category.slug);

  return (
    <>
      <Nav />
      <main id="main">
        <CategoryHero category={category} />
        <FilterChips products={products} />
        <EmptyState />
      </main>
      <Footer />
    </>
  );
}
```

`app/products/[slug]/not-found.tsx`:

```tsx
import Link from 'next/link';
import { Nav } from '@/components/Nav';
import { Footer } from '@/components/Footer';
import { PrimaryCTA } from '@/components/primitives/PrimaryCTA';

export default function NotFound() {
  return (
    <>
      <Nav />
      <main id="main" className="px-5 py-20 max-w-3xl mx-auto text-center">
        <h1 className="font-[family-name:var(--font-display)] uppercase tracking-wide text-4xl">Category not found</h1>
        <p className="text-sm text-[var(--color-ink-muted)] mt-2">That product line doesn&apos;t exist (yet).</p>
        <div className="mt-6 flex justify-center gap-2">
          <PrimaryCTA href="/#products">See all categories</PrimaryCTA>
        </div>
        <Link href="/" className="block mt-8 text-xs uppercase tracking-widest text-[var(--color-ink-faint)] hover:text-[var(--color-accent)]">
          ← Back home
        </Link>
      </main>
      <Footer />
    </>
  );
}
```

`app/not-found.tsx` for site-wide 404:

```tsx
import { Nav } from '@/components/Nav';
import { Footer } from '@/components/Footer';
import { PrimaryCTA } from '@/components/primitives/PrimaryCTA';

export default function NotFound() {
  return (
    <>
      <Nav />
      <main id="main" className="px-5 py-20 max-w-3xl mx-auto text-center">
        <h1 className="font-[family-name:var(--font-display)] uppercase tracking-wide text-5xl text-[var(--color-accent)]">404</h1>
        <p className="text-base text-[var(--color-ink-muted)] mt-2">Page not found. Check the URL or head back home.</p>
        <div className="mt-6 flex justify-center">
          <PrimaryCTA href="/">Back home</PrimaryCTA>
        </div>
      </main>
      <Footer />
    </>
  );
}
```

### `components/product/CategoryHero.tsx`

```tsx
import { COPY } from '@/data/copy';
import { SHOP } from '@/data/shop';
import type { Category } from '@/data/categories';
import { PrimaryCTA } from '@/components/primitives/PrimaryCTA';
import { SecondaryCTA } from '@/components/primitives/SecondaryCTA';

export function CategoryHero({ category }: { category: Category }) {
  return (
    <section className="bg-[var(--color-bg-dark)] text-white px-5 py-10">
      <div className="max-w-6xl mx-auto">
        <span className="block text-[10px] font-bold uppercase tracking-[2px] text-[var(--color-accent)]">
          Category · {category.short}
        </span>
        <h1 className="font-[family-name:var(--font-display)] uppercase tracking-wide text-4xl md:text-5xl leading-none mt-2">
          {category.name}
        </h1>
        <p className="text-sm text-[var(--color-ink-faint)] mt-2 max-w-2xl">{category.tagline}</p>
        <div className="flex flex-wrap gap-2 mt-5">
          <PrimaryCTA href={`tel:${SHOP.phone}`}>{COPY.productDetail.ctaInquire}</PrimaryCTA>
          <SecondaryCTA href={SHOP.fbUrl} variant="light" external>
            {COPY.productDetail.ctaFB}
          </SecondaryCTA>
        </div>
      </div>
    </section>
  );
}
```

### `components/product/FilterChips.tsx`

```tsx
'use client';

import { useState } from 'react';
import { FITMENTS, type Fitment } from '@/data/categories';
import type { Product } from '@/data/products';
import { ProductCard } from '@/components/product/ProductCard';
import { cn } from '@/lib/cn';

type Props = { products: Product[] };
type Choice = 'All' | Fitment;

export function FilterChips({ products }: Props) {
  const [active, setActive] = useState<Choice>('All');
  const filtered = active === 'All' ? products : products.filter((p) => p.fitments.includes(active));
  const choices: Choice[] = ['All', ...FITMENTS];

  return (
    <>
      <div className="px-5 py-3 border-b border-[var(--color-border-soft)] flex gap-2 overflow-x-auto sticky top-[57px] bg-white/95 backdrop-blur-md z-40">
        {choices.map((choice) => (
          <button
            key={choice}
            type="button"
            onClick={() => setActive(choice)}
            className={cn(
              'text-[11px] font-bold px-3 py-1.5 rounded-full uppercase tracking-wide transition-colors whitespace-nowrap',
              active === choice ? 'bg-[var(--color-bg-dark)] text-white' : 'bg-gray-100 text-gray-700 hover:bg-gray-200',
            )}
            aria-pressed={active === choice}
          >
            {choice}
          </button>
        ))}
      </div>
      <section className="px-5 py-6 max-w-6xl mx-auto">
        {filtered.length === 0 ? (
          <p className="text-center text-sm text-[var(--color-ink-muted)] py-10">
            No items for {active}. Try another fitment or message us on FB.
          </p>
        ) : (
          <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 gap-3">
            {filtered.map((p) => (
              <ProductCard key={p.id} product={p} variant="detail" />
            ))}
          </div>
        )}
      </section>
    </>
  );
}
```

### `components/product/ProductCard.tsx`

```tsx
import Image from 'next/image';
import { COPY } from '@/data/copy';
import { SHOP } from '@/data/shop';
import type { Product } from '@/data/products';
import { cn } from '@/lib/cn';

type Props = { product: Product; variant?: 'detail' | 'carousel' };

export function ProductCard({ product, variant = 'detail' }: Props) {
  const isCarousel = variant === 'carousel';
  const wrapClasses = cn(
    'relative bg-white border border-[var(--color-border-soft)] rounded-md overflow-hidden flex flex-col',
    isCarousel && 'min-w-[160px] max-w-[160px] flex-shrink-0',
  );
  return (
    <a
      href={`tel:${SHOP.phone}`}
      className={cn(wrapClasses, 'hover:-translate-y-0.5 transition-transform')}
      aria-label={`Inquire about ${product.brand} ${product.name}`}
    >
      <div className="relative aspect-[4/3] bg-gray-100">
        <Image
          src={product.image}
          alt={`${product.brand} ${product.name}`}
          fill
          sizes="(max-width: 640px) 50vw, (max-width: 1024px) 33vw, 25vw"
          className="object-cover"
        />
        {product.bestSeller && !isCarousel && (
          <span className="absolute top-2 left-2 bg-[var(--color-accent)] text-white text-[9px] font-bold uppercase tracking-widest px-1.5 py-0.5 clip-angle">
            {COPY.productDetail.bestSeller}
          </span>
        )}
      </div>
      <div className="p-2.5 flex flex-col gap-1">
        <span className="text-[9px] font-bold uppercase tracking-widest text-[var(--color-accent)]">
          {product.brand}
        </span>
        <span className="text-xs font-semibold text-[var(--color-ink)] leading-tight line-clamp-2">
          {product.name}
        </span>
        <span className="text-[10px] text-[var(--color-ink-faint)]">{product.fitments.join(' · ')}</span>
        <span className="text-[10px] font-bold uppercase tracking-wider text-[var(--color-ink)] mt-1">
          {COPY.productDetail.inquireShort} →
        </span>
      </div>
    </a>
  );
}
```

### `components/product/EmptyState.tsx`

```tsx
import { COPY } from '@/data/copy';
import { SHOP } from '@/data/shop';
import { PrimaryCTA } from '@/components/primitives/PrimaryCTA';

export function EmptyState() {
  return (
    <section className="bg-[var(--color-bg-dark)] text-white px-5 py-10 text-center">
      <div className="max-w-6xl mx-auto">
        <h3 className="font-[family-name:var(--font-display)] uppercase tracking-wide text-2xl">{COPY.productDetail.emptyTitle}</h3>
        <p className="text-sm text-[var(--color-ink-faint)] mt-2">{COPY.productDetail.emptyBody}</p>
        <div className="mt-4">
          <PrimaryCTA href={SHOP.fbUrl} external>{COPY.productDetail.emptyCta}</PrimaryCTA>
        </div>
      </div>
    </section>
  );
}
```

## Data layer convention

All four files are static exports. No runtime fetching. Owner edits these to change content.

### `data/shop.ts`

```ts
export const SHOP = {
  name: '<BUSINESS_NAME>',
  tagline: '<TAGLINE>',
  phone: '+639...',                  // mobile (primary) — international format
  phoneDisplay: '0917-XXX-XXXX',     // human-readable
  landline: '+632...',                // optional; empty string disables
  landlineDisplay: '(02) XXXX-XXXX',
  fbUrl: 'https://www.facebook.com/<handle>',
  fbMessengerUrl: 'https://m.me/<handle>',
  fbHandle: '<handle>',
  email: '',                          // empty hides the Email button in the quote modal
  address: {
    line1: '<line 1>',
    line2: '<line 2>',
    city: '<city>',
    zip: '<zip>',
    region: '<region>',
  },
  wazeNote: '<landmark>',
  mapsUrl: 'https://www.google.com/maps/place/...',
  mapsEmbedUrl: 'https://www.google.com/maps/embed?pb=...',
  coords: { lat: 0, lng: 0 },
  hours: 'Mon–Sat · 9:30am–5:30pm',
  payments: ['<bank>', '<bank>'],
  freeLabor: true,
  installments: true,
} as const;

export const formatAddress = (): string =>
  `${SHOP.address.line1}, ${SHOP.address.line2}, ${SHOP.address.city}, ${SHOP.address.zip} ${SHOP.address.region}`;
```

### `data/copy.ts`

Every user-facing string lives here. Owner edits this without touching components.

```ts
export const COPY = {
  hero: {
    badge: '<BUSINESS_NAME> · YOUR <CATEGORY> SPECIALIST',
    h1Line1: '<MOTTO LINE 1>',
    h1Line2: '<MOTTO LINE 2>',
    h1Line3: '<MOTTO LINE 3 — accent>',
    tagline: '<TAGLINE>',
    ctaPrimary: 'Book a Build',
    ctaSecondary: 'Catalog',
  },
  products: {
    label: 'WHAT WE INSTALL',
    h2Line1: '<N> categories.',
    h2Line2: 'One garage.',
    sub: 'Tap any to see the catalog.',
  },
  why: {
    label: 'WHY <BUSINESS_NAME>',
    h2Line1: 'Built. Not',
    h2Line2: 'bolted on.',
    cards: [
      { title: '<PILLAR 1 TITLE>', body: '<PILLAR 1 BODY>' },
      { title: '<PILLAR 2 TITLE>', body: '<PILLAR 2 BODY>' },
      { title: '<PILLAR 3 TITLE>', body: '<PILLAR 3 BODY>' },
    ],
  },
  brands: {
    label: 'TRUSTED BRANDS WE INSTALL',
    list: ['<Brand 1>', '<Brand 2>', '<Brand 3>', '<Brand 4>', '<Brand 5>', '<Brand 6>'],
  },
  hotPicks: {
    label: 'HOT PICKS',
    h2: 'Moving fast.',
    sub: 'Swipe →',
  },
  process: {
    label: 'HOW IT WORKS',
    h2Line1: 'Drop. Build.',
    h2Line2: 'Drive.',
    steps: [
      { n: '01', title: '<STEP 1>', body: '<copy>' },
      { n: '02', title: '<STEP 2>', body: '<copy>' },
      { n: '03', title: '<STEP 3>', body: '<copy>' },
      { n: '04', title: '<STEP 4>', body: '<copy>' },
    ],
  },
  facebook: { label: 'LIVE FROM FACEBOOK', h2: 'Latest builds.' },
  gallery: {
    label: 'THE SHOP · THE BUILDS',
    h2: 'Wreckage in motion.',
    sub: 'Photos + clips from inside the bay.',
  },
  location: {
    label: 'VISIT THE SHOP',
    h2: '<CITY>, <STREET>.',
    ctaMaps: '📍 Open in Maps',
    ctaCall: '📞 Call now',
  },
  productDetail: {
    ctaInquire: '📞 Inquire to install',
    ctaFB: '📘 Visit FB Page',
    emptyTitle: "Don't see your build?",
    emptyBody: "Visit our Facebook page — send us a model + photo, we'll quote.",
    emptyCta: '📘 Visit our Facebook Page',
    bestSeller: 'Best Seller',
    inquireShort: '📞 Inquire',
  },
  nav: { products: 'Products', builds: 'Builds', visit: 'Visit' },
} as const;
```

### `data/categories.ts`

```ts
export type CategorySlug =
  | '<slug-1>'
  | '<slug-2>'
  | '<slug-3>';
  // ... up to 9

export type Category = {
  slug: CategorySlug;
  name: string;
  short: string;
  tagline: string;
  brandSamples: string;
  image?: string;
};

export const CATEGORIES: Category[] = [
  {
    slug: '<slug-1>',
    name: '<Name>',
    short: '<Short label>',
    tagline: '<1-line description>',
    brandSamples: '<Brand A · Brand B · Brand C>',
    image: '/categories/<slug-1>.jpg',
  },
  // ...
];

// Customer/vehicle/service filter (Q11). Skip if business doesn't filter.
export const FITMENTS = ['<Filter 1>', '<Filter 2>', '<Filter 3>', 'Other'] as const;
export type Fitment = typeof FITMENTS[number];

export const getCategoryBySlug = (slug: string): Category | undefined =>
  CATEGORIES.find((c) => c.slug === slug);
```

### `data/products.ts`

```ts
import type { CategorySlug, Fitment } from './categories';

export type Product = {
  id: string;
  category: CategorySlug;
  brand: string;
  name: string;
  fitments: Fitment[];
  image: string;
  featured?: boolean;
  bestSeller?: boolean;
};

export const PRODUCTS: Product[] = [
  // 3–5 products per category. Use /products/placeholder.svg until real photos exist.
  { id: '<unique-id>', category: '<slug>', brand: '<Brand>', name: '<Product>', fitments: ['<Filter>'], image: '/products/placeholder.svg', featured: true, bestSeller: true },
  // ...
];

export const getProductsByCategory = (slug: CategorySlug): Product[] =>
  PRODUCTS.filter((p) => p.category === slug);

export const getFeaturedProducts = (limit = 8): Product[] =>
  PRODUCTS.filter((p) => p.featured).slice(0, limit);
```

### `data/gallery.ts`

```ts
export type GalleryItem = {
  src: string;
  type: 'photo' | 'video';
  wide?: boolean;
  caption?: string;
  thumb?: string;
};

export const GALLERY: GalleryItem[] = [
  { src: '/gallery/<business>/build-1.jpg', type: 'photo', wide: true,  caption: '<caption>' },
  { src: '/gallery/<business>/build-2.jpg', type: 'photo',               caption: '<caption>' },
  // ... 8–12 entries. Mark 1–2 as `wide: true` for visual rhythm.
];
```

### Placeholder SVG — `public/products/placeholder.svg`

```svg
<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" width="400" height="300" viewBox="0 0 400 300">
  <rect width="400" height="300" fill="#f4f4f4"/>
  <text x="200" y="160" font-family="Inter, sans-serif" font-size="14" font-weight="700" fill="#888" text-anchor="middle" letter-spacing="2">PHOTO COMING</text>
</svg>
```

## Primitives

### `lib/cn.ts`

```ts
export function cn(...classes: (string | false | null | undefined)[]): string {
  return classes.filter(Boolean).join(' ');
}
```

### `components/primitives/PrimaryCTA.tsx`

```tsx
import Link from 'next/link';
import { cn } from '@/lib/cn';

type Props = { href: string; children: React.ReactNode; className?: string; external?: boolean };

export function PrimaryCTA({ href, children, className, external }: Props) {
  const classes = cn(
    'inline-block bg-[var(--color-accent)] text-white text-xs font-bold uppercase tracking-widest px-5 py-3 clip-angle hover:bg-[var(--color-accent-deep)] transition-colors',
    className,
  );
  if (external || href.startsWith('http') || href.startsWith('tel:') || href.startsWith('mailto:')) {
    return (
      <a href={href} className={classes} rel="noopener" target={external ? '_blank' : undefined}>
        {children}
      </a>
    );
  }
  return <Link href={href} className={classes}>{children}</Link>;
}
```

### `components/primitives/SecondaryCTA.tsx`

```tsx
import Link from 'next/link';
import { cn } from '@/lib/cn';

type Props = {
  href: string;
  children: React.ReactNode;
  className?: string;
  variant?: 'light' | 'dark';
  external?: boolean;
};

export function SecondaryCTA({ href, children, className, variant = 'light', external }: Props) {
  const variantClasses =
    variant === 'light'
      ? 'border-white text-white hover:bg-white hover:text-[var(--color-ink)]'
      : 'border-[var(--color-ink)] text-[var(--color-ink)] hover:bg-[var(--color-ink)] hover:text-white';
  const classes = cn(
    'inline-block bg-transparent border text-xs font-bold uppercase tracking-widest px-5 py-3 transition-colors',
    variantClasses,
    className,
  );
  if (external || href.startsWith('http') || href.startsWith('tel:') || href.startsWith('mailto:')) {
    return (
      <a href={href} className={classes} rel="noopener" target={external ? '_blank' : undefined}>
        {children}
      </a>
    );
  }
  return <Link href={href} className={classes}>{children}</Link>;
}
```

### `components/primitives/Microlabel.tsx`

```tsx
import { cn } from '@/lib/cn';

export function Microlabel({ children, className }: { children: React.ReactNode; className?: string }) {
  return (
    <span
      className={cn(
        'block text-[10px] font-bold uppercase tracking-[2px] text-[var(--color-accent)]',
        className,
      )}
    >
      {children}
    </span>
  );
}
```

### `components/primitives/SectionHeader.tsx`

```tsx
import { Microlabel } from './Microlabel';
import { cn } from '@/lib/cn';

type Props = {
  label: string;
  title: React.ReactNode;
  sub?: string;
  light?: boolean;
  className?: string;
};

export function SectionHeader({ label, title, sub, light, className }: Props) {
  return (
    <div className={cn('mb-6', className)}>
      <Microlabel>{label}</Microlabel>
      <h2
        className={cn(
          'font-[family-name:var(--font-display)] uppercase tracking-wide text-3xl md:text-4xl leading-none mt-1',
          light ? 'text-white' : 'text-[var(--color-ink)]',
        )}
      >
        {title}
      </h2>
      {sub && (
        <p className={cn('text-sm mt-2', light ? 'text-[var(--color-ink-faint)]' : 'text-[var(--color-ink-muted)]')}>
          {sub}
        </p>
      )}
    </div>
  );
}
```

### `components/primitives/Reveal.tsx`

Bidirectional `IntersectionObserver` — animation re-triggers on every viewport entry, NOT one-shot. Respects `prefers-reduced-motion`.

```tsx
'use client';

import { useEffect, useRef, useState } from 'react';
import { cn } from '@/lib/cn';

type Direction = 'up' | 'down' | 'left' | 'right' | 'fade';

type Props = {
  children: React.ReactNode;
  delay?: number;
  direction?: Direction;
  duration?: number;
  className?: string;
  as?: 'div' | 'span' | 'li';
};

const offsetClass: Record<Direction, string> = {
  up: 'translate-y-8',
  down: '-translate-y-8',
  left: 'translate-x-8',
  right: '-translate-x-8',
  fade: '',
};

export function Reveal({
  children,
  delay = 0,
  direction = 'up',
  duration = 700,
  className,
  as: Tag = 'div',
}: Props) {
  const ref = useRef<HTMLElement | null>(null);
  const [visible, setVisible] = useState(false);

  useEffect(() => {
    const el = ref.current;
    if (!el) return;

    if (typeof window !== 'undefined' && window.matchMedia('(prefers-reduced-motion: reduce)').matches) {
      setVisible(true);
      return;
    }

    const obs = new IntersectionObserver(
      ([entry]) => {
        setVisible(entry.isIntersecting);
      },
      { threshold: 0.15, rootMargin: '0px 0px -10% 0px' },
    );
    obs.observe(el);
    return () => obs.disconnect();
  }, []);

  return (
    <Tag
      // @ts-expect-error — ref attaches to the rendered element regardless of tag
      ref={ref}
      className={cn(
        'transition-all ease-out will-change-transform',
        visible ? 'opacity-100 translate-x-0 translate-y-0' : `opacity-0 ${offsetClass[direction]}`,
        className,
      )}
      style={{
        transitionDelay: `${delay}ms`,
        transitionDuration: `${duration}ms`,
      }}
    >
      {children}
    </Tag>
  );
}
```

## Nav + Footer + Demo Ribbon

### `components/Nav.tsx`

```tsx
import Link from 'next/link';
import { COPY } from '@/data/copy';
import { SHOP } from '@/data/shop';

export function Nav() {
  return (
    <nav className="sticky top-0 z-50 bg-white/95 backdrop-blur-md border-b border-[var(--color-border-soft)]">
      <div className="max-w-6xl mx-auto px-4 py-3 flex items-center justify-between gap-4">
        <Link href="/" className="font-[family-name:var(--font-display)] italic skew-logo text-xl tracking-wide text-[var(--color-accent)] inline-block" aria-label="<BUSINESS_NAME> home">
          <BUSINESS_WORDMARK>
        </Link>
        <div className="hidden sm:flex items-center gap-5 text-[10px] font-bold uppercase tracking-widest text-[var(--color-ink)]">
          <Link href="/#products" className="hover:text-[var(--color-accent)] transition-colors">{COPY.nav.products}</Link>
          <Link href="/#gallery" className="hover:text-[var(--color-accent)] transition-colors">{COPY.nav.builds}</Link>
          <Link href="/#visit" className="hover:text-[var(--color-accent)] transition-colors">{COPY.nav.visit}</Link>
        </div>
        <a
          href={`tel:${SHOP.phone}`}
          className="bg-[var(--color-accent)] text-white text-[10px] font-bold uppercase tracking-widest px-3 py-2 clip-angle hover:bg-[var(--color-accent-deep)] transition-colors"
        >
          📞 Call
        </a>
      </div>
    </nav>
  );
}
```

Replace `<BUSINESS_WORDMARK>` with the all-caps short form (Carnage uses `CARNAGE`, Bayan Coffee uses `BAYAN`).

### `components/Footer.tsx`

```tsx
import { SHOP, formatAddress } from '@/data/shop';

export function Footer() {
  return (
    <footer className="bg-[var(--color-bg-dark)] text-gray-400 px-4 py-8">
      <div className="max-w-6xl mx-auto">
        <div className="font-[family-name:var(--font-display)] italic skew-logo text-2xl tracking-wide text-[var(--color-accent)] inline-block">
          <BUSINESS_WORDMARK>
        </div>
        <p className="text-xs mt-1">{SHOP.tagline} · {SHOP.address.city}</p>

        <div className="grid grid-cols-1 sm:grid-cols-2 gap-6 mt-6 text-xs">
          <div>
            <h5 className="text-white text-[10px] uppercase tracking-widest mb-2">Visit</h5>
            <p>{formatAddress()}</p>
            <p className="mt-1">{SHOP.hours}</p>
          </div>
          <div>
            <h5 className="text-white text-[10px] uppercase tracking-widest mb-2">Reach us</h5>
            <p>📞 Mobile · <a href={`tel:${SHOP.phone}`} className="hover:text-white transition-colors">{SHOP.phoneDisplay}</a></p>
            <p className="mt-1">☎️ Landline · <a href={`tel:${SHOP.landline}`} className="hover:text-white transition-colors">{SHOP.landlineDisplay}</a></p>
            <p className="mt-1">📘 <a href={SHOP.fbUrl} target="_blank" rel="noopener" className="hover:text-white transition-colors">fb.com/{SHOP.fbHandle}</a></p>
          </div>
        </div>

        <p className="text-[10px] text-gray-600 mt-6">© <YEAR> {SHOP.name}</p>
      </div>
    </footer>
  );
}
```

### `components/DemoRibbon.tsx`

Slim header strip — sits **above** the sticky nav and scrolls out of view once the user scrolls. Only ship this on pitch demos (the goal is to credit the developer). Remove on production sites.

```tsx
export function DemoRibbon() {
  return (
    <div className="bg-[var(--color-bg-dark)] text-white text-[10px] sm:text-[11px] font-medium tracking-wide px-3 py-2 text-center">
      <span className="opacity-70">Sample website demo · created by</span>{' '}
      <span className="font-bold uppercase tracking-widest text-[var(--color-accent)]">Gian Clairon Sausa</span>{' '}
      <span className="opacity-70">for <BUSINESS_NAME></span>
    </div>
  );
}
```

**Convention:** every pitch site ships with the Demo Ribbon mounted in `app/layout.tsx` above all other content. Owner sees the credit on first load, decides if they want to keep it post-purchase.

## Request a Quote modal — `components/RequestQuote.tsx`

Floating red angle-cut button bottom-right (`z-60`). Opens a modal with name + phone (required), vehicle/service dropdown, multi-select category chips, notes textarea. Backdrop click + `Escape` closes. Body scroll locks while open. Sends via SMS (clipboard-copy + `sms:` link) or Email (mailto: — auto-hidden when `SHOP.email` is empty). Toast notification after copy. **Messenger was tried for Carnage and kept failing — leave it disabled.**

```tsx
'use client';

import { useEffect, useState } from 'react';
import { SHOP } from '@/data/shop';
import { CATEGORIES } from '@/data/categories';
import { cn } from '@/lib/cn';

const VEHICLE_OPTIONS = [
  '<Option 1>',
  '<Option 2>',
  '<Option 3>',
  'Other / not listed',
] as const;

function buildMessage(form: FormState) {
  return [
    `Quote request from ${form.name || '(no name)'}`,
    `Phone: ${form.phone || '(no phone)'}`,
    `Vehicle: ${form.vehicle || '(not specified)'}`,
    `Interested in: ${form.interestedIn.length ? form.interestedIn.join(', ') : '(not specified)'}`,
    `Notes: ${form.notes || '(none)'}`,
    '---',
    'Sent from <DOMAIN>',
  ].join('\n');
}

type FormState = {
  name: string;
  phone: string;
  vehicle: string;
  interestedIn: string[];
  notes: string;
};

const EMPTY: FormState = { name: '', phone: '', vehicle: '', interestedIn: [], notes: '' };

export function RequestQuote() {
  const [open, setOpen] = useState(false);
  const [form, setForm] = useState<FormState>(EMPTY);
  const [toast, setToast] = useState<string | null>(null);

  useEffect(() => {
    if (open) document.body.style.overflow = 'hidden';
    else document.body.style.overflow = '';
    return () => { document.body.style.overflow = ''; };
  }, [open]);

  useEffect(() => {
    if (!open) return;
    const onKey = (e: KeyboardEvent) => {
      if (e.key === 'Escape') setOpen(false);
    };
    window.addEventListener('keydown', onKey);
    return () => window.removeEventListener('keydown', onKey);
  }, [open]);

  function toggleCategory(name: string) {
    setForm((f) =>
      f.interestedIn.includes(name)
        ? { ...f, interestedIn: f.interestedIn.filter((n) => n !== name) }
        : { ...f, interestedIn: [...f.interestedIn, name] },
    );
  }

  function showToast(msg: string) {
    setToast(msg);
    setTimeout(() => setToast(null), 2400);
  }

  const isValid = form.name.trim().length > 0 && form.phone.trim().length > 0;
  const message = buildMessage(form);

  async function sendViaSMS() {
    if (!isValid) return;
    try {
      await navigator.clipboard.writeText(message);
      showToast('Message copied — opening SMS…');
    } catch {
      console.error('clipboard unavailable — SMS body still set via URL');
    }
    window.location.href = `sms:${SHOP.phone}?body=${encodeURIComponent(message)}`;
  }

  function sendViaEmail() {
    if (!isValid) return;
    window.location.href = `mailto:${SHOP.email}?subject=${encodeURIComponent(
      'Quote Request · <BUSINESS_NAME>',
    )}&body=${encodeURIComponent(message)}`;
  }

  return (
    <>
      <button
        type="button"
        onClick={() => setOpen(true)}
        className="fixed bottom-4 right-4 z-[60] bg-[var(--color-accent)] hover:bg-[var(--color-accent-deep)] text-white text-xs font-bold uppercase tracking-widest px-5 py-3 clip-angle shadow-lg shadow-black/30 transition-all hover:-translate-y-0.5"
        aria-label="Request a quote"
      >
        💬 Request a Quote
      </button>

      {open && (
        <div
          className="fixed inset-0 z-[100] flex items-end sm:items-center justify-center p-3 sm:p-6"
          role="dialog"
          aria-modal="true"
          aria-labelledby="quote-title"
        >
          <div
            className="absolute inset-0 bg-black/60 backdrop-blur-sm animate-in fade-in duration-200"
            onClick={() => setOpen(false)}
            aria-hidden="true"
          />

          <div className="relative bg-white w-full max-w-md rounded-lg shadow-2xl max-h-[92vh] overflow-y-auto">
            <div className="bg-[var(--color-bg-dark)] text-white px-5 py-4 flex items-start justify-between gap-2 sticky top-0 z-10">
              <div>
                <div className="text-[10px] font-bold uppercase tracking-[2px] text-[var(--color-accent)]">Request a Quote</div>
                <h3 id="quote-title" className="font-[family-name:var(--font-display)] text-2xl uppercase leading-none mt-1">
                  Tell us your build.
                </h3>
              </div>
              <button
                type="button"
                onClick={() => setOpen(false)}
                className="text-white/60 hover:text-white text-2xl leading-none w-8 h-8 flex items-center justify-center"
                aria-label="Close"
              >
                ×
              </button>
            </div>

            <div className="px-5 py-4 space-y-4">
              <div>
                <label htmlFor="quote-name" className="block text-[10px] font-bold uppercase tracking-widest text-[var(--color-accent)] mb-1">Name *</label>
                <input
                  id="quote-name"
                  type="text"
                  value={form.name}
                  onChange={(e) => setForm((f) => ({ ...f, name: e.target.value }))}
                  className="w-full border border-[var(--color-border-soft)] rounded-md px-3 py-2 text-sm focus:outline-none focus:border-[var(--color-accent)] focus:ring-1 focus:ring-[var(--color-accent)]"
                  placeholder="Juan Dela Cruz"
                  required
                />
              </div>

              <div>
                <label htmlFor="quote-phone" className="block text-[10px] font-bold uppercase tracking-widest text-[var(--color-accent)] mb-1">Phone *</label>
                <input
                  id="quote-phone"
                  type="tel"
                  inputMode="tel"
                  value={form.phone}
                  onChange={(e) => setForm((f) => ({ ...f, phone: e.target.value }))}
                  className="w-full border border-[var(--color-border-soft)] rounded-md px-3 py-2 text-sm focus:outline-none focus:border-[var(--color-accent)] focus:ring-1 focus:ring-[var(--color-accent)]"
                  placeholder="0917-XXX-XXXX"
                  required
                />
              </div>

              <div>
                <label htmlFor="quote-vehicle" className="block text-[10px] font-bold uppercase tracking-widest text-[var(--color-accent)] mb-1">Vehicle</label>
                <select
                  id="quote-vehicle"
                  value={form.vehicle}
                  onChange={(e) => setForm((f) => ({ ...f, vehicle: e.target.value }))}
                  className="w-full border border-[var(--color-border-soft)] rounded-md px-3 py-2 text-sm bg-white focus:outline-none focus:border-[var(--color-accent)] focus:ring-1 focus:ring-[var(--color-accent)]"
                >
                  <option value="">Select your vehicle…</option>
                  {VEHICLE_OPTIONS.map((v) => (<option key={v} value={v}>{v}</option>))}
                </select>
              </div>

              <div>
                <label className="block text-[10px] font-bold uppercase tracking-widest text-[var(--color-accent)] mb-1.5">Interested in</label>
                <div className="flex flex-wrap gap-1.5">
                  {CATEGORIES.map((cat) => {
                    const active = form.interestedIn.includes(cat.name);
                    return (
                      <button
                        key={cat.slug}
                        type="button"
                        onClick={() => toggleCategory(cat.name)}
                        className={cn(
                          'text-[10px] font-bold uppercase tracking-wide px-2.5 py-1 rounded-full border transition-colors',
                          active
                            ? 'bg-[var(--color-accent)] text-white border-[var(--color-accent)]'
                            : 'bg-white text-[var(--color-ink)] border-[var(--color-border-soft)] hover:border-[var(--color-accent)]',
                        )}
                        aria-pressed={active}
                      >
                        {cat.name}
                      </button>
                    );
                  })}
                </div>
              </div>

              <div>
                <label htmlFor="quote-notes" className="block text-[10px] font-bold uppercase tracking-widest text-[var(--color-accent)] mb-1">Notes</label>
                <textarea
                  id="quote-notes"
                  value={form.notes}
                  onChange={(e) => setForm((f) => ({ ...f, notes: e.target.value }))}
                  className="w-full border border-[var(--color-border-soft)] rounded-md px-3 py-2 text-sm h-20 resize-none focus:outline-none focus:border-[var(--color-accent)] focus:ring-1 focus:ring-[var(--color-accent)]"
                  placeholder="e.g. <example note relevant to this business>"
                />
              </div>

              {!isValid && (form.name.length > 0 || form.phone.length > 0) && (
                <p className="text-[11px] text-[var(--color-accent)]">
                  Name and phone are required to send.
                </p>
              )}
            </div>

            <div className="bg-[var(--color-bg-alt)] px-5 py-4 border-t border-[var(--color-border-soft)] sticky bottom-0">
              <div className="text-[10px] font-bold uppercase tracking-widest text-[var(--color-ink-muted)] mb-2 text-center">Send via</div>
              <div className={cn('grid gap-2', SHOP.email ? 'grid-cols-2' : 'grid-cols-1')}>
                <button
                  type="button"
                  onClick={sendViaSMS}
                  disabled={!isValid}
                  className={cn(
                    'flex flex-col items-center justify-center gap-1 py-3 px-3 rounded-md border text-[10px] font-bold uppercase tracking-wide transition-all',
                    isValid
                      ? 'bg-[var(--color-accent)] border-[var(--color-accent)] text-white hover:bg-[var(--color-accent-deep)]'
                      : 'bg-gray-100 border-gray-200 text-gray-400 cursor-not-allowed',
                  )}
                >
                  <span className="text-lg" aria-hidden="true">📱</span>
                  Send via SMS
                </button>
                {SHOP.email && (
                  <button
                    type="button"
                    onClick={sendViaEmail}
                    disabled={!isValid}
                    className={cn(
                      'flex flex-col items-center justify-center gap-1 py-3 px-3 rounded-md border text-[10px] font-bold uppercase tracking-wide transition-all',
                      isValid
                        ? 'bg-white border-[var(--color-border-soft)] text-[var(--color-ink)] hover:border-[var(--color-accent)] hover:text-[var(--color-accent)]'
                        : 'bg-gray-100 border-gray-200 text-gray-400 cursor-not-allowed',
                    )}
                  >
                    <span className="text-lg" aria-hidden="true">📧</span>
                    Send via Email
                  </button>
                )}
              </div>
              <p className="text-[10px] text-[var(--color-ink-faint)] text-center mt-2">
                We&apos;ll respond same-day · Mon–Sat
              </p>
            </div>
          </div>
        </div>
      )}

      {toast && (
        <div className="fixed bottom-20 left-1/2 -translate-x-1/2 z-[110] bg-[var(--color-bg-dark)] text-white text-xs font-bold uppercase tracking-wide px-4 py-2 rounded-md shadow-xl">
          {toast}
        </div>
      )}
    </>
  );
}
```

## Gemini Pro prompt library — paste into Gemini, swap SUBJECT

These are the prompts Carnage shipped with. Use Google AI Studio → Imagen 3 → 21:9 for hero/banner, 4:3 for cards. Cost: ~₱0/image on free tier.

### Prompt 1 — Hero (golden hour)

```
Cinematic photograph of a SUBJECT, parked outdoors at golden hour on a rural Philippine road, long shadows, dust kicking up behind the rear wheels, dramatic warm-orange backlight rim-lighting the silhouette, deep shadows on the chassis, sense of motion suspended just-stopped. Magazine cover quality, shot on a 35mm full-frame, f/2.8, low-angle hero composition. Aspect ratio 21:9, super wide, no text, no logo, no watermark, no people in frame, leave the lower-left third dark for headline overlay.

SUBJECT: lifted Ford Ranger Raptor 2024, matte black, ARB Summit MKII bull bar, 35-inch BFG KO3 mud-terrain tires, ARB rooftop tent, Stedi LED light bar across the front
```

### Prompt 2 — Hero (stormy)

```
Cinematic photograph of a SUBJECT, mid-storm on a wet PH provincial road, headlights cutting through rain, water spray off the front tires, cloud-grey sky, distant lightning flash, road surface glossy and reflective, mood-piece tension. Magazine action shot, 35mm full-frame, f/4, slight pan-blur on the wheels, hero front-three-quarter framing. Aspect ratio 21:9, super wide, no text, no logo, no watermark, no people in frame, leave the lower-left third dark for headline overlay.

SUBJECT: same lifted Ranger Raptor as Prompt 1, headlights ON
```

### Prompt 3 — Hero (shop night)

```
Cinematic photograph of a SUBJECT, parked inside a clean industrial autoshop bay at night, overhead LED work lights creating directional pools of light, polished concrete floor reflecting the chassis, tools and floor jacks blurred in the background, sense of "build just finished, ready to roll out". Magazine portrait, 35mm full-frame, f/2.8, side-three-quarter angle from a slightly low position. Aspect ratio 21:9, super wide, no text, no logo, no watermark, no people in frame, leave the lower-left third dark for headline overlay.

SUBJECT: same lifted Ranger Raptor, freshly washed
```

### Prompt 4 — Section banner: "9 categories in 1 garage"

```
Wide cinematic photograph of the interior of a Filipino offroad autoshop with N (e.g. 9) clearly distinguishable PRODUCT_CATEGORIES displayed across the bay — lift kits stacked on shelves, a row of chrome mags on the floor, mud-terrain tires lined up against the wall, a steel bull bar mounted on a workshop stand, a roll bar in a corner, a hard tonneau cover on a sawhorse, a body-conversion kit propped against pegboard, and 4×4 accessories (snorkel, light bar) on the workbench. Polished concrete floor, hanging LED workshop lights, one Ford Ranger mid-build on a 2-post lift in the deep background. Magazine quality, 35mm full-frame, f/4, eye-level wide composition. Aspect ratio 21:9, no text, no logo, no watermark, no people, gradient toward white at the top edge for a soft fade-to-page-bg.

PRODUCT_CATEGORIES: lift kits, suspension, steel bumpers, mags, tires, roll bars, bedcovers, facelift kits, 4×4 accessories
```

### Prompt 5 — Section banner: "Moving fast"

```
Cinematic action photograph of a lifted Ford Ranger Raptor mid-motion through a wet provincial Philippine road, water spray fanning from all four tires, motion-blur on the wheels, sense of acceleration, palm trees and concrete bahay-kubo blurred along the side, long exposure feel, dawn-grey sky. 35mm full-frame, f/4, 1/30s for slight rolling-shutter blur, panning shot side-three-quarter. Aspect ratio 21:9, no text, no logo, no watermark, no people, gradient toward the section background at the top edge.
```

### Prompt 6 — Category card template (paste 9 times, swap SUBJECT)

```
Studio-grade product photograph of SUBJECT, clean industrial concrete background, single overhead key light at 45°, soft fill from the front, slight rim-light from behind, no harsh shadows, hero product framing. Magazine catalog quality, 50mm prime, f/5.6, eye-level. Aspect ratio 4:3, no text, no logo, no watermark, no people, gradient toward black at the lower edge for caption overlay legibility.

SUBJECT: <see 9 SUBJECT lines below>
```

### Nine SUBJECT lines for Carnage (adapt to user's CATEGORIES)

| Slug | SUBJECT |
|---|---|
| `lift-kits` | a complete 2-inch suspension lift kit laid out on the floor — pair of front coilover shocks, pair of rear gas shocks, leaf-spring add-a-leaf, polyurethane bushings, mounting hardware, all matte-black finished |
| `suspension` | a single Fox Racing 2.0 IFP performance shock absorber, isolated, satin-black body with red Fox decal, mounting bushings visible, hero close-up |
| `steel-bumpers` | a heavy-duty ARB Summit MKII steel front bull bar in matte black, winch cradle visible, fog-light cutouts, ready-to-install with fitment brackets attached |
| `mags` | a set of four Fuel D697 Kicker 17-inch matte-black off-road mag wheels, stacked horizontally, tread-pattern lugs visible, light-spoke catching the rim-light |
| `tires` | a single BFGoodrich All-Terrain T/A KO3 mud-terrain tire, 33-inch, aggressive sidewall lugs, tread block close-up, isolated against concrete |
| `roll-bars` | a Panther sport roll bar in gloss black for a pickup truck bed, tubular steel, mounted on a workshop stand, brake-light mount visible at the top |
| `bedcovers` | a Roll-N-Lock M-series manual retractable bedcover, half-rolled-open showing the slat mechanism, satin-black, mounted on a workshop bench |
| `facelift-kits` | a Toyota Hilux GR Sport facelift conversion kit laid out — front grille, hood scoop, fender flares, LED projector headlights, all in matte black with red GR badging |
| `accessories-4x4` | a workshop-bench arrangement of off-road accessories — black ARB safari snorkel, 32-inch Stedi LED light bar, Front Runner Slimline II roof rack, Warn ZEON 10-S winch — laid out clean and product-shot |

For non-offroad businesses, rewrite SUBJECT lines to match the user's categories. The visual grammar (concrete background, 45° key, 4:3, gradient-bottom) is what makes the cards cohere.

## Facebook content extraction trick — pull real photos

Owners almost always have all their build photos on Facebook. Don't ask them to email zip files — extract directly from FB photo viewer URLs.

### Step 1 — get the photo URL

Owner shares: `https://www.facebook.com/photo/?fbid=1234567890&set=a.987...`

### Step 2 — fetch with mobile UA (FB serves the desktop viewer differently)

```bash
curl -sL -A "Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Mobile/15E148 Safari/604.1" \
  "https://m.facebook.com/photo/?fbid=1234567890" \
  | grep -oE 'https://scontent[^"]+\.(jpg|jpeg)' \
  | head -1 \
  | sed 's/&amp;/\&/g'
```

This prints a CDN URL. Pipe to `curl` to download:

```bash
URL=$(curl -sL -A "Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Mobile/15E148 Safari/604.1" "https://m.facebook.com/photo/?fbid=1234567890" | grep -oE 'https://scontent[^"]+\.(jpg|jpeg)' | head -1 | sed 's/&amp;/\&/g')
curl -o "public/gallery/<slug>/build-1.jpg" "$URL"
```

### Step 3 — captions

Captions are usually in the FB post text, not the photo. Ask the owner to paste both the URL and caption together: `<url> | <caption>`. Then construct the `GALLERY` array entries.

### Notes & gotchas

- FB rotates CDN tokens — re-fetch right before downloading. URLs older than ~24h often 403.
- Mobile UA (`m.facebook.com`) returns simpler HTML than desktop FB; the trick won't work without it.
- If `grep` returns empty, the post may be private or behind a login wall — owner has to make it public temporarily, or share via Messenger and screenshot.
- Image dimensions vary — feed everything through Next.js `<Image fill>` and trust the layout.
- This is **acceptable** because the photos are the owner's own posts, not third-party scraping. Always confirm with the owner before extracting.

## Playwright smoke tests — `tests/smoke.spec.ts`

Eleven scenarios covering: homepage sections, all product pages, 404, filter chips, gallery lightbox, quote button, SMS validity gate, chip toggle, modal close, mobile reachability, mobile hero overflow.

```ts
import { test, expect } from '@playwright/test';

test('homepage renders all sections (current motto)', async ({ page }) => {
  await page.goto('/');
  await expect(page.getByRole('heading', { name: /<motto-line-1-regex>/i }).first()).toBeVisible();
  await expect(page.getByText(/<motto-line-3-regex>/i)).toBeVisible();
  await expect(page.getByText(/<N> categories/i)).toBeVisible();
  await expect(page.getByText(/built\. not/i)).toBeVisible();
  await expect(page.getByText(/trusted brands/i)).toBeVisible();
  await expect(page.getByText(/hot picks/i)).toBeVisible();
  await expect(page.getByText(/how it works/i)).toBeVisible();
  await expect(page.getByText(/<gallery-h2-regex>/i)).toBeVisible();
  await expect(page.getByText(/<location-h2-regex>/i)).toBeVisible();
});

test('all product detail pages render', async ({ page }) => {
  const slugs = ['<slug-1>', '<slug-2>', '<slug-3>' /* ... */];
  for (const slug of slugs) {
    await page.goto(`/products/${slug}`);
    await expect(page.getByRole('heading', { level: 1 })).toBeVisible();
    await expect(page.getByText(/inquire to install/i)).toBeVisible();
  }
});

test('invalid product slug returns 404 page', async ({ page }) => {
  await page.goto('/products/does-not-exist');
  await expect(page.getByRole('heading', { name: /category not found/i })).toBeVisible();
});

test('filter chips narrow the catalog', async ({ page }) => {
  await page.goto('/products/<slug-1>');
  const allCount = await page.locator('a[href^="tel:"][aria-label^="Inquire"]').count();
  expect(allCount).toBeGreaterThan(0);
  await page.getByRole('button', { name: '<filter-1>', exact: true }).click();
  await expect(page.getByText(/<expected-product-after-filter>/)).toBeVisible();
});

test('gallery lightbox opens on click', async ({ page }) => {
  await page.goto('/');
  await page.locator('#gallery button').first().click();
  await expect(page.locator('.yarl__container')).toBeVisible();
});

test('request quote button is visible and opens modal', async ({ page }) => {
  await page.goto('/');
  const quoteBtn = page.getByRole('button', { name: /request a quote/i });
  await expect(quoteBtn).toBeVisible();
  await quoteBtn.click();
  await expect(page.getByRole('dialog')).toBeVisible();
  await expect(page.getByRole('heading', { name: /tell us your build/i })).toBeVisible();
});

test('quote SMS button is disabled until name + phone are filled', async ({ page }) => {
  await page.goto('/');
  await page.getByRole('button', { name: /request a quote/i }).click();

  const smsBtn = page.getByRole('button', { name: /send via sms/i });
  await expect(smsBtn).toBeDisabled();

  await page.getByLabel(/name/i).fill('Juan Cruz');
  await expect(smsBtn).toBeDisabled();

  await page.getByLabel(/^phone/i).fill('09171234567');
  await expect(smsBtn).toBeEnabled();
});

test('quote modal — picking categories toggles chip state', async ({ page }) => {
  await page.goto('/');
  await page.getByRole('button', { name: /request a quote/i }).click();

  const chip = page.getByRole('button', { name: '<Category Name 1>', exact: true });
  await expect(chip).toHaveAttribute('aria-pressed', 'false');
  await chip.click();
  await expect(chip).toHaveAttribute('aria-pressed', 'true');
  await chip.click();
  await expect(chip).toHaveAttribute('aria-pressed', 'false');
});

test('quote modal closes on backdrop click and Esc', async ({ page }) => {
  await page.goto('/');
  await page.getByRole('button', { name: /request a quote/i }).click();
  await expect(page.getByRole('dialog')).toBeVisible();
  await page.keyboard.press('Escape');
  await expect(page.getByRole('dialog')).not.toBeVisible();
});

test('mobile — quote button reachable above content', async ({ page, isMobile }) => {
  test.skip(!isMobile, 'desktop already exercises this elsewhere');
  await page.goto('/');
  await page.evaluate(() => window.scrollTo(0, document.body.scrollHeight));
  await expect(page.getByRole('button', { name: /request a quote/i })).toBeVisible();
});

test('mobile — hero motto fits without overflowing viewport', async ({ page, isMobile }) => {
  test.skip(!isMobile, 'mobile-only check');
  await page.goto('/');
  const hero = page.locator('#hero');
  const box = await hero.boundingBox();
  const viewport = page.viewportSize();
  expect(box).not.toBeNull();
  expect(viewport).not.toBeNull();
  if (box && viewport) {
    expect(box.width).toBeLessThanOrEqual(viewport.width + 1);
  }
});
```

`playwright.config.ts`:

```ts
import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  testDir: './tests',
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  reporter: 'list',
  use: {
    baseURL: 'http://localhost:3000',
    trace: 'on-first-retry',
  },
  webServer: {
    command: 'npm run dev',
    url: 'http://localhost:3000',
    reuseExistingServer: !process.env.CI,
    timeout: 120_000,
  },
  projects: [
    { name: 'desktop', use: { ...devices['Desktop Chrome'] } },
    { name: 'mobile', use: { ...devices['iPhone 13'] } },
  ],
});
```

## Vercel deploy flow

```bash
# Stage 1 — push to GitHub (skip if already pushed)
git remote add origin git@github.com:<user>/<slug>.git
git push -u origin main

# Stage 2 — Vercel
# Web flow (fastest):
#   1. https://vercel.com/new
#   2. Import the repo (must be public or grant Vercel GitHub OAuth on private)
#   3. Framework auto-detects Next.js — accept defaults
#   4. Click Deploy. ~90 seconds to live URL.
#
# CLI flow:
npm i -g vercel
vercel deploy            # preview
vercel deploy --prod     # production
```

**Common 404 confusion:** when the repo is private and Vercel hasn't been granted GitHub OAuth, you'll see "Repository not found" in the Vercel import flow. Two fixes:
1. **Make the repo public** (fastest — fine for portfolio sites with no secrets).
2. **Grant Vercel GitHub OAuth** on the org/user.

After live, set:
- Custom domain (Vercel → Project → Settings → Domains)
- Production branch = `main`
- Update `metadataBase` in `app/layout.tsx` to the real domain

## Post-launch polish checklist

After the first deploy goes live, walk the owner through these:

- [ ] Generate Gemini hero rotation images (3 variants — Prompts 1/2/3)
- [ ] Generate Gemini section banners (Prompts 4 + 5)
- [ ] Generate Gemini category card images (Prompt 6 × N categories)
- [ ] Replace `public/products/placeholder.svg` with 1 real product photo per top SKU (ask owner for catalog photos)
- [ ] Pull 8–12 real photos from FB album using the mobile-UA trick
- [ ] Update `data/shop.ts` with REAL phone, hours, address (often hidden in FB post captions — search the FB page for "address", "directions", or "Waze")
- [ ] Add 3 real customer testimonials OR keep the FB feed embed (which gives social proof free)
- [ ] Run `/agent-gian-mockup` to generate device-framed pitch images for the FB outreach DM (if available; skip otherwise — mockup polish is optional)
- [ ] Push to GitHub + Vercel auto-deploys

## FB outreach message template — Taglish (paste-ready)

The cold-DM that worked for Carnage. Replace placeholders.

```
Hi {Sir/Madam} {Name}!

Sumusubaybay po ako sa Page nyo for a while ngayon — yung mga builds nyo,
yung quality ng work, talagang masinop. {past-customer-context — e.g. "Last
time po pumunta ako sa shop nyo last 2024 para sa 2-inch lift, sobrang
bilis at clean ng install."}

Web developer po ako and yung sa work nyo, kulang lang po sya ng isang
proper website para mas madali ma-discover ng mga customer outside FB —
lalo na yung mga nag-Google "{search-term — e.g. lift kits Marikina}".

May ginawa po ako na sample mock-up para sa Page nyo.
Tingnan nyo po: {URL}

May filter pa po ng mga SKU per vehicle, may inquiry form na direct sa
SMS, may Maps embed, at automated naman po na lumalabas ang FB updates
nyo dito sa site.

Pricing po: PHP {amount} one-time — kasama:
- Buong code + pagdedeploy
- Source handover (sayo na po lahat)
- 1–2 revision rounds
- Sitemap setup para sa Google

Flexible po ang payment terms — cash, installment, or service-trade
(barter for {service — e.g. "isang pampagandang 2-inch lift sa truck ko"}).

Pwede po ba i-PM kung interesado kayo? Salamat sa oras nyo!

— {Your Name}
```

**Tone notes:** Taglish is mandatory for SMB outreach in PH. Pure English reads as agency / corporate / expensive. Include past-customer context if you have it — establishes you're not a cold scammer. Always lead with the URL above the price.

## Pricing guidance

For the **user's reference, not the site**:

| Tier | Price (PHP) | When to use |
|---|---|---|
| Floor / portfolio | 20,000 | First 1–2 clients to build the portfolio |
| Standard | 25,000 | Default rate for Filipino SMB pitch sites |
| Premium | 35,000–45,000 | E-commerce, custom integrations, multi-page, multi-lingual |

**Inclusions** (be explicit in the proposal):
- Full Next.js source code
- Vercel deployment + 1 free domain setup
- Source handover (GitHub transfer or zip)
- 1–2 revision rounds within 14 days of go-live
- Sitemap + robots.txt setup
- 5 Gemini-generated assets (3 hero + 2 banner) included; extras at +PHP 500 each

**Exclusions** (flag upfront):
- Domain registration cost (~PHP 600–1200/year, owner pays)
- Custom email setup (Gmail Workspace ~PHP 250/user/month)
- Ongoing content updates (offer PHP 1500/month retainer)
- Professional photography (refer to a friend or use Gemini)
- Paid ads / SEO campaigns (separate scope)

**Service-trade flexibility:** in PH SMB world, owners often prefer barter — a free oil change, a salon service, free dental cleaning, monthly coffee credit. Quote that as the equivalent peso value to keep your hours billable in your head.

## Cross-reference — `/agent-gian-mockup`

After the site is deployed, run `/agent-gian-mockup` to generate device-framed (iPhone + MacBook) pitch screenshots for the FB outreach DM and your portfolio. If `/agent-gian-mockup` isn't installed yet, skip — the deploy URL itself is enough proof. Mockup polish is optional.

## Worked example — "Bayan Coffee Roasters" (Quezon City)

A concrete substitution to follow when the user is vague:

- **Q1** Bayan Coffee Roasters · Quezon City
- **Q2** Premium Build (Playfair Display + ivory + brass)
- **Q3** Override defaults — `--color-bg-base: #f8f5ee` ivory, `--color-bg-dark: #1a1612` warm-black, `--color-accent: #b8893d` brass, `--color-accent-deep: #8a6428`
- **Q4** Motto: `BREW IT. / SLOW. / LIKE THE OLD COUNTRY.` (last line in brass)
- **Q5** Tagline: "Specialty single-origin Philippine beans, slow-roasted in Quezon City."
- **Q6** 5 categories: `single-origin · Single-Origin Beans`, `blends · House Blends`, `pourover · Pour-over Gear`, `merch · Roastery Merch`, `subscriptions · Bean Subscriptions`
- **Q7** Pillars: "Direct from PH farms" · "Roasted-to-order weekly" · "Brewing-class included"
- **Q8** Brand strip: Mt. Apo · Kalsada · Sagada · Benguet · Bukidnon · Sulu Cordillera
- **Q9** Process: Order · Roast · Brew · Sip
- **Q11** Filters: All · Light · Medium · Dark · Espresso · Other
- **Q12** Free consultation = yes (cupping session). Installments = no. Best-seller badges = yes.
- **Q13** Quote modal stays. SMS primary. Email button on (owner has business@bayan.coffee).

**Rename** `Why<Carnage>` → `WhyBayan`. Rewrite Process icons (mug / bag / pour-over / cup). Rewrite Gemini SUBJECT lines (a single bag of single-origin beans on burlap; an espresso pull mid-extraction; a hand-pour Hario V60; etc.).

Everything else — file tree, motion grammar, Reveal animation, Quote modal, FB feed, Playwright tests, deploy flow — stays identical.

## Conventions enshrined by this skill

These join the Agent Gian methodology when this skill ships:

- **Always 5–9 categories.** Fewer feels thin; more breaks the homepage rhythm.
- **Always include the Demo Ribbon** on pitch deliverables. Removed only post-purchase by the owner's request.
- **All user-facing copy lives in `data/copy.ts`.** Components reference `COPY.*` only. Owner edits one file.
- **All shop/contact info lives in `data/shop.ts`.** Single source of truth + `formatAddress()` helper.
- **Quote modal sends via SMS first, Email second, Messenger never** (it failed for Carnage and the FB platform JS bridge is unreliable in the wild).
- **Reveal animations are bidirectional** — re-trigger on every viewport entry. One-shot reveals feel broken when the user scrolls back up.
- **Hero is always 3 images on a 7s rotation** with parallax + Ken Burns. Owners give you 1 photo; you generate 2 more in Gemini.
- **Run `npx tsc --noEmit` after every edit.** Commit only when type-clean. Atomic commits per Agent Gian §V.
- **Push to GitHub with a public-by-default repo** unless the owner has secrets to protect. Solves the Vercel 404 confusion before it happens.

## Not this skill

For:
- Code review of an existing pitch site → `/agent-gian-review`
- QA-test the deployed site for empty states / dead ends → `/agent-gian-qa`
- Bug in the deployed site → `/agent-gian-diagnose-first`
- Atomic commit gate before each step → `/agent-gian-commit`
- End-of-day handoff → `/agent-gian-pause`
- Resume tomorrow → `/agent-gian-resume`
- Device-framed mockups for the outreach DM → `/agent-gian-mockup` (when shipped)
