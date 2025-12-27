<script lang="ts">
	import { Check, Copy } from 'lucide-svelte';
	import { mount, onMount, unmount } from 'svelte';

	onMount(() => {
		const codeBlocks = document.querySelectorAll('pre');
		const instances: Array<{
			copyIcon: ReturnType<typeof mount>;
			checkIcon: ReturnType<typeof mount>;
		}> = [];

		codeBlocks.forEach((pre) => {
			if (pre.querySelector('.copy-button')) return;

			const wrapper = document.createElement('div');
			wrapper.className = 'code-block-wrapper';
			pre.parentNode?.insertBefore(wrapper, pre);
			wrapper.appendChild(pre);

			const button = document.createElement('button');
			button.className = 'copy-button btn-icon btn-icon-sm preset-filled-primary-500';
			button.setAttribute('aria-label', 'Copy code');

			const copyIconContainer = document.createElement('span');
			copyIconContainer.className = 'copy-icon';
			const checkIconContainer = document.createElement('span');
			checkIconContainer.className = 'check-icon hidden';

			const copyIcon = mount(Copy, { target: copyIconContainer, props: { size: 16 } });
			const checkIcon = mount(Check, { target: checkIconContainer, props: { size: 16 } });
			instances.push({ copyIcon, checkIcon });

			button.appendChild(copyIconContainer);
			button.appendChild(checkIconContainer);

			button.addEventListener('click', async () => {
				const code = pre.querySelector('code');
				if (!code) return;

				await navigator.clipboard.writeText(code.textContent || '');

				copyIconContainer.classList.add('hidden');
				checkIconContainer.classList.remove('hidden');

				setTimeout(() => {
					copyIconContainer.classList.remove('hidden');
					checkIconContainer.classList.add('hidden');
				}, 2000);
			});
			wrapper.appendChild(button);
		});

		return () => {
			instances.forEach(({ copyIcon, checkIcon }) => {
				unmount(copyIcon);
				unmount(checkIcon);
			});
		};
	});
</script>

<style>
	:global(.code-block-wrapper) {
		position: relative;
	}

	:global(.copy-button) {
		position: absolute;
		top: 0.5rem;
		right: 0.5rem;
		z-index: 10;
	}
</style>
