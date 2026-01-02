<script lang="ts">
	import { User, Users, Code } from 'lucide-svelte';
</script>

<section class="mx-auto max-w-6xl px-6 py-16 lg:py-24">
	<h2 class="mb-12 text-center text-3xl font-bold md:text-4xl">Perfect For</h2>

	<div class="grid gap-8 md:grid-cols-3">
		<!-- Solo Developers -->
		<div
			class="rounded-xl border border-surface-500/30 bg-surface-50-950 p-8 text-center transition-all hover:border-primary-500/50 hover:shadow-lg"
		>
			<div class="mb-4 flex justify-center">
				<div class="flex size-16 items-center justify-center rounded-lg bg-primary-500/10">
					<User class="size-8 text-primary-500" />
				</div>
			</div>
			<h3 class="mb-3 text-xl font-semibold">Solo Developers</h3>
			<p class="text-surface-600-400">
				Build scalable architecture from day one. No more refactoring nightmares when your game
				grows beyond prototypes.
			</p>
		</div>

		<!-- Small Teams -->
		<div
			class="rounded-xl border border-surface-500/30 bg-surface-50-950 p-8 text-center transition-all hover:border-primary-500/50 hover:shadow-lg"
		>
			<div class="mb-4 flex justify-center">
				<div class="flex size-16 items-center justify-center rounded-lg bg-primary-500/10">
					<Users class="size-8 text-primary-500" />
				</div>
			</div>
			<h3 class="mb-3 text-xl font-semibold">Small Teams</h3>
			<p class="text-surface-600-400">
				Work in parallel without merge conflicts. Decouple systems so team members never block each
				other's progress.
			</p>
		</div>

		<!-- Live Projects -->
		<div
			class="rounded-xl border border-surface-500/30 bg-surface-50-950 p-8 text-center transition-all hover:border-primary-500/50 hover:shadow-lg"
		>
			<div class="mb-4 flex justify-center">
				<div class="flex size-16 items-center justify-center rounded-lg bg-primary-500/10">
					<Code class="size-8 text-primary-500" />
				</div>
			</div>
			<h3 class="mb-3 text-xl font-semibold">Live Projects</h3>
			<p class="text-surface-600-400">
				Refactor safely without breaking everything. Add new features to existing games with
				confidence.
			</p>
		</div>
	</div>
</section>
