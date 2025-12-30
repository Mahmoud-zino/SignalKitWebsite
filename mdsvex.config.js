import { defineMDSveXConfig } from 'mdsvex';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';
import { codeToHtml } from 'shiki';
import rehypeSlug from 'rehype-slug';
import { remarkCallouts } from './src/lib/remark-callouts.js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const config = defineMDSveXConfig({
	extensions: ['.svx', '.md'],
	smartypants: {
		dashes: 'oldschool'
	},

	highlight: {
		highlighter: async (code, lang) => {
			const html = await codeToHtml(code, {
				lang: lang || 'plaintext',
				theme: 'github-dark'
			});
			const escaped = html.replace(/`/g, '\\`').replace(/\$/g, '\\$');
			return `{@html \`${escaped}\` }`;
		}
	},

	remarkPlugins: [remarkCallouts],
	rehypePlugins: [rehypeSlug],

	layout: {
		_: join(__dirname, './src/lib/layouts/mdsvex.svelte')
	}
});

export default config;
