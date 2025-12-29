<script lang="ts">
	import { codeToHtml } from 'shiki';

	interface Props {
		code: string;
		lang?: string;
	}

	let { code, lang = 'csharp' }: Props = $props();

	let highlightedHtml = $state('');

	$effect(() => {
		const highlight = async () => {
			highlightedHtml = await codeToHtml(code, {
				lang,
				theme: 'github-dark',
				transformers: [
					{
						line(node) {
							node.properties['data-line'] = '';
						},
						code(node) {
							node.properties.class = 'line-numbers';
						}
					}
				]
			});
		};
		highlight();
	});
</script>

{#if highlightedHtml}
	<div class="code-container">
		<!-- eslint-disable-next-line svelte/no-at-html-tags -->
		{@html highlightedHtml}
	</div>
{:else}
	<div class="overflow-x-auto">
		<pre class="rounded-lg bg-surface-900 p-6"><code class="text-xs text-surface-50">{code}</code
			></pre>
	</div>
{/if}

<style>
	:global(.code-container) {
		border-radius: 0.5rem;
		overflow-x: auto;
		background-color: #0d1117;
	}

	:global(.code-container pre) {
		font-size: 0.75rem;
		padding: 1.5rem;
		margin: 0;
		width: max-content;
		min-width: 100%;
	}

	:global(.code-container code.line-numbers) {
		counter-reset: line;
		display: block;
	}

	:global(.code-container code.line-numbers > [data-line]::before) {
		counter-increment: line;
		content: counter(line);
		display: inline-block;
		width: 2rem;
		margin-right: 1.5rem;
		text-align: right;
		color: #6b7280;
		user-select: none;
	}
</style>
