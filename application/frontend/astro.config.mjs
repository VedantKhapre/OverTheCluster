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
      name: "Inter",
      cssVariable: "--font-inter",
      weights: [400, 500, 600, 700],
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