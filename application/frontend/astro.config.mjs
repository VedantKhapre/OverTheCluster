// @ts-check
import { defineConfig, fontProviders } from 'astro/config';
import react from '@astrojs/react';
import tailwindcss from '@tailwindcss/vite';

import clerk from '@clerk/astro';
import { dark } from '@clerk/themes';
import node from "@astrojs/node";

// https://astro.build/config
export default defineConfig({
  fonts: [
    {
       provider: fontProviders.fontsource(),
       name: "Instrument Sans",
       cssVariable: "--font-instrument-sans",
       weights: [400, 500, 600, 700],
     },
     {
       provider: fontProviders.fontsource(),
       name: "Instrument Serif",
       cssVariable: "--font-instrument-serif",
       weights: [400],
       styles: ["normal", "italic"],
     },
   ],
  
  integrations: [react(),
    clerk({
      afterSignOutUrl: "/",
      signInForceRedirectUrl: "/ctf",
      signUpForceRedirectUrl: "/ctf",
      appearance: {
        theme: dark,
        variables: {
          colorPrimary: "#3b82f6",
          colorBackground: "#111111",
          colorInput: "#0b0b0b",
          borderRadius: "0.5rem",
          fontFamily: "inherit",
        },
        elements: {
          cardBox: { border: "1px solid #222222", boxShadow: "none" },
          headerTitle: { fontFamily: "Instrument Serif", fontStyle: "italic", fontWeight: 400 },
          userButtonAvatarBox: { width: "2.25rem", height: "2.25rem" },
          formButtonPrimary: {
            background: "rgba(255,255,255,0.9)",
            color: "#000",
            borderRadius: "9999px",
            "&:hover": { background: "#3b82f6", color: "#fff" },
          },
        },
      },
    }),
  ],
  
  adapter: node({ mode: "standalone" }),
  output: "server",

  vite: {
    plugins: [tailwindcss()]
  }
});