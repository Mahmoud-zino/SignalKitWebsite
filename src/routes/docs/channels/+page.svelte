<script lang="ts">
	import { resolve } from '$app/paths';
	import {
		Radio,
		ToggleLeft,
		Hash,
		Percent,
		MessageSquare,
		Move,
		Grid3x3,
		Box,
		Palette,
		Cpu
	} from 'lucide-svelte';

	const primitiveChannels = [
		{
			name: 'Void Signal',
			type: 'void',
			icon: Radio,
			description: 'Events without data - perfect for simple triggers',
			useCases: 'Button clicks, game events, triggers',
			color: 'primary'
		},
		{
			name: 'Bool Signal',
			type: 'bool',
			icon: ToggleLeft,
			description: 'Boolean values for toggles and state changes',
			useCases: 'Toggles, switches, on/off states',
			color: 'secondary'
		},
		{
			name: 'Int Signal',
			type: 'int',
			icon: Hash,
			description: 'Integer values for counts and indices',
			useCases: 'Scores, counts, health, inventory amounts',
			color: 'tertiary'
		},
		{
			name: 'Float Signal',
			type: 'float',
			icon: Percent,
			description: 'Floating-point values for precision data',
			useCases: 'Progress bars, timers, percentages',
			color: 'success'
		},
		{
			name: 'Double Signal',
			type: 'double',
			icon: Percent,
			description: 'High-precision floating-point values',
			useCases: 'Scientific calculations, high-precision timers',
			color: 'warning'
		},
		{
			name: 'String Signal',
			type: 'string',
			icon: MessageSquare,
			description: 'Text data for messages and identifiers',
			useCases: 'Messages, names, IDs, localization keys',
			color: 'error'
		}
	];

	const mathChannels = [
		{
			name: 'Vector2 Signal',
			type: 'vector2',
			icon: Move,
			description: '2D position and direction data',
			useCases: '2D positions, joystick input, screen coordinates',
			color: 'primary'
		},
		{
			name: 'Vector2Int Signal',
			type: 'vector2int',
			icon: Grid3x3,
			description: '2D integer position data',
			useCases: 'Grid positions, tile coordinates',
			color: 'secondary'
		},
		{
			name: 'Vector3 Signal',
			type: 'vector3',
			icon: Box,
			description: '3D position and direction data',
			useCases: '3D positions, movement directions, spawn points',
			color: 'tertiary'
		},
		{
			name: 'Vector3Int Signal',
			type: 'vector3int',
			icon: Box,
			description: '3D integer position data',
			useCases: 'Voxel coordinates, 3D grid positions',
			color: 'success'
		},
		{
			name: 'Quaternion Signal',
			type: 'quaternion',
			icon: Radio,
			description: 'Rotation data for 3D transforms',
			useCases: 'Rotations, camera orientation, object facing',
			color: 'warning'
		},
		{
			name: 'Color Signal',
			type: 'color',
			icon: Palette,
			description: 'Color data for visual effects',
			useCases: 'Color changes, themes, lighting effects',
			color: 'error'
		}
	];

	const unityChannels = [
		{
			name: 'GameObject Signal',
			type: 'gameobject',
			icon: Box,
			description: 'GameObject references for object events',
			useCases: 'Object spawned/destroyed, selection, interaction',
			color: 'primary'
		},
		{
			name: 'Transform Signal',
			type: 'transform',
			icon: Move,
			description: 'Transform references for tracking objects',
			useCases: 'Object tracking, follow targets, parent changes',
			color: 'secondary'
		}
	];
</script>

<svelte:head>
	<title>Signal Channels - Complete Guide | SignalKit Documentation</title>
	<meta
		name="description"
		content="Explore all 15 SignalKit channel types. From simple void signals to complex Unity object channels, find the perfect type-safe channel for your game events."
	/>
</svelte:head>

