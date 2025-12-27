<script lang="ts">
	import { Navigation, Dialog, Portal } from '@skeletonlabs/skeleton-svelte';
	import { X } from 'lucide-svelte';
	import type { ComponentType } from 'svelte';

	interface NavLink {
		label: string;
		href: string;
		icon: ComponentType;
	}

	interface Props {
		navGroups: Record<string, NavLink[]>;
		drawerOpen: boolean;
		onDrawerOpenChange: (open: boolean) => void;
		onCloseDrawer: () => void;
	}

	let { navGroups, drawerOpen, onDrawerOpenChange, onCloseDrawer }: Props = $props();
</script>

<Portal>
	<Dialog open={drawerOpen} onOpenChange={(e) => onDrawerOpenChange(e.open)}>
		<Dialog.Backdrop class="fixed inset-0 bg-black/50" />
		<Dialog.Content
			class="data-[state=closed]:slide-out-to-left data-[state=open]:slide-in-from-left fixed top-0 left-0 h-full w-72 bg-surface-50-950 shadow-xl"
		>
			<Navigation layout="sidebar" class="grid h-full grid-rows-[auto_1fr]">
				<Navigation.Header
					class="flex items-center justify-end border-b border-surface-500/30 p-4"
				>
					<Dialog.CloseTrigger class="btn-icon hover:preset-tonal" aria-label="Close menu">
						<X class="size-6" />
					</Dialog.CloseTrigger>
				</Navigation.Header>

				<Navigation.Content class="overflow-y-auto p-2">
					{#each Object.entries(navGroups) as [groupName, links]}
						<Navigation.Group>
							<Navigation.Label class="mb-2 px-2 text-xs font-semibold text-secondary-500 uppercase">
								{groupName}
							</Navigation.Label>
							<Navigation.Menu class="space-y-1">
								{#each links as link}
									{@const Icon = link.icon}
									<Navigation.TriggerAnchor
										href={link.href}
										class="flex items-center gap-3 rounded px-3 py-2.5 hover:bg-surface-200-800"
										onclick={onCloseDrawer}
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
		</Dialog.Content>
	</Dialog>
</Portal>
