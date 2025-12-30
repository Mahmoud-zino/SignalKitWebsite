<script lang="ts">
	import { resolve } from '$app/paths';
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
		ArrowRight
	} from 'lucide-svelte';

	interface DocCard {
		title: string;
		description: string;
		href: string;
		icon: typeof BookOpen;
	}

	interface DocSection {
		sectionTitle: string;
		cards: DocCard[];
	}

	const docSections: DocSection[] = [
		{
			sectionTitle: 'Getting Started',
			cards: [
				{
					title: 'Installation',
					description:
						'Learn how to install SignalKit in your Unity project via Asset Store, Package Manager, or manual installation.',
					href: '/docs/getting-started',
					icon: BookOpen
				},
				{
					title: 'Basic Concepts',
					description:
						'Understand the three building blocks of SignalKit: Channels, Listeners, and Signals.',
					href: '/docs/basics',
					icon: BookOpen
				},
				{
					title: 'Quick Start',
					description:
						'Get up and running in minutes. Create your first signal channel, raise events, and listen to them.',
					href: '/docs/quick-start',
					icon: Zap
				},
				{
					title: 'Cheat Sheet',
					description:
						'Quick reference guide for common SignalKit patterns, syntax, and best practices.',
					href: '/docs/cheat-sheet',
					icon: FileCode
				},
				{
					title: 'Troubleshooting',
					description:
						'Common issues and their solutions - installation, setup, runtime errors, and editor tools.',
					href: '/docs/troubleshooting',
					icon: Wrench
				}
			]
		},
		{
			sectionTitle: 'Core Concepts',
			cards: [
				{
					title: 'Overview',
					description:
						"Understand the architecture and fundamental concepts behind SignalKit's event system.",
					href: '/docs/core-concepts',
					icon: BookOpen
				},
				{
					title: 'Channels',
					description:
						'Discover how signal channels work, the built-in types available, and how to create custom channels.',
					href: '/docs/channels',
					icon: Radio
				},
				{
					title: 'Listeners',
					description:
						'Learn how to subscribe to signals via code or Inspector, and understand the listener lifecycle.',
					href: '/docs/listeners',
					icon: Ear
				},
				{
					title: 'Events',
					description:
						'Explore how events flow through the system, from raising signals to listener invocation.',
					href: '/docs/events',
					icon: Activity
				}
			]
		},
		{
			sectionTitle: 'Advanced',
			cards: [
				{
					title: 'Features',
					description:
						'Master advanced features like priority systems, filters, one-shot listeners, and async support.',
					href: '/docs/features',
					icon: Activity
				},
				{
					title: 'Editor Tools',
					description:
						'Explore powerful Unity Editor tools including the visual debugger, Inspector features, and event replay.',
					href: '/docs/editor-tools',
					icon: Wrench
				},
				{
					title: 'Code Generation',
					description:
						'Use the [GenerateSignal] attribute and wizard to automatically generate custom signal types.',
					href: '/docs/code-generation',
					icon: Code
				},
				{
					title: 'Integrations',
					description:
						'Integrate SignalKit with Unity systems like UI Toolkit, Input System, Timeline, and more.',
					href: '/docs/integrations',
					icon: Puzzle
				}
			]
		},
		{
			sectionTitle: 'Examples',
			cards: [
				{
					title: 'Basic Examples',
					description: 'See simple examples demonstrating core SignalKit features in action.',
					href: '/examples/basic',
					icon: FlaskConical
				},
				{
					title: 'Inventory System',
					description: 'Learn how to build a decoupled inventory system using SignalKit.',
					href: '/examples/inventory',
					icon: FlaskConical
				},
				{
					title: 'UI Events',
					description:
						'Discover patterns for handling UI events without tight coupling to game logic.',
					href: '/examples/ui',
					icon: FlaskConical
				}
			]
		},
		{
			sectionTitle: 'Reference',
			cards: [
				{
					title: 'API Reference',
					description:
						'Complete API documentation for all SignalKit classes, methods, and attributes.',
					href: '/docs/api-reference',
					icon: FileCode
				}
			]
		}
	];
</script>

<svelte:head>
	<title>Documentation - SignalKit</title>
	<meta
		name="description"
		content="Comprehensive documentation for SignalKit - Unity's modern event system built on ScriptableObjects."
	/>
</svelte:head>

<article class="max-w-none">
	<h1 class="mb-6 text-3xl font-bold md:text-4xl lg:text-5xl">Documentation</h1>
	<p class="mb-12 text-lg text-surface-400">
		Welcome to the SignalKit documentation. Whether you're just getting started or looking to master
		advanced features, you'll find everything you need here.
	</p>

	{#each docSections as section (section.sectionTitle)}
		<section class="mt-12">
			<h2 class="mb-6 text-2xl font-bold md:text-3xl">{section.sectionTitle}</h2>
			<div class="grid gap-6 md:grid-cols-2">
				{#each section.cards as card (card.href)}
					{@const Icon = card.icon}
					<!-- eslint-disable svelte/no-navigation-without-resolve -->
					<a
						href={card.href}
						class="group block rounded-xl border border-surface-500/30 bg-surface-50-950 p-6 transition-all hover:border-primary-500/50 hover:shadow-lg"
					>
						<div class="mb-4 flex items-center justify-between gap-4">
							<div class="flex items-center gap-3">
								<div
									class="flex size-12 items-center justify-center rounded-lg bg-primary-500/10 transition-colors group-hover:bg-primary-500/20"
								>
									<Icon class="size-6 text-primary-500" />
								</div>
								<h3 class="text-xl font-semibold">{card.title}</h3>
							</div>
							<ArrowRight
								class="size-5 text-surface-400 transition-transform group-hover:translate-x-1 group-hover:text-primary-500"
							/>
						</div>
						<p class="text-sm leading-relaxed text-surface-400">
							{card.description}
						</p>
					</a>
				{/each}
			</div>
		</section>
	{/each}

	<section class="mt-16 rounded-2xl border border-tertiary-500/30 bg-tertiary-500/5 p-8">
		<h2 class="mb-3 text-2xl font-bold md:text-3xl">Example Assets</h2>
		<p class="mb-4 text-surface-400">
			All example scenes in SignalKit use beautiful 3D assets generously provided by
			<a
				href="https://kenney.nl/"
				target="_blank"
				rel="noopener noreferrer"
				class="anchor font-semibold"
			>
				Kenney
			</a>
			under the CC0 license. Kenney is a hard-working developer who creates thousands of free,
			high-quality game assets for the community. While attribution isn't required, we're happy to
			give credit where it's due. If you're looking for game assets, check out his incredible
			collection at
			<a
				href="https://kenney.nl/"
				target="_blank"
				rel="noopener noreferrer"
				class="anchor font-semibold"
			>
				kenney.nl
			</a>.
		</p>
	</section>

	<section class="mt-12 rounded-2xl border border-primary-500/30 bg-primary-500/5 p-8">
		<h2 class="mb-3 text-2xl font-bold md:text-3xl">Need Help?</h2>
		<p class="mb-4 text-surface-400">
			Can't find what you're looking for? Have questions or feedback? We're here to help.
		</p>
		<div class="flex flex-wrap gap-4">
			<a href={resolve('/docs/getting-started')} class="btn preset-filled-primary-500 px-6 py-3">
				Get Started
			</a>
			<a
				href="https://github.com/Mahmoud-zino/SignalKitWebsite/issues"
				target="_blank"
				rel="noopener noreferrer"
				class="btn preset-tonal px-6 py-3"
			>
				Report an Issue
			</a>
		</div>
	</section>
</article>
