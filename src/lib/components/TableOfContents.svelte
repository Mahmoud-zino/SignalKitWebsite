<script lang="ts">
	import { browser } from '$app/environment';
	import { mount, onMount, unmount } from 'svelte';
	import { Link } from 'lucide-svelte';
	import { hasTocContent } from '$lib/stores/toc';

	interface Heading {
		id: string;
		text: string;
		level: number;
	}

	let headings: Heading[] = $state([]);
	let activeId = $state('');
	let userClicked = false;

	onMount(() => {
		hasTocContent.set(false);

		const headingElements = document.querySelectorAll('article h2[id], article h3[id]');
		const instances: Array<ReturnType<typeof mount>> = [];

		headings = Array.from(headingElements).map((heading) => ({
			id: heading.id,
			text: heading.textContent || '',
			level: parseInt(heading.tagName.charAt(1))
		}));

		if (headings.length > 0) {
			activeId = headings[0].id;
			hasTocContent.set(true);

			headingElements.forEach((heading) => {
				heading.classList.add('heading-with-anchor');

				const button = document.createElement('button');
				button.className = 'heading-anchor-link';
				button.setAttribute('aria-label', 'Link to section');

				const iconContainer = document.createElement('span');
				const linkIcon = mount(Link, { target: iconContainer, props: { size: 18 } });
				instances.push(linkIcon);

				button.appendChild(iconContainer);
				button.onclick = (e) => {
					e.preventDefault();
					userClicked = true;
					activeId = heading.id;
					window.location.hash = heading.id;
					setTimeout(() => {
						userClicked = false;
					}, 1000);
				};

				heading.appendChild(button);
			});
		} else {
			hasTocContent.set(false);
		}

		function updateActiveHeading() {
			if (headings.length === 0 || userClicked) return;

			for (let i = headings.length - 1; i >= 0; i--) {
				const element = document.getElementById(headings[i].id);
				if (element) {
					const { top } = element.getBoundingClientRect();
					if (top <= 100) {
						if (activeId !== headings[i].id) {
							activeId = headings[i].id;
						}
						return;
					}
				}
			}

			if (activeId !== headings[0].id) {
				activeId = headings[0].id;
			}
		}

		window.addEventListener('scroll', updateActiveHeading, { passive: true });
		window.addEventListener('resize', updateActiveHeading, { passive: true });

		return () => {
			window.removeEventListener('scroll', updateActiveHeading);
			window.removeEventListener('resize', updateActiveHeading);
			instances.forEach((icon) => unmount(icon));
		};
	});

	function scrollToHeading(id: string) {
		if (browser) {
			const element = document.getElementById(id);
			if (element) {
				userClicked = true;
				activeId = id;
				window.location.hash = id;
				const elementPosition = element.getBoundingClientRect().top + window.scrollY;
				const offsetPosition = elementPosition - 100;

				window.scrollTo({
					top: offsetPosition,
					behavior: 'smooth'
				});

				setTimeout(() => {
					userClicked = false;
				}, 1000);
			}
		}
	}
</script>

{#if headings.length > 0}
	<nav class="max-w-md" aria-label="Table of Contents">
		<h4 class="mb-4 text-sm font-semibold text-surface-600-400 uppercase">On this Page</h4>
		<ul class="space-y-2 text-sm">
			{#each headings as heading (heading.id)}
				{@const isActive = activeId === heading.id}
				{@const indent = (heading.level - 2) * 24}
				<li style="padding-left: {indent}px">
					<button
						type="button"
						onclick={() => scrollToHeading(heading.id)}
						class="relative block w-full py-1 text-left transition-colors hover:text-primary-500 {isActive
							? 'text-primary-400'
							: 'text-surface-600-400'}"
					>
						{#if isActive}
							<span class="absolute top-0 left-0 h-full w-1 bg-primary-500"></span>
						{/if}
						<span class="pl-3">{heading.text}</span>
					</button>
				</li>
			{/each}
		</ul>
	</nav>
{/if}

<style>
	nav {
		position: sticky;
		top: 5rem;
		max-height: calc(100vh - 6rem);
		overflow-y: auto;
	}

	:global(.heading-with-anchor) {
		position: relative;
		display: flex;
		align-items: center;
		gap: 0.5rem;
	}

	:global(.heading-anchor-link) {
		opacity: 0;
		transition: opacity 0.2s;
		background: none;
		border: none;
		cursor: pointer;
		color: rgb(var(--color-primary-500));
		display: inline-flex;
		align-items: center;
		padding: 0.25rem;
		border-radius: 0.25rem;
	}

	:global(.heading-anchor-link:hover) {
		background-color: rgb(var(--color-surface-200));
	}

	:global(.heading-with-anchor:hover .heading-anchor-link) {
		opacity: 1;
	}
</style>
