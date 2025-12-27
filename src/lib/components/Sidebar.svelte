<script lang="ts">
	import { Navigation } from '@skeletonlabs/skeleton-svelte';
	import type { ComponentType } from 'svelte';

	interface NavLink {
		label: string;
		href: string;
		icon: ComponentType;
	}

	interface Props {
		navGroups: Record<string, NavLink[]>;
	}

	let { navGroups }: Props = $props();
</script>

<aside class="sticky top-16 hidden h-[calc(100vh-4rem)] md:block">
	<Navigation layout="sidebar" class="h-full border-r border-surface-500/30 bg-surface-50-950">
		<Navigation.Content class="overflow-y-auto p-2">
			{#each Object.entries(navGroups) as [groupName, links]}
				<Navigation.Group>
					<Navigation.Label class="mb-2 px-2 text-xs font-semibold text-primary-600-400 uppercase">
						{groupName}
					</Navigation.Label>
					<Navigation.Menu class="space-y-1">
						{#each links as link}
							{@const Icon = link.icon}
							<Navigation.TriggerAnchor
								href={link.href}
								class="flex items-center gap-3 rounded px-3 py-2.5 hover:bg-surface-200-800"
							>
								<Icon class="size-5" />
								<Navigation.TriggerText>{link.label}</Navigation.TriggerText>
							</Navigation.TriggerAnchor>
						{/each}
					</Navigation.Menu>
				</Navigation.Group>
			{/each}
		</Navigation.Content>
	</Navigation>
</aside>
