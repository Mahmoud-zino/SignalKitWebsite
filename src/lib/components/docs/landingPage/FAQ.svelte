<script lang="ts">
	import { ChevronDown } from 'lucide-svelte';

	let openIndex = $state<number | null>(null);

	function toggleQuestion(index: number) {
		openIndex = openIndex === index ? null : index;
	}

	const faqs = [
		{
			question: 'What is SignalKit?',
			answer:
				'SignalKit is a Unity plugin that provides a decoupled event system built on ScriptableObjects. It allows different parts of your game to communicate without direct references, making your code more modular, testable, and maintainable.'
		},
		{
			question: 'How is this different from C# events or UnityEvents?',
			answer:
				"Unlike C# events, SignalKit requires zero coupling between components - no direct references needed. Unlike UnityEvents, it's strongly-typed for compile-time safety and includes powerful features like visual debugging, recording/playback, priority systems, and filters. It also works seamlessly across scenes."
		},
		{
			question: 'Do I need to know ScriptableObjects?',
			answer:
				'Not at all! SignalKit handles all the ScriptableObject complexity for you. You just create signal channels through the Unity menu, drag them into your scripts, and call Raise() or subscribe to OnRaised. If you can use a prefab, you can use SignalKit.'
		},
		{
			question: 'Will this work with my existing project?',
			answer:
				'Yes! SignalKit integrates smoothly into existing projects. You can adopt it gradually—start with new features or refactor one system at a time. It works alongside your existing code, C# events, and UnityEvents without conflicts.'
		},
		{
			question: 'Does it work in builds or just the editor?',
			answer:
				'SignalKit works perfectly in builds. The visual debugger and editor tools are editor-only, but the core runtime system is optimized for production builds. Zero GC allocations, minimal overhead, and full IL2CPP support.'
		},
		{
			question: "What's the performance impact?",
			answer:
				"Negligible. SignalKit is designed for high-performance games with object pooling, zero GC allocations for events, and efficient dispatching. In most cases, it's comparable to or faster than traditional C# events, especially with large subscriber counts."
		},
		{
			question: 'Is there a learning curve?',
			answer:
				'Minimal. If you understand Unity events, you already know 80% of SignalKit. Most developers are productive within 30 minutes. The core concept is simple: create a channel, raise signals, listen for signals. Advanced features are there when you need them.'
		},
		{
			question: 'What Unity versions are supported?',
			answer:
				'SignalKit supports Unity 2021.3 LTS and newer. It works with all render pipelines (Built-in, URP, HDRP) and all platforms (PC, Mobile, Console, WebGL).'
		}
	];
</script>

<section class="mx-auto max-w-4xl px-6 py-16 lg:py-24">
	<h2 class="mb-12 text-center text-3xl font-bold md:text-4xl">Frequently Asked Questions</h2>

	<div class="space-y-4">
		{#each faqs as faq, index}
			<div
				class="rounded-lg border border-surface-500/30 bg-surface-50-950 transition-all hover:border-primary-500/50"
			>
				<button
					onclick={() => toggleQuestion(index)}
					class="flex w-full items-center justify-between p-6 text-left transition-colors"
				>
					<h3 class="pr-8 text-lg font-semibold">{faq.question}</h3>
					<ChevronDown
						class="size-5 shrink-0 text-primary-500 transition-transform duration-200 {openIndex ===
						index
							? 'rotate-180'
							: ''}"
					/>
				</button>

				{#if openIndex === index}
					<div class="border-t border-surface-500/30 px-6 pt-4 pb-6">
						<p class="text-surface-600-400">{faq.answer}</p>
					</div>
				{/if}
			</div>
		{/each}
	</div>

	<!-- Bottom CTA -->
	<div class="mt-12 text-center">
		<p class="text-surface-600-400">
			Have more questions? <a
				href="/docs"
				class="text-primary-400 underline decoration-primary-400/30 transition-colors hover:decoration-primary-400"
				>Check the documentation</a
			>
		</p>
	</div>
</section>
