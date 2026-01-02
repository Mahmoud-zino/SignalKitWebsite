<script lang="ts">
	import { Radio, Coins, Volume2, Logs, ChartNetwork, Trophy } from 'lucide-svelte';
	import { onMount } from 'svelte';

	let isAnimating = $state(false);
	let scoreValue = $state(0);
	let achievementUnlocked = $state(false);
	let coinSound: HTMLAudioElement | null = null;

	onMount(() => {
		coinSound = new Audio('/sounds/coin.ogg');
		coinSound.volume = 0.5;
	});

	function raiseSignal() {
		if (isAnimating) return;

		isAnimating = true;
		scoreValue += 10;

		if (coinSound) {
			coinSound.currentTime = 0;
			coinSound.play().catch(() => {
				// Ignore errors (e.g., if user hasn't interacted with page yet)
			});
		}

		if (scoreValue >= 50 && !achievementUnlocked) {
			achievementUnlocked = true;
		}

		setTimeout(() => {
			isAnimating = false;
		}, 1500);
	}

	function resetDemo() {
		scoreValue = 0;
		achievementUnlocked = false;
	}
</script>

<div class="relative mx-auto max-w-4xl">
	<!-- Title -->
	<div class="mb-8 text-center">
		<h3 class="mb-2 text-2xl font-bold">See It In Action</h3>
		<p class="text-surface-600-400">Click the button to raise a signal.</p>
	</div>

	<!-- Desktop: Circular layout with center channel -->
	<div
		class="relative hidden overflow-hidden rounded-2xl border border-surface-500/30 bg-surface-50-950 p-8 md:block md:p-12"
	>
		<!-- Wave animation -->
		{#if isAnimating}
			<div
				class="pointer-events-none absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2"
				style="z-index: 5;"
			>
				<div
					class="absolute inset-0 animate-ping rounded-full bg-primary-500/30"
					style="width: 0; height: 0; animation-duration: 1.5s;"
				></div>
				<div
					class="size-0 rounded-full bg-primary-500/20"
					style="animation: wave 1.5s ease-out forwards;"
				></div>
			</div>
		{/if}

		<!-- Center: Signal Channel -->
		<div class="absolute top-1/2 left-1/2 z-10 -translate-x-1/2 -translate-y-1/2">
			<div class="flex items-center gap-4">
				<div class="text-sm font-semibold text-primary-400">Signal Channel</div>
				<div class="relative">
					{#if isAnimating}
						<div class="absolute inset-0 animate-ping rounded-full bg-primary-500 opacity-75"></div>
						<div
							class="absolute inset-0 animate-ping rounded-full bg-primary-500 opacity-50"
							style="animation-delay: 150ms;"
						></div>
					{/if}
					<div
						class="relative flex size-24 items-center justify-center rounded-full border-4 border-primary-400 bg-primary-500 shadow-xl shadow-primary-500/50"
					>
						<Radio class="size-12 text-white" />
					</div>
				</div>
				<div class="font-mono text-xs text-surface-600-400">OnCoinCollected</div>
			</div>
		</div>

		<!-- Top Left: UI System -->
		<div class="absolute top-[10%] left-[8%] z-10">
			<div
				class="flex h-30 w-40 flex-col rounded-lg border border-surface-500/30 bg-surface-100-900 p-4 shadow-lg"
			>
				<div class="mb-2 flex items-center gap-2">
					<div class="flex size-8 items-center justify-center rounded-full bg-secondary-500/20">
						<ChartNetwork class="size-4 text-secondary-500" />
					</div>
					<div class="text-sm font-semibold">UI System</div>
				</div>
				<div class="text-xs text-surface-600-400">Score Display</div>
				<div
					class="mt-auto text-xl font-bold text-secondary-400 {isAnimating ? 'animate-pulse' : ''}"
				>
					{scoreValue}
				</div>
			</div>
		</div>

		<!-- Top Right: Audio System -->
		<div class="absolute top-[10%] right-[8%] z-10">
			<div
				class="flex h-30 w-40 flex-col rounded-lg border border-surface-500/30 bg-surface-100-900 p-4 shadow-lg"
			>
				<div class="mb-2 flex items-center gap-2">
					<div class="flex size-8 items-center justify-center rounded-full bg-tertiary-500/20">
						<Volume2 class="size-4 text-tertiary-500" />
					</div>
					<div class="text-sm font-semibold">Audio</div>
				</div>
				<div class="text-xs text-surface-600-400">Sound Effect</div>
				<div class="mt-auto">
					{#if isAnimating}
						<div class="flex items-center gap-1">
							<div
								class="h-4 w-1 animate-pulse bg-tertiary-500"
								style="animation-delay: 0ms;"
							></div>
							<div
								class="h-6 w-1 animate-pulse bg-tertiary-500"
								style="animation-delay: 50ms;"
							></div>
							<div
								class="h-8 w-1 animate-pulse bg-tertiary-500"
								style="animation-delay: 100ms;"
							></div>
							<div
								class="h-6 w-1 animate-pulse bg-tertiary-500"
								style="animation-delay: 150ms;"
							></div>
							<div
								class="h-4 w-1 animate-pulse bg-tertiary-500"
								style="animation-delay: 200ms;"
							></div>
						</div>
					{:else}
						<div class="text-xs text-surface-600-400 italic">Waiting...</div>
					{/if}
				</div>
			</div>
		</div>

		<!-- Bottom Right: Achievement System -->
		<div class="absolute right-[8%] bottom-[10%] z-10">
			<div
				class="flex h-30 w-40 flex-col rounded-lg border border-surface-500/30 bg-surface-100-900 p-4 shadow-lg"
			>
				<div class="mb-2 flex items-center gap-2">
					<div class="flex size-8 items-center justify-center rounded-full bg-warning-500/20">
						<Trophy class="size-4 text-warning-500" />
					</div>
					<div class="text-sm font-semibold">Achievements</div>
				</div>
				<div class="text-xs text-surface-600-400">Progress Check</div>
				<div class="mt-auto">
					{#if achievementUnlocked}
						<div class="animate-pulse text-xs font-semibold text-warning-400">
							🎉 Coin Collector!
						</div>
					{:else}
						<div class="text-xs text-surface-600-400">
							{scoreValue}/50
						</div>
					{/if}
				</div>
			</div>
		</div>

		<!-- Bottom Left: Analytics -->
		<div class="absolute bottom-[10%] left-[8%] z-10">
			<div
				class="flex h-30 w-40 flex-col rounded-lg border border-surface-500/30 bg-surface-100-900 p-4 shadow-lg"
			>
				<div class="mb-2 flex items-center gap-2">
					<div class="flex size-8 items-center justify-center rounded-full bg-success-500/20">
						<Logs class="size-4 text-success-500" />
					</div>
					<div class="text-sm font-semibold">Analytics</div>
				</div>
				<div class="text-xs text-surface-600-400">Event Tracking</div>
				<div class="mt-auto">
					{#if isAnimating}
						<div class="animate-pulse text-xs text-success-400">Logging...</div>
					{:else}
						<div class="text-xs text-surface-600-400 italic">Idle</div>
					{/if}
				</div>
			</div>
		</div>

		<!-- Spacer to maintain height -->
		<div class="h-125"></div>
	</div>

	<!-- Mobile: Vertical flow layout -->
	<div
		class="relative overflow-hidden rounded-2xl border border-surface-500/30 bg-surface-50-950 p-6 md:hidden"
	>
		<!-- Wave animation -->
		{#if isAnimating}
			<div
				class="pointer-events-none absolute top-20 left-1/2 -translate-x-1/2"
				style="z-index: 5;"
			>
				<div
					class="size-0 rounded-full bg-primary-500/20"
					style="animation: wave 1.5s ease-out forwards;"
				></div>
			</div>
		{/if}

		<!-- Signal Channel at top -->
		<div class="mb-6">
			<div class="flex items-center justify-center gap-3">
				<div class="text-sm font-semibold text-primary-400">Signal Channel</div>
				<div class="relative">
					{#if isAnimating}
						<div class="absolute inset-0 animate-ping rounded-full bg-primary-500 opacity-75"></div>
					{/if}
					<div
						class="relative flex size-20 items-center justify-center rounded-full border-4 border-primary-400 bg-primary-500 shadow-xl shadow-primary-500/50"
					>
						<Radio class="size-10 text-white" />
					</div>
				</div>
				<div class="font-mono text-xs text-surface-600-400">OnCoinCollected</div>
			</div>
		</div>

		<!-- Listeners in vertical stack -->
		<div class="space-y-3">
			<!-- UI System -->
			<div
				class="flex flex-col rounded-lg border border-surface-500/30 bg-surface-100-900 p-3 shadow-lg"
			>
				<div class="mb-2 flex items-center gap-2">
					<div class="flex size-8 items-center justify-center rounded-full bg-secondary-500/20">
						<ChartNetwork class="size-4 text-secondary-500" />
					</div>
					<div class="text-sm font-semibold">UI System</div>
					<div
						class="ml-auto text-xl font-bold text-secondary-400 {isAnimating
							? 'animate-pulse'
							: ''}"
					>
						{scoreValue}
					</div>
				</div>
			</div>

			<!-- Audio System -->
			<div
				class="flex flex-col rounded-lg border border-surface-500/30 bg-surface-100-900 p-3 shadow-lg"
			>
				<div class="mb-2 flex items-center gap-2">
					<div class="flex size-8 items-center justify-center rounded-full bg-tertiary-500/20">
						<Volume2 class="size-4 text-tertiary-500" />
					</div>
					<div class="text-sm font-semibold">Audio</div>
					<div class="ml-auto">
						{#if isAnimating}
							<div class="flex items-center gap-1">
								<div
									class="h-3 w-1 animate-pulse bg-tertiary-500"
									style="animation-delay: 0ms;"
								></div>
								<div
									class="h-4 w-1 animate-pulse bg-tertiary-500"
									style="animation-delay: 50ms;"
								></div>
								<div
									class="h-5 w-1 animate-pulse bg-tertiary-500"
									style="animation-delay: 100ms;"
								></div>
								<div
									class="h-4 w-1 animate-pulse bg-tertiary-500"
									style="animation-delay: 150ms;"
								></div>
								<div
									class="h-3 w-1 animate-pulse bg-tertiary-500"
									style="animation-delay: 200ms;"
								></div>
							</div>
						{:else}
							<div class="text-xs text-surface-600-400 italic">Waiting...</div>
						{/if}
					</div>
				</div>
			</div>

			<!-- Achievements -->
			<div
				class="flex flex-col rounded-lg border border-surface-500/30 bg-surface-100-900 p-3 shadow-lg"
			>
				<div class="mb-2 flex items-center gap-2">
					<div class="flex size-8 items-center justify-center rounded-full bg-warning-500/20">
						<Trophy class="size-4 text-warning-500" />
					</div>
					<div class="text-sm font-semibold">Achievements</div>
					<div class="ml-auto">
						{#if achievementUnlocked}
							<div class="animate-pulse text-xs font-semibold text-warning-400">
								🎉 Coin Collector!
							</div>
						{:else}
							<div class="text-xs text-surface-600-400">
								{scoreValue}/50
							</div>
						{/if}
					</div>
				</div>
			</div>

			<!-- Analytics -->
			<div
				class="flex flex-col rounded-lg border border-surface-500/30 bg-surface-100-900 p-3 shadow-lg"
			>
				<div class="mb-2 flex items-center gap-2">
					<div class="flex size-8 items-center justify-center rounded-full bg-success-500/20">
						<Logs class="size-4 text-success-500" />
					</div>
					<div class="text-sm font-semibold">Analytics</div>
					<div class="ml-auto">
						{#if isAnimating}
							<div class="animate-pulse text-xs text-success-400">Logging...</div>
						{:else}
							<div class="text-xs text-surface-600-400 italic">Idle</div>
						{/if}
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Interactive Buttons -->
	<div class="mt-8 text-center">
		<div class="flex flex-wrap justify-center gap-4">
			<button
				onclick={raiseSignal}
				disabled={isAnimating}
				class="btn preset-filled-primary-500 px-8 py-4 text-lg font-semibold disabled:cursor-not-allowed disabled:opacity-50"
			>
				<Coins class="mr-2 inline size-6" />
				{isAnimating ? 'Raising Signal...' : 'Collect Coin'}
			</button>
			<button
				onclick={resetDemo}
				class="btn preset-filled-surface-500 px-8 py-4 text-lg font-semibold"
			>
				Reset Demo
			</button>
		</div>
		<p class="mt-4 text-sm text-surface-600-400">
			One signal, four systems updated instantly. <strong class="text-primary-400"
				>Zero coupling.</strong
			>
		</p>
	</div>
</div>

<style>
	@keyframes wave {
		0% {
			width: 0;
			height: 0;
			opacity: 0.5;
		}
		50% {
			opacity: 0.3;
		}
		100% {
			width: 1200px;
			height: 1200px;
			opacity: 0;
		}
	}
</style>
