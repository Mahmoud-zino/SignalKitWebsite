<script lang="ts">
	import { resolve } from '$app/paths';
	import SignalFlowDiagram from '$lib/components/docs/landingPage/SignalFlowDiagram.svelte';
	import HighlightedCode from '$lib/components/HighlightedCode.svelte';
	import { Unplug, Eye, CodeXml, Zap, Wrench } from 'lucide-svelte';

	let activeTab = $state(0);

	const codeExamples = [
		{
			title: '1. Create Channel',
			code: `// Create a new signal channel (ScriptableObject)
[CreateAssetMenu(menuName = "Signals/Player Health Changed")]
public class PlayerHealthSignal : SignalChannel<int> { }`
		},
		{
			title: '2. Raise Signal',
			code: `// Raise a signal from anywhere in your code
public class PlayerHealth : MonoBehaviour
{
    [SerializeField] private PlayerHealthSignal healthSignal;

    public void TakeDamage(int damage)
    {
        currentHealth -= damage;
        healthSignal.Raise(currentHealth); // Broadcast to all listeners
    }
}`
		},
		{
			title: '3. Listen',
			code: `// Listen to signals - no references needed!
public class HealthUI : MonoBehaviour
{
    [SerializeField] private PlayerHealthSignal healthSignal;

    private void OnEnable()
    {
        healthSignal.OnRaised += UpdateHealthBar;
    }

    private void OnDisable()
    {
        healthSignal.OnRaised -= UpdateHealthBar;
    }

    private void UpdateHealthBar(int newHealth)
    {
        // Update UI
    }
}`
		}
	];
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

<hr />

