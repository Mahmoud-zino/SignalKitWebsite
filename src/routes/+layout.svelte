<script lang="ts">
	import './layout.css';
	import {
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
	import MobileNav from '$lib/components/MobileNav.svelte';
	import PageHeader from '$lib/components/PageHeader.svelte';
	import TableOfContents from '$lib/components/TableOfContents.svelte';
	import PrevNextNav from '$lib/components/PrevNextNav.svelte';
	import { hasTocContent } from '$lib/stores/toc';

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

<MobileNav
	{navGroups}
	{drawerOpen}
	onDrawerOpenChange={(open) => (drawerOpen = open)}
	onCloseDrawer={closeDrawer}
/>

<div
	class="grid grid-cols-1 md:grid-cols-[280px_1fr] {$hasTocContent
		? 'lg:grid-cols-[280px_1fr_360px]'
		: 'lg:grid-cols-[280px_1fr]'}"
>
	<Sidebar {navGroups} />

	<main class="min-h-[calc(100vh-16rem)] bg-surface-100-900">
		<div class="mx-auto max-w-4xl p-6">
			<PageHeader />
			{@render children()}
			<PrevNextNav {navGroups} />
		</div>
	</main>
	<aside
		class="hidden border-l border-surface-500/30 p-6 lg:block"
		class:lg:hidden={!$hasTocContent}
	>
		<TableOfContents />
	</aside>
</div>

<Footer />
