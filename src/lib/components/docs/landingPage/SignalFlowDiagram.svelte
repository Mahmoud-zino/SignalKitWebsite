<script lang="ts">
	import { Radio, Ear } from 'lucide-svelte';
	import { onMount } from 'svelte';

	let pulseActive = $state(false);

	onMount(() => {
		const interval = setInterval(() => {
			pulseActive = true;
			setTimeout(() => {
				pulseActive = false;
			}, 1500);
		}, 2500);

		return () => clearInterval(interval);
	});
</script>

<div
	class="relative mx-auto max-w-2xl rounded-2xl border border-surface-500/30 bg-surface-50-950 p-8"
>

	<!-- Center Signal -->
	<div class="absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2">
		<div class="relative">
			{#if pulseActive}
				<div class="absolute inset-0 animate-ping rounded-full bg-primary-500 opacity-75"></div>
			{/if}
			<div
				class="relative flex size-20 items-center justify-center rounded-full bg-primary-500 shadow-lg shadow-primary-500/50"
			>
				<Radio class="size-10 text-white" />
			</div>
		</div>
	</div>

	<!-- Top-left listener -->
	<div class="absolute left-[16.67%] top-[20%] -translate-x-1/2 -translate-y-1/2">
		<div class="relative">
			{#if pulseActive}
				<div class="absolute inset-0 animate-pulse rounded-full bg-primary-500 opacity-75"></div>
			{/if}
			<div
				class="flex size-14 items-center justify-center rounded-full bg-secondary-500/80 shadow-md"
			>
				<Ear class="size-6 text-white" />
			</div>
		</div>
	</div>

	<!-- Top-right listener -->
	<div class="absolute right-[16.67%] top-[20%] translate-x-1/2 -translate-y-1/2">
		<div class="relative">
			{#if pulseActive}
				<div class="absolute inset-0 animate-pulse rounded-full bg-primary-500 opacity-75"></div>
			{/if}
			<div
				class="flex size-14 items-center justify-center rounded-full bg-secondary-500/80 shadow-md"
			>
				<Ear class="size-6 text-white" />
			</div>
		</div>
	</div>

	<!-- Bottom-right listener -->
	<div class="absolute bottom-[20%] right-[16.67%] translate-x-1/2 translate-y-1/2">
		<div class="relative">
			{#if pulseActive}
				<div class="absolute inset-0 animate-pulse rounded-full bg-primary-500 opacity-75"></div>
			{/if}
			<div
				class="flex size-14 items-center justify-center rounded-full bg-secondary-500/80 shadow-md"
			>
				<Ear class="size-6 text-white" />
			</div>
		</div>
	</div>

	<!-- Bottom-left listener -->
	<div class="absolute bottom-[20%] left-[16.67%] -translate-x-1/2 translate-y-1/2">
		<div class="relative">
			{#if pulseActive}
				<div class="absolute inset-0 animate-pulse rounded-full bg-primary-500 opacity-75"></div>
			{/if}
			<div
				class="flex size-14 items-center justify-center rounded-full bg-secondary-500/80 shadow-md"
			>
				<Ear class="size-6 text-white" />
			</div>
		</div>
	</div>

	<!-- Spacer to maintain height -->
	<div class="h-96"></div>

	<!-- Legend -->
	<div class="mt-8 flex items-center justify-center gap-8 text-sm text-surface-600-400">
		<div class="flex items-center gap-2">
			<Radio class="size-5 text-primary-500" />
			<span>Signal Channel</span>
		</div>
		<div class="flex items-center gap-2">
			<Ear class="size-5 text-secondary-500" />
			<span>4 Listeners</span>
		</div>
	</div>
</div>
