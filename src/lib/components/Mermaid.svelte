<script lang="ts">
	import { onMount } from 'svelte';
	import mermaid from 'mermaid';

	onMount(async () => {
		mermaid.initialize({
			startOnLoad: true,
			theme: 'dark',
			themeVariables: {
				primaryColor: '#1e1b4b',
				primaryTextColor: '#e0e7ff',
				primaryBorderColor: '#a78bfa',
				lineColor: '#6366f1',
				secondaryColor: '#78350f',
				secondaryTextColor: '#fef3c7',
				tertiaryColor: '#064e3b',
				tertiaryTextColor: '#d1fae5',
				noteBkgColor: '#1e1b4b',
				noteTextColor: '#e0e7ff',
				noteBorderColor: '#a78bfa',
				edgeLabelBackground: '#1e293b',
				clusterBkg: '#1e293b',
				clusterBorder: '#475569',
				defaultLinkColor: '#6366f1',
				titleColor: '#e0e7ff',
				nodeTextColor: '#e0e7ff'
			}
		});

		const mermaidBlocks = document.querySelectorAll('pre.language-mermaid code');

		for (const block of mermaidBlocks) {
			const code = block.textContent || '';
			const pre = block.parentElement;

			if (pre) {
				const div = document.createElement('div');
				div.className = 'mermaid';
				div.textContent = code;
				pre.replaceWith(div);
			}
		}

		await mermaid.run({
			querySelector: '.mermaid',
			suppressErrors: false
		});
	});
</script>
