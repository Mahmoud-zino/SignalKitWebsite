<script lang="ts">
	import { Navigation } from '@skeletonlabs/skeleton-svelte';
	import NavigationLinks from './NavigationLinks.svelte';
	import type { NavLink } from '$lib/types/navigation';

	interface Props {
		navGroups: Record<string, NavLink[]>;
	}

	let { navGroups }: Props = $props();
</script>

<aside class="sticky top-16 hidden h-[calc(100vh-4rem)] md:block">
	<Navigation layout="sidebar" class="h-full border-r border-surface-500/30 bg-surface-50-950">
		<Navigation.Content class="overflow-y-auto p-2">
			<NavigationLinks
				{navGroups}
				labelClass="mb-2 px-2 text-xs font-semibold text-primary-600-400 uppercase"
			/>
		</Navigation.Content>
	</Navigation>
</aside>