<div class="mx-auto prose max-w-4xl px-6 py-12 prose-invert">
	<h1>Signal Channels</h1>

	<p class="lead">
		Signal channels are the backbone of SignalKit's event system. Each channel is a ScriptableObject
		that acts as a communication hub between different parts of your game - without requiring direct
		references.
	</p>

	<div class="not-prose my-8 rounded-xl border border-primary-500/30 bg-primary-500/5 p-6">
		<h3 class="mb-3 text-lg font-semibold text-primary-400">How Channels Work</h3>
		<ul class="space-y-2 text-sm text-surface-600-400">
			<li>
				✅ <strong>Type-Safe:</strong> Each channel carries a specific data type (int, bool, Vector3,
				etc.)
			</li>
			<li>
				✅ <strong>ScriptableObject-Based:</strong> Persistent assets that survive scene changes
			</li>
			<li>
				✅ <strong>Zero Coupling:</strong> Publishers and subscribers don't need references to each other
			</li>
			<li>✅ <strong>Inspector-Friendly:</strong> Drag and drop channels like any other asset</li>
			<li>
				✅ <strong>Reusable:</strong> One channel can be used across multiple scenes and systems
			</li>
		</ul>
	</div>

	<h2>Primitive Channels</h2>
	<p>Basic data types for common game events and state changes.</p>

	<div class="not-prose mb-12 grid gap-4 md:grid-cols-2">
		{#each primitiveChannels as channel}
			<a
				href={resolve(`/docs/channels/${channel.type}`)}
				class="group rounded-lg border border-surface-500/30 bg-surface-50-950 p-6 transition-all hover:border-primary-500/50 hover:shadow-lg"
			>
				<div class="mb-3 flex items-center gap-3">
					<div
						class="flex size-12 items-center justify-center rounded-lg bg-{channel.color}-500/10"
					>
						<svelte:component this={channel.icon} class="size-6 text-{channel.color}-500" />
					</div>
					<h3 class="text-lg font-semibold group-hover:text-primary-400">
						{channel.name}
					</h3>
				</div>
				<p class="mb-2 text-sm text-surface-600-400">{channel.description}</p>
				<p class="text-xs text-surface-700-300">
					<strong>Use Cases:</strong>
					{channel.useCases}
				</p>
			</a>
		{/each}
	</div>

	<h2>Math Type Channels</h2>
	<p>Unity math types for positions, rotations, and visual effects.</p>

	<div class="not-prose mb-12 grid gap-4 md:grid-cols-2">
		{#each mathChannels as channel}
			<a
				href={resolve(`/docs/channels/${channel.type}`)}
				class="group rounded-lg border border-surface-500/30 bg-surface-50-950 p-6 transition-all hover:border-primary-500/50 hover:shadow-lg"
			>
				<div class="mb-3 flex items-center gap-3">
					<div
						class="flex size-12 items-center justify-center rounded-lg bg-{channel.color}-500/10"
					>
						<svelte:component this={channel.icon} class="size-6 text-{channel.color}-500" />
					</div>
					<h3 class="text-lg font-semibold group-hover:text-primary-400">
						{channel.name}
					</h3>
				</div>
				<p class="mb-2 text-sm text-surface-600-400">{channel.description}</p>
				<p class="text-xs text-surface-700-300">
					<strong>Use Cases:</strong>
					{channel.useCases}
				</p>
			</a>
		{/each}
	</div>

	<h2>Unity Object Channels</h2>
	<p>Channels for Unity objects like GameObjects and Transforms.</p>

	<div class="not-prose mb-12 grid gap-4 md:grid-cols-2">
		{#each unityChannels as channel}
			<a
				href={resolve(`/docs/channels/${channel.type}`)}
				class="group rounded-lg border border-surface-500/30 bg-surface-50-950 p-6 transition-all hover:border-primary-500/50 hover:shadow-lg"
			>
				<div class="mb-3 flex items-center gap-3">
					<div
						class="flex size-12 items-center justify-center rounded-lg bg-{channel.color}-500/10"
					>
						<svelte:component this={channel.icon} class="size-6 text-{channel.color}-500" />
					</div>
					<h3 class="text-lg font-semibold group-hover:text-primary-400">
						{channel.name}
					</h3>
				</div>
				<p class="mb-2 text-sm text-surface-600-400">{channel.description}</p>
				<p class="text-xs text-surface-700-300">
					<strong>Use Cases:</strong>
					{channel.useCases}
				</p>
			</a>
		{/each}
	</div>

	<h2>Custom Channels</h2>
	<p>Need a channel for your own data types? Create custom channels for any C# type.</p>

	<div class="not-prose mb-12">
		<a
			href={resolve('/docs/channels/custom')}
			class="group flex items-center gap-4 rounded-lg border border-surface-500/30 bg-surface-50-950 p-6 transition-all hover:border-primary-500/50 hover:shadow-lg"
		>
			<div class="flex size-12 items-center justify-center rounded-lg bg-primary-500/10">
				<Cpu class="size-6 text-primary-500" />
			</div>
			<div>
				<h3 class="text-lg font-semibold group-hover:text-primary-400">Creating Custom Channels</h3>
				<p class="text-sm text-surface-600-400">
					Learn how to create type-safe channels for your own structs and classes
				</p>
			</div>
		</a>
	</div>

	<div
		class="not-prose mt-12 rounded-xl border border-surface-500/30 bg-surface-50-950 p-8 text-center"
	>
		<h3 class="mb-4 text-xl font-semibold">Ready to Start Using Channels?</h3>
		<p class="mb-6 text-surface-600-400">
			Pick a channel type above to see detailed examples and best practices.
		</p>
		<div class="flex flex-wrap justify-center gap-4">
			<a href={resolve('/docs/channels/void')} class="btn preset-filled-primary-500 px-6 py-3">
				Start with Void Signals
			</a>
			<a href={resolve('/docs/quick-start')} class="btn preset-tonal px-6 py-3">
				Back to Quick Start
			</a>
		</div>
	</div>
</div>
