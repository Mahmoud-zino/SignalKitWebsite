<script lang="ts">
	import type { NavLink } from '$lib/types/navigation';
	import { ChevronDown, ChevronRight } from 'lucide-svelte';

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

	// Track which groups are expanded (all expanded by default)
	let expandedGroups = $state<Record<string, boolean>>(
		Object.keys(navGroups).reduce((acc, key) => ({ ...acc, [key]: true }), {})
	);

	function toggleGroup(groupName: string) {
		expandedGroups[groupName] = !expandedGroups[groupName];
	}
</script>

{#each Object.entries(navGroups) as [groupName, links] (groupName)}
	<div class="mb-4">
		<button
			onclick={() => toggleGroup(groupName)}
			class="flex w-full items-center gap-2 rounded px-2 py-1 transition-colors hover:bg-surface-200-800 {labelClass}"
		>
			{#if expandedGroups[groupName]}
				<ChevronDown class="size-4" />
			{:else}
				<ChevronRight class="size-4" />
			{/if}
			<span>{groupName}</span>
		</button>
		{#if expandedGroups[groupName]}
			<nav class="mt-1 space-y-1">
				{#each links as link (link.href)}
					{@const Icon = link.icon}
					<a
						href={link.href}
						class="flex items-center gap-3 rounded px-3 py-2.5 transition-colors hover:bg-surface-200-800"
						onclick={onLinkClick}
					>
						<Icon class="size-5" />
						<span>{link.label}</span>
					</a>
				{/each}
			</nav>
		{/if}
	</div>
{/each}
