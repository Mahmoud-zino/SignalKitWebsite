<script lang="ts">
	import CodeBlock from '$lib/components/CodeBlock.svelte';
	import type { Snippet } from 'svelte';

	interface Props {
		children: Snippet;
	}

	let { children }: Props = $props();
</script>

<CodeBlock />

<article
	class="prose max-w-none dark:prose-invert prose-code:before:content-none prose-code:after:content-none [&_:not(pre)>code]:code"
>
	{@render children()}
</article>
