/** @type {import('@sveltejs/kit').Config} */

import node from "@sveltejs/adapter-node";

const config = {
  kit: {
    adapter: node(),
    // hydrate the <div id="svelte"> element in src/app.html
    target: "#svelte",
    // only use SSR - no client-side routing!
    ssr: true,
    router: false,
  },
};

export default config;
