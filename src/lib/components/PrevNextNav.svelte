<script lang="ts">
	import { page } from '$app/state';
	import { ChevronLeft, ChevronRight } from 'lucide-svelte';
	import type { NavLink } from '$lib/types/navigation';
	import { getPageNavigation } from '$lib/utils/navigation';

	interface Props {
		navGroups: Record<string, NavLink[]>;
	}

	let { navGroups }: Props = $props();

	const navigation = $derived.by(() => {
		const currentPath = page.url.pathname;
		if (currentPath === '/') {
			return null;
		}
		return getPageNavigation(currentPath, navGroups);
	});
</script>

{#if navigation}
	<nav class="mt-12 border-t border-surface-500/30 pt-8">
		<div class="grid grid-cols-2 gap-4">
			<div>
				{#if navigation.previous}
					<!-- eslint-disable svelte/no-navigation-without-resolve -->
					<a
						href={navigation.previous.href}
						class="group flex items-center gap-2 rounded-lg border border-surface-500/30 bg-surface-50-950 p-4 transition-colors hover:border-primary-500 hover:bg-surface-200-800"
					>
						<ChevronLeft
							class="size-5 shrink-0 text-surface-600-400 group-hover:text-primary-500"
						/>
						<div class="min-w-0 flex-1">
							<div class="text-xs text-surface-600-400">Previous</div>
							<div class="truncate text-sm font-medium">{navigation.previous.label}</div>
						</div>
					</a>
					<!-- eslint-enable svelte/no-navigation-without-resolve -->
				{:else}
					<div
						class="flex items-center gap-2 rounded-lg border border-surface-500/30 bg-surface-100-900 p-4 opacity-40"
					>
						<ChevronLeft class="size-5 shrink-0 text-surface-600-400" />
						<div class="min-w-0 flex-1">
							<div class="text-xs text-surface-600-400">Previous</div>
							<div class="truncate text-sm font-medium text-surface-600-400">No previous page</div>
						</div>
					</div>
				{/if}
			</div>

			<div>
				{#if navigation.next}
					<!-- eslint-disable svelte/no-navigation-without-resolve -->
					<a
						href={navigation.next.href}
						class="group flex items-center gap-2 rounded-lg border border-surface-500/30 bg-surface-50-950 p-4 transition-colors hover:border-primary-500 hover:bg-surface-200-800"
					>
						<div class="min-w-0 flex-1 text-right">
							<div class="text-xs text-surface-600-400">Next</div>
							<div class="truncate text-sm font-medium">{navigation.next.label}</div>
						</div>
						<ChevronRight
							class="size-5 shrink-0 text-surface-600-400 group-hover:text-primary-500"
						/>
					</a>
					<!-- eslint-enable svelte/no-navigation-without-resolve -->
				{:else}
					<div
						class="flex items-center gap-2 rounded-lg border border-surface-500/30 bg-surface-100-900 p-4 opacity-40"
					>
						<div class="min-w-0 flex-1 text-right">
							<div class="text-xs text-surface-600-400">Next</div>
							<div class="truncate text-sm font-medium text-surface-600-400">No next page</div>
						</div>
						<ChevronRight class="size-5 shrink-0 text-surface-600-400" />
					</div>
				{/if}
			</div>
		</div>
	</nav>
{/if}
