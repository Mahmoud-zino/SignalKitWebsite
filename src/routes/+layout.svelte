<script lang="ts">
	import './layout.css';
	import { Navigation, Dialog, Portal } from '@skeletonlabs/skeleton-svelte';
	import {
		X,
		BookOpen,
		Zap,
		Radio,
		Ear,
		Activity,
		Wrench,
		Code,
		Puzzle,
		FlaskConical,
		FileCode,
		History
	} from 'lucide-svelte';
	import Header from '$lib/components/Header.svelte';
	import Sidebar from '$lib/components/Sidebar.svelte';
	import Footer from '$lib/components/Footer.svelte';

	let { children } = $props();

	let drawerOpen = $state(false);

	function toggleDrawer() {
		drawerOpen = !drawerOpen;
	}

	function closeDrawer() {
		drawerOpen = false;
	}

	const navGroups = {
		'Getting Started': [
			{ label: 'Installation', href: '/docs/getting-started', icon: BookOpen },
			{ label: 'Quick Start', href: '/docs/quick-start', icon: Zap }
		],
		'Core Concepts': [
			{ label: 'Overview', href: '/docs/core-concepts', icon: BookOpen },
			{ label: 'Channels', href: '/docs/channels', icon: Radio },
			{ label: 'Listeners', href: '/docs/listeners', icon: Ear },
			{ label: 'Events', href: '/docs/events', icon: Activity }
		],
		Advanced: [
			{ label: 'Features', href: '/docs/features', icon: Activity },
			{ label: 'Editor Tools', href: '/docs/editor-tools', icon: Wrench },
			{ label: 'Code Generation', href: '/docs/code-generation', icon: Code },
			{ label: 'Integrations', href: '/docs/integrations', icon: Puzzle }
		],
		Examples: [
			{ label: 'Basic Examples', href: '/examples/basic', icon: FlaskConical },
			{ label: 'Inventory System', href: '/examples/inventory', icon: FlaskConical },
			{ label: 'UI Events', href: '/examples/ui', icon: FlaskConical }
		],
		Reference: [
			{ label: 'API Reference', href: '/docs/api-reference', icon: FileCode },
			{ label: 'Changelog', href: '/changelog', icon: History }
		]
	};
</script>

<svelte:head>
	<link rel="icon" href="/favicon.svg" type="image/svg+xml" />
</svelte:head>

<Header onToggleDrawer={toggleDrawer} />

<div class="grid grid-cols-1 md:grid-cols-[280px_1fr]">
	<Sidebar {navGroups} />

	<Portal>
		<Dialog open={drawerOpen} onOpenChange={(e) => (drawerOpen = e.open)}>
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
								<Navigation.Label
									class="mb-2 px-2 text-xs font-semibold text-secondary-500 uppercase"
								>
									{groupName}
								</Navigation.Label>
								<Navigation.Menu class="space-y-1">
									{#each links as link}
										{@const Icon = link.icon}
										<Navigation.TriggerAnchor
											href={link.href}
											class="flex items-center gap-3 rounded px-3 py-2.5 hover:bg-surface-200-800"
											onclick={closeDrawer}
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

	<main class="min-h-[calc(100vh-16rem)] bg-surface-100-900">
		<div class="mx-auto max-w-4xl p-6">
			{@render children()}
		</div>
	</main>
</div>

<Footer />
