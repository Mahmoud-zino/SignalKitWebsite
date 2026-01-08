<script lang="ts">
	import './layout.css';
	import { BookOpen, Zap, Radio, ToggleLeft, Hash, Percent, MessageSquare, Move, Grid3x3, Box, Palette, Cpu } from 'lucide-svelte';
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
		'Signal Channels': [
			{ label: 'Channels Overview', href: '/docs/channels', icon: Radio },
			{ label: 'Void Signal', href: '/docs/channels/void', icon: Radio },
			{ label: 'Bool Signal', href: '/docs/channels/bool', icon: ToggleLeft },
			{ label: 'Int Signal', href: '/docs/channels/int', icon: Hash },
			{ label: 'Float Signal', href: '/docs/channels/float', icon: Percent },
			{ label: 'Double Signal', href: '/docs/channels/double', icon: Percent },
			{ label: 'String Signal', href: '/docs/channels/string', icon: MessageSquare },
			{ label: 'Vector2 Signal', href: '/docs/channels/vector2', icon: Move },
			{ label: 'Vector2Int Signal', href: '/docs/channels/vector2int', icon: Grid3x3 },
			{ label: 'Vector3 Signal', href: '/docs/channels/vector3', icon: Box },
			{ label: 'Vector3Int Signal', href: '/docs/channels/vector3int', icon: Box },
			{ label: 'Quaternion Signal', href: '/docs/channels/quaternion', icon: Radio },
			{ label: 'Color Signal', href: '/docs/channels/color', icon: Palette },
			{ label: 'GameObject Signal', href: '/docs/channels/gameobject', icon: Box },
			{ label: 'Transform Signal', href: '/docs/channels/transform', icon: Move },
			{ label: 'Custom Channels', href: '/docs/channels/custom', icon: Cpu }
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
