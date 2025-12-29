<script lang="ts">
	import { AppBar } from '@skeletonlabs/skeleton-svelte';
	import { Menu } from 'lucide-svelte';
	import { Logo } from '$lib';
	import { resolve } from '$app/paths';

	interface Props {
		onToggleDrawer: () => void;
	}

	let { onToggleDrawer }: Props = $props();
</script>

<AppBar class="sticky top-0 z-50 border-b border-surface-500/30 bg-surface-50-950">
	<AppBar.Toolbar class="grid-cols-[auto_1fr_auto]">
		<AppBar.Lead class="flex items-center gap-2">
			<button
				type="button"
				class="btn-icon hover:preset-tonal md:hidden"
				onclick={onToggleDrawer}
				aria-label="Toggle menu"
			>
				<Menu class="size-6" />
			</button>
			<a href={resolve('/')} class="flex items-center gap-2">
				<Logo class="h-10" />
				<span class="text-xl font-bold">SignalKit</span>
			</a>
		</AppBar.Lead>

		<AppBar.Headline></AppBar.Headline>
		<AppBar.Trail>
			<a href={resolve('/docs')} class="btn hidden hover:preset-tonal sm:inline-flex">Docs</a>
			<a href={resolve('/examples')} class="btn hidden hover:preset-tonal sm:inline-flex"
				>Examples</a
			>
		</AppBar.Trail>
	</AppBar.Toolbar>
</AppBar>
