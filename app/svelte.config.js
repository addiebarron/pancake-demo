/** @type {import('@sveltejs/kit').Config} */

import node from "@sveltejs/adapter-node";

const config = {
  kit: {
    adapter: node(),
    target: "body",
    // only use SSR - no client-side routing!
    router: false,
  },
};

export default config;
