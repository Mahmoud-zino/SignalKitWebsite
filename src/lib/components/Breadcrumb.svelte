<script lang="ts">
	import { page } from '$app/stores';

	interface BreadcrumbItem {
		label: string;
		href: string;
	}

	const breadcrumbs = $derived.by(() => {
		const path = $page.url.pathname;

		if (path === '/') return [];

		const segments = path.split('/').filter(Boolean);
		const items: BreadcrumbItem[] = [{ label: 'Home', href: '/' }];

		let currentPath = '';
		segments.forEach((segment) => {
			currentPath += `/${segment}`;
			const label = segment
				.split('-')
				.map((word) => word.charAt(0).toUpperCase() + word.slice(1))
				.join(' ');
			items.push({ label, href: currentPath });
		});
		return items;
	});
</script>

{#if breadcrumbs.length > 0}
	<nav aria-label="Breadcrumb" class="text-sm">
		{#each breadcrumbs as item, index (item.href)}
			{#if index < breadcrumbs.length - 1}
				<!-- eslint-disable-next-line svelte/no-navigation-without-resolve -->
				<a href={item.href} class="anchor">{item.label}</a>
				<span class="mx-2 text-surface-600-400">/</span>
			{:else}
				<span class="text-surface-600-400">{item.label}</span>
			{/if}
		{/each}
	</nav>
{/if}
