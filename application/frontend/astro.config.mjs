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
      appearance: {
        theme: dark,
        variables: {
          colorPrimary: '#9234d3',
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