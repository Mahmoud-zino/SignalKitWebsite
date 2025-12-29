<script lang="ts">
	import { resolve } from '$app/paths';
	import SignalFlowDiagram from '$lib/components/docs/landingPage/SignalFlowDiagram.svelte';
	import { Unplug, Eye, Code2, Zap, Wrench } from 'lucide-svelte';
</script>

<!-- Hero Section -->
<section class="mx-auto max-w-5xl px-6 py-20 lg:py-32">
	<div class="text-center">
		<h1 class="text-5xl font-bold leading-tight md:text-6xl lg:text-7xl">SignalKit</h1>
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
			<a href={resolve('/docs')} class="btn preset-tonal px-8 py-3 text-lg">
				View Documentation
			</a>
		</div>
	</div>

	<!-- Diagram below text -->
	<div class="mt-16">
		<SignalFlowDiagram />
	</div>
</section>
