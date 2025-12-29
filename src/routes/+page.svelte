<script lang="ts">
	import { resolve } from '$app/paths';
	import SignalFlowDiagram from '$lib/components/docs/landingPage/SignalFlowDiagram.svelte';
	import { Unplug, Eye, CodeXml, Zap, Wrench } from 'lucide-svelte';
</script>

<!-- Hero Section -->
<section class="mx-auto max-w-5xl px-6 pt-2 pb-12">
	<div class="text-center">
		<h1 class="text-5xl leading-tight font-bold md:text-6xl lg:text-7xl">SignalKit</h1>
		<p class="mt-6 text-2xl text-primary-400 md:text-3xl">
			Decouple your Unity project. The modern way.
		</p>
		<p class="mx-auto mt-4 max-w-2xl text-lg text-surface-600-400">
			Event-driven architecture built on ScriptableObjects. Type-safe, visual debugging, zero
			coupling.
		</p>
		<div class="mt-8 flex flex-wrap justify-center gap-4">
			<a
				href={resolve('/docs/getting-started')}
				class="btn preset-filled-primary-500 px-8 py-3 text-lg"
			>
				Get Started
			</a>
			<a href={resolve('/docs')} class="btn preset-tonal px-8 py-3 text-lg"> View Documentation </a>
		</div>
	</div>

	<!-- Diagram below text -->
	<div class="mt-16">
		<SignalFlowDiagram />
	</div>
</section>

<hr />

<!-- Features Section -->
<section class="mx-auto max-w-6xl px-6 py-16 lg:py-24">
	<h2 class="mb-12 text-center text-3xl font-bold md:text-4xl">Key Features</h2>
	<div class="flex flex-wrap justify-center gap-6">
		<!-- Feature 1: Zero Coupling -->
		<div
			class="rounded-xl border border-surface-500/30 bg-surface-50-950 p-8 transition-all hover:border-primary-500/50 hover:shadow-lg"
		>
			<div class="mb-4 flex flex-col items-center">
				<div class="mb-3 flex size-16 items-center justify-center rounded-lg bg-primary-500/10">
					<Unplug class="size-8 text-primary-500" />
				</div>
				<h3 class="text-xl font-semibold">Zero Coupling</h3>
			</div>
			<p class="text-center text-surface-600-400">
				Decouple your components completely. Systems communicate without knowing about each other,
				making your code modular and maintainable.
			</p>
		</div>

		<!-- Feature 2: Visual Debugging -->
		<div
			class="w-full rounded-xl border border-surface-500/30 bg-surface-50-950 p-8 transition-all hover:border-primary-500/50 hover:shadow-lg sm:w-96"
		>
			<div class="mb-4 flex flex-col items-center">
				<div class="mb-3 flex size-16 items-center justify-center rounded-lg bg-primary-500/10">
					<Eye class="size-8 text-primary-500" />
				</div>
				<h3 class="text-xl font-semibold">Visual Debugging</h3>
			</div>
			<p class="text-center text-surface-600-400">
				See every signal in real-time with the built-in debugger. Track event flow, inspect
				payloads, and identify issues instantly.
			</p>
		</div>

		<!-- Feature 3: Type-Safe -->
		<div
			class="w-full rounded-xl border border-surface-500/30 bg-surface-50-950 p-8 transition-all hover:border-primary-500/50 hover:shadow-lg sm:w-96"
		>
			<div class="mb-4 flex flex-col items-center">
				<div class="mb-3 flex size-16 items-center justify-center rounded-lg bg-primary-500/10">
					<CodeXml class="size-8 text-primary-500" />
				</div>
				<h3 class="text-xl font-semibold">Type-Safe Signals</h3>
			</div>
			<p class="text-center text-surface-600-400">
				Strongly-typed channels ensure compile-time safety. No more runtime errors from mismatched
				event types or missing parameters.
			</p>
		</div>

		<!-- Feature 4: ScriptableObject Based -->
		<div
			class="w-full rounded-xl border border-surface-500/30 bg-surface-50-950 p-8 transition-all hover:border-primary-500/50 hover:shadow-lg sm:w-96"
		>
			<div class="mb-4 flex flex-col items-center">
				<div class="mb-3 flex size-16 items-center justify-center rounded-lg bg-primary-500/10">
					<Zap class="size-8 text-primary-500" />
				</div>
				<h3 class="text-xl font-semibold">ScriptableObject Events</h3>
			</div>
			<p class="text-center text-surface-600-400">
				Built on Unity's ScriptableObjects for persistent, scene-independent event channels. Perfect
				for cross-scene communication.
			</p>
		</div>

		<!-- Feature 5: Powerful Editor Tools -->
		<div
			class="w-full rounded-xl border border-surface-500/30 bg-surface-50-950 p-8 transition-all hover:border-primary-500/50 hover:shadow-lg sm:w-96"
		>
			<div class="mb-4 flex flex-col items-center">
				<div class="mb-3 flex size-16 items-center justify-center rounded-lg bg-primary-500/10">
					<Wrench class="size-8 text-primary-500" />
				</div>
				<h3 class="text-xl font-semibold">Powerful Editor Tools</h3>
			</div>
			<p class="text-center text-surface-600-400">
				Raise signals directly from the Inspector, view active listeners, and use the visual
				debugger with recording and playback.
			</p>
		</div>
	</div>
</section>
