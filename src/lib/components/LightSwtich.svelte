<script lang="ts">
	import { Switch } from '@skeletonlabs/skeleton-svelte';
	import { SunIcon, MoonIcon } from 'lucide-svelte';
	import { browser } from '$app/environment';

	function getInitialMode(): string {
		if (!browser) return 'dark';

		const storedMode = localStorage.getItem('mode');

		if (storedMode) {
			return storedMode;
		} else if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
			return 'dark';
		} else if (window.matchMedia && window.matchMedia('(prefers-color-scheme: light)').matches) {
			return 'light';
		} else {
			return 'dark';
		}
	}

	let checked = $state(getInitialMode() === 'dark');

	const mode = $derived(checked ? 'dark' : 'light');

	$effect(() => {
		if (browser) {
			document.documentElement.setAttribute('data-mode', mode);
		}
	});

	const onCheckedChange = (event: { checked: boolean }) => {
		if (browser) {
			localStorage.setItem('mode', mode);
		}
		checked = event.checked;
	};
</script>

<svelte:head>
	<script>
		const storedMode = localStorage.getItem('mode');

		let mode;
		if (storedMode) {
			mode = storedMode;
		} else if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
			mode = 'dark';
		} else if (window.matchMedia && window.matchMedia('(prefers-color-scheme: light)').matches) {
			mode = 'light';
		} else {
			mode = 'dark';
		}

		document.documentElement.setAttribute('data-mode', mode);
	</script>
</svelte:head>

<Switch {checked} {onCheckedChange}>
	<Switch.Control>
		<Switch.Thumb>
			{#if checked}
				<MoonIcon class="size-3" />
			{:else}
				<SunIcon class="size-3" />
			{/if}
		</Switch.Thumb>
	</Switch.Control>
	<Switch.HiddenInput />
</Switch>
