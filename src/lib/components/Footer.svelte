<script lang="ts">
	import { resolve } from '$app/paths';
</script>

<footer class="border-t border-surface-500/30 bg-surface-50-950 md:col-span-2">
	<div class="mx-auto max-w-7xl px-4 py-8">
		<div class="grid grid-cols-1 gap-8 md:grid-cols-3">
			<div>
				<h3 class="font-bold">SignalKit</h3>
				<p class="mt-2 text-sm text-surface-600-400">Advanced event system for Unity</p>
			</div>
			<div>
				<h4 class="font-semibold">Documentation</h4>
				<ul class="mt-2 space-y-1 text-sm">
					<li>
						<a
							href={resolve('/docs/getting-started')}
							class="text-surface-600-400 hover:text-primary-500"
						>
							Getting Started
						</a>
					</li>
					<li>
						<a
							href={resolve('/docs/api-reference')}
							class="text-surface-600-400 hover:text-primary-500"
						>
							API Reference
						</a>
					</li>
				</ul>
			</div>
			<div>
				<h4 class="font-semibold">Resources</h4>
				<ul class="mt-2 space-y-1 text-sm">
					<li>
						<a href={resolve('/examples')} class="text-surface-600-400 hover:text-primary-500"
							>Examples</a
						>
					</li>
					<li>
						<a href={resolve('/changelog')} class="text-surface-600-400 hover:text-primary-500"
							>Changelog</a
						>
					</li>
				</ul>
			</div>
		</div>
		<div class="mt-8 border-t border-surface-500/30 pt-4 text-center text-sm text-surface-600-400">
			© {new Date().getFullYear()} SignalKit. All rights reserved.
		</div>
	</div>
</footer>
