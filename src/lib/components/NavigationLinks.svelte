<script lang="ts">
	import { Navigation } from '@skeletonlabs/skeleton-svelte';
	import type { NavLink } from '$lib/types/navigation';

	interface Props {
		navGroups: Record<string, NavLink[]>;
		labelClass?: string;
		onLinkClick?: () => void;
	}

	let {
		navGroups,
		labelClass = 'mb-2 px-2 text-xs font-semibold uppercase',
		onLinkClick
	}: Props = $props();
</script>

{#each Object.entries(navGroups) as [groupName, links] (groupName)}
	<Navigation.Group>
		<Navigation.Label class={labelClass}>
			{groupName}
		</Navigation.Label>
		<Navigation.Menu class="space-y-1">
			{#each links as link (link.href)}
				{@const Icon = link.icon}
				<Navigation.TriggerAnchor
					href={link.href}
					class="flex items-center gap-3 rounded px-3 py-2.5 hover:bg-surface-200-800"
					onclick={onLinkClick}
				>
					<Icon class="size-5" />
					<Navigation.TriggerText>{link.label}</Navigation.TriggerText>
				</Navigation.TriggerAnchor>
			{/each}
		</Navigation.Menu>
	</Navigation.Group>
{/each}