<!-- Quick Start Section -->
<section class="mx-auto max-w-5xl px-6 py-16 lg:py-24">
	<h2 class="mb-4 text-center text-3xl font-bold md:text-4xl">Get Started in Minutes</h2>
	<p class="mb-12 text-center text-lg text-surface-600-400">
		See how easy it is to decouple your Unity project with SignalKit
	</p>

	<div class="rounded-2xl border border-surface-500/30 bg-surface-50-950 p-8">
		<!-- Code example tabs -->
		<div class="mb-6 flex flex-wrap gap-2">
			{#each codeExamples as example, index (example.title)}
				<button
					onclick={() => (activeTab = index)}
					class={activeTab === index
						? 'btn preset-filled-primary-500 px-4 py-2 text-sm'
						: 'btn preset-tonal px-4 py-2 text-sm'}
				>
					{example.title}
				</button>
			{/each}
		</div>

		<!-- Code block -->
		<HighlightedCode code={codeExamples[activeTab].code} lang="csharp" />

		<div class="mt-6 text-center">
			<a href={resolve('/docs/getting-started')} class="btn preset-filled-primary-500 px-6 py-3">
				View Full Documentation
			</a>
		</div>
	</div>
</section>

<hr />

<!-- Why SignalKit Section -->
<section class="mx-auto max-w-6xl px-6 py-16 lg:py-24">
	<h2 class="mb-16 text-center text-3xl font-bold md:text-4xl">Why SignalKit?</h2>

	<!-- Problem/Solution Headers (Desktop only) -->
	<div class="mb-8 hidden gap-12 lg:grid lg:grid-cols-2 lg:gap-16">
		<h3 class="text-2xl font-bold text-error-500">The Problem</h3>
		<h3 class="text-2xl font-bold text-success-500">The Solution</h3>
	</div>

	<!-- Problem/Solution Pairs -->
	<div class="space-y-8 lg:space-y-6">
		<!-- Pair 1: Tight Coupling -->
		<div class="grid gap-4 lg:grid-cols-2 lg:gap-16">
			<div class="rounded-lg border border-error-500/30 bg-error-500/5 p-6">
				<h4 class="mb-2 font-semibold text-error-400">
					<span class="lg:hidden">The Problem:</span> Tight Coupling
				</h4>
				<p class="text-sm text-surface-600-400">
					Your UI needs a reference to PlayerHealth. Your AudioManager needs a reference to the
					Enemy script. Everything knows about everything else, creating a tangled mess.
				</p>
			</div>
			<div class="rounded-lg border border-success-500/30 bg-success-500/5 p-6">
				<h4 class="mb-2 font-semibold text-success-400">
					<span class="lg:hidden">The Solution:</span> Zero Coupling
				</h4>
				<p class="text-sm text-surface-600-400">
					Components communicate through ScriptableObject channels. Your UI doesn't know about
					PlayerHealth. Your AudioManager doesn't know about enemies. They just listen to signals.
				</p>
			</div>
		</div>

		<!-- Pair 2: Fragile Refactoring -->
		<div class="grid gap-4 lg:grid-cols-2 lg:gap-16">
			<div class="rounded-lg border border-error-500/30 bg-error-500/5 p-6">
				<h4 class="mb-2 font-semibold text-error-400">
					<span class="lg:hidden">The Problem:</span> Fragile Refactoring
				</h4>
				<p class="text-sm text-surface-600-400">
					Want to rename a class? Move it to another namespace? Break it into smaller pieces? Good
					luck tracking down every reference across your entire project.
				</p>
			</div>
			<div class="rounded-lg border border-success-500/30 bg-success-500/5 p-6">
				<h4 class="mb-2 font-semibold text-success-400">
					<span class="lg:hidden">The Solution:</span> Fearless Refactoring
				</h4>
				<p class="text-sm text-surface-600-400">
					Rename, move, restructure—your signals keep working. Change your entire architecture
					without breaking connections. Your code stays flexible.
				</p>
			</div>
		</div>

		<!-- Pair 3: Testing Nightmare -->
		<div class="grid gap-4 lg:grid-cols-2 lg:gap-16">
			<div class="rounded-lg border border-error-500/30 bg-error-500/5 p-6">
				<h4 class="mb-2 font-semibold text-error-400">
					<span class="lg:hidden">The Problem:</span> Testing Nightmare
				</h4>
				<p class="text-sm text-surface-600-400">
					Can't test your UI without the entire game running. Can't test audio without instantiating
					enemies. Unit testing? Forget about it.
				</p>
			</div>
			<div class="rounded-lg border border-success-500/30 bg-success-500/5 p-6">
				<h4 class="mb-2 font-semibold text-success-400">
					<span class="lg:hidden">The Solution:</span> Easy Testing
				</h4>
				<p class="text-sm text-surface-600-400">
					Test components in isolation. Mock signals effortlessly. Unit test your UI without
					starting PlayMode. Your tests run fast and stay reliable.
				</p>
			</div>
		</div>
	</div>

	<!-- Bottom Statement -->
	<div class="mt-16 text-center">
		<p class="mx-auto max-w-3xl text-xl text-surface-600-400">
			SignalKit gives you the architecture large studios use, without the complexity. Build
			maintainable games from day one.
		</p>
	</div>
</section>

<hr />

<!-- CTA Section -->
<section class="mx-auto max-w-4xl px-6 py-16 lg:py-24">
	<div
		class="rounded-2xl border border-primary-500/30 bg-gradient-to-br from-primary-500/10 to-secondary-500/10 p-8 text-center lg:p-12"
	>
		<h2 class="mb-4 text-3xl font-bold md:text-4xl">Ready to Decouple Your Game?</h2>
		<p class="mx-auto mb-8 max-w-2xl text-lg text-surface-600-400">
			Join developers building better Unity games with SignalKit. Start with our comprehensive
			documentation or dive right into the code.
		</p>
		<div class="flex flex-wrap justify-center gap-4">
			<a
				href={resolve('/docs/getting-started')}
				class="btn preset-filled-primary-500 px-8 py-3 text-lg"
			>
				Get Started
			</a>
			<a href={resolve('/docs')} class="btn preset-tonal px-8 py-3 text-lg"> View Documentation </a>
		</div>
	</div>
</section>
