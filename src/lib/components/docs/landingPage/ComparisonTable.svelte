<script lang="ts">
	import { Check, X, TriangleAlert } from 'lucide-svelte';
</script>

<section class="mx-auto max-w-6xl px-6 py-16 lg:py-24">
	<h2 class="mb-12 text-center text-3xl font-bold md:text-4xl">SignalKit vs. Alternatives</h2>

	<!-- Desktop Table -->
	<div class="hidden overflow-x-auto lg:block">
		<table class="w-full border-collapse">
			<thead>
				<tr class="border-b-2 border-surface-500/30">
					<th class="p-4 text-left font-semibold">Feature</th>
					<th class="p-4 text-center font-semibold">C# Events</th>
					<th class="p-4 text-center font-semibold">UnityEvents</th>
					<th class="bg-primary-500/5 p-4 text-center font-semibold text-primary-400">SignalKit</th>
				</tr>
			</thead>
			<tbody class="text-sm">
				<!-- Row 1: Zero Coupling -->
				<tr class="border-b border-surface-500/20">
					<td class="p-4 font-medium">Zero Coupling</td>
					<td class="p-4">
						<div class="flex flex-col items-center justify-center gap-2">
							<X class="size-5 shrink-0 text-error-500" />
							<span class="text-center text-xs text-surface-600-400">Requires references</span>
						</div>
					</td>
					<td class="p-4">
						<div class="flex flex-col items-center justify-center gap-2">
							<TriangleAlert class="size-5 shrink-0 text-warning-500" />
							<span class="text-center text-xs text-surface-600-400">Inspector only</span>
						</div>
					</td>
					<td class="bg-primary-500/5 p-4">
						<div class="flex flex-col items-center justify-center gap-2">
							<Check class="size-5 shrink-0 text-success-500" />
							<span class="text-center text-xs text-surface-600-400">ScriptableObject channels</span
							>
						</div>
					</td>
				</tr>

				<!-- Row 2: Visual Debugging -->
				<tr class="border-b border-surface-500/20">
					<td class="p-4 font-medium">Visual Debugging</td>
					<td class="p-4">
						<div class="flex flex-col items-center justify-center gap-2">
							<X class="size-5 shrink-0 text-error-500" />
							<span class="text-center text-xs text-surface-600-400">No tools</span>
						</div>
					</td>
					<td class="p-4">
						<div class="flex flex-col items-center justify-center gap-2">
							<TriangleAlert class="size-5 shrink-0 text-warning-500" />
							<span class="text-center text-xs text-surface-600-400">Basic inspector</span>
						</div>
					</td>
					<td class="bg-primary-500/5 p-4">
						<div class="flex flex-col items-center justify-center gap-2">
							<Check class="size-5 shrink-0 text-success-500" />
							<span class="text-center text-xs text-surface-600-400">Full debugger window</span>
						</div>
					</td>
				</tr>

				<!-- Row 3: Type Safety -->
				<tr class="border-b border-surface-500/20">
					<td class="p-4 font-medium">Type Safety</td>
					<td class="p-4">
						<div class="flex flex-col items-center justify-center gap-2">
							<Check class="size-5 shrink-0 text-success-500" />
							<span class="text-center text-xs text-surface-600-400">Compile-time</span>
						</div>
					</td>
					<td class="p-4">
						<div class="flex flex-col items-center justify-center gap-2">
							<X class="size-5 shrink-0 text-error-500" />
							<span class="text-center text-xs text-surface-600-400">Runtime only</span>
						</div>
					</td>
					<td class="bg-primary-500/5 p-4">
						<div class="flex flex-col items-center justify-center gap-2">
							<Check class="size-5 shrink-0 text-success-500" />
							<span class="text-center text-xs text-surface-600-400">Strongly-typed</span>
						</div>
					</td>
				</tr>

				<!-- Row 4: Cross-Scene Communication -->
				<tr class="border-b border-surface-500/20">
					<td class="p-4 font-medium">Cross-Scene Communication</td>
					<td class="p-4">
						<div class="flex flex-col items-center justify-center gap-2">
							<X class="size-5 shrink-0 text-error-500" />
							<span class="text-center text-xs text-surface-600-400">Breaks on scene load</span>
						</div>
					</td>
					<td class="p-4">
						<div class="flex flex-col items-center justify-center gap-2">
							<X class="size-5 shrink-0 text-error-500" />
							<span class="text-center text-xs text-surface-600-400">Scene-bound</span>
						</div>
					</td>
					<td class="bg-primary-500/5 p-4">
						<div class="flex flex-col items-center justify-center gap-2">
							<Check class="size-5 shrink-0 text-success-500" />
							<span class="text-center text-xs text-surface-600-400">Persistent channels</span>
						</div>
					</td>
				</tr>

				<!-- Row 5: Inspector Testing -->
				<tr class="border-b border-surface-500/20">
					<td class="p-4 font-medium">Raise from Inspector</td>
					<td class="p-4">
						<div class="flex flex-col items-center justify-center gap-2">
							<X class="size-5 shrink-0 text-error-500" />
							<span class="text-center text-xs text-surface-600-400">Not possible</span>
						</div>
					</td>
					<td class="p-4">
						<div class="flex flex-col items-center justify-center gap-2">
							<Check class="size-5 shrink-0 text-success-500" />
							<span class="text-center text-xs text-surface-600-400">Manual invoke</span>
						</div>
					</td>
					<td class="bg-primary-500/5 p-4">
						<div class="flex flex-col items-center justify-center gap-2">
							<Check class="size-5 shrink-0 text-success-500" />
							<span class="text-center text-xs text-surface-600-400">One-click testing</span>
						</div>
					</td>
				</tr>

				<!-- Row 6: Memory Safety -->
				<tr class="border-b border-surface-500/20">
					<td class="p-4 font-medium">Automatic Cleanup</td>
					<td class="p-4">
						<div class="flex flex-col items-center justify-center gap-2">
							<X class="size-5 shrink-0 text-error-500" />
							<span class="text-center text-xs text-surface-600-400">Manual unsubscribe</span>
						</div>
					</td>
					<td class="p-4">
						<div class="flex flex-col items-center justify-center gap-2">
							<TriangleAlert class="size-5 shrink-0 text-warning-500" />
							<span class="text-center text-xs text-surface-600-400">Partial</span>
						</div>
					</td>
					<td class="bg-primary-500/5 p-4">
						<div class="flex flex-col items-center justify-center gap-2">
							<Check class="size-5 shrink-0 text-success-500" />
							<span class="text-center text-xs text-surface-600-400">Weak references</span>
						</div>
					</td>
				</tr>

				<!-- Row 7: Advanced Features -->
				<tr class="border-b border-surface-500/20">
					<td class="p-4 font-medium">Priority, Filters, Throttling</td>
					<td class="p-4">
						<div class="flex flex-col items-center justify-center gap-2">
							<X class="size-5 shrink-0 text-error-500" />
							<span class="text-center text-xs text-surface-600-400">Manual implementation</span>
						</div>
					</td>
					<td class="p-4">
						<div class="flex flex-col items-center justify-center gap-2">
							<X class="size-5 shrink-0 text-error-500" />
							<span class="text-center text-xs text-surface-600-400">Not available</span>
						</div>
					</td>
					<td class="bg-primary-500/5 p-4">
						<div class="flex flex-col items-center justify-center gap-2">
							<Check class="size-5 shrink-0 text-success-500" />
							<span class="text-center text-xs text-surface-600-400">Built-in</span>
						</div>
					</td>
				</tr>

				<!-- Row 8: Recording & Playback -->
				<tr>
					<td class="p-4 font-medium">Recording & Playback</td>
					<td class="p-4">
						<div class="flex flex-col items-center justify-center gap-2">
							<X class="size-5 shrink-0 text-error-500" />
							<span class="text-center text-xs text-surface-600-400">Not available</span>
						</div>
					</td>
					<td class="p-4">
						<div class="flex flex-col items-center justify-center gap-2">
							<X class="size-5 shrink-0 text-error-500" />
							<span class="text-center text-xs text-surface-600-400">Not available</span>
						</div>
					</td>
					<td class="bg-primary-500/5 p-4">
						<div class="flex flex-col items-center justify-center gap-2">
							<Check class="size-5 shrink-0 text-success-500" />
							<span class="text-center text-xs text-surface-600-400">Full support</span>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>

	<!-- Mobile Cards -->
	<div class="space-y-8 lg:hidden">
		<!-- C# Events -->
		<div class="rounded-xl border border-surface-500/30 bg-surface-50-950 p-6">
			<h3 class="mb-4 text-center text-xl font-semibold">C# Events</h3>
			<ul class="space-y-3 text-sm">
				<li class="flex items-start gap-3">
					<X class="mt-0.5 size-5 shrink-0 text-error-500" />
					<div>
						<span class="font-medium">Zero Coupling:</span>
						<span class="text-surface-600-400"> Requires references</span>
					</div>
				</li>
				<li class="flex items-start gap-3">
					<X class="mt-0.5 size-5 shrink-0 text-error-500" />
					<div>
						<span class="font-medium">Visual Debugging:</span>
						<span class="text-surface-600-400"> No tools</span>
					</div>
				</li>
				<li class="flex items-start gap-3">
					<Check class="mt-0.5 size-5 shrink-0 text-success-500" />
					<div>
						<span class="font-medium">Type Safety:</span>
						<span class="text-surface-600-400"> Compile-time</span>
					</div>
				</li>
				<li class="flex items-start gap-3">
					<X class="mt-0.5 size-5 shrink-0 text-error-500" />
					<div>
						<span class="font-medium">Cross-Scene:</span>
						<span class="text-surface-600-400"> Breaks on scene load</span>
					</div>
				</li>
				<li class="flex items-start gap-3">
					<X class="mt-0.5 size-5 shrink-0 text-error-500" />
					<div>
						<span class="font-medium">Inspector Testing:</span>
						<span class="text-surface-600-400"> Not possible</span>
					</div>
				</li>
				<li class="flex items-start gap-3">
					<X class="mt-0.5 size-5 shrink-0 text-error-500" />
					<div>
						<span class="font-medium">Cleanup:</span>
						<span class="text-surface-600-400"> Manual unsubscribe</span>
					</div>
				</li>
				<li class="flex items-start gap-3">
					<X class="mt-0.5 size-5 shrink-0 text-error-500" />
					<div>
						<span class="font-medium">Advanced Features:</span>
						<span class="text-surface-600-400"> Manual implementation</span>
					</div>
				</li>
				<li class="flex items-start gap-3">
					<X class="mt-0.5 size-5 shrink-0 text-error-500" />
					<div>
						<span class="font-medium">Recording:</span>
						<span class="text-surface-600-400"> Not available</span>
					</div>
				</li>
			</ul>
		</div>

		<!-- UnityEvents -->
		<div class="rounded-xl border border-surface-500/30 bg-surface-50-950 p-6">
			<h3 class="mb-4 text-center text-xl font-semibold">UnityEvents</h3>
			<ul class="space-y-3 text-sm">
				<li class="flex items-start gap-3">
					<TriangleAlert class="mt-0.5 size-5 shrink-0 text-warning-500" />
					<div>
						<span class="font-medium">Zero Coupling:</span>
						<span class="text-surface-600-400"> Inspector only</span>
					</div>
				</li>
				<li class="flex items-start gap-3">
					<TriangleAlert class="mt-0.5 size-5 shrink-0 text-warning-500" />
					<div>
						<span class="font-medium">Visual Debugging:</span>
						<span class="text-surface-600-400"> Basic inspector</span>
					</div>
				</li>
				<li class="flex items-start gap-3">
					<X class="mt-0.5 size-5 shrink-0 text-error-500" />
					<div>
						<span class="font-medium">Type Safety:</span>
						<span class="text-surface-600-400"> Runtime only</span>
					</div>
				</li>
				<li class="flex items-start gap-3">
					<X class="mt-0.5 size-5 shrink-0 text-error-500" />
					<div>
						<span class="font-medium">Cross-Scene:</span>
						<span class="text-surface-600-400"> Scene-bound</span>
					</div>
				</li>
				<li class="flex items-start gap-3">
					<Check class="mt-0.5 size-5 shrink-0 text-success-500" />
					<div>
						<span class="font-medium">Inspector Testing:</span>
						<span class="text-surface-600-400"> Manual invoke</span>
					</div>
				</li>
				<li class="flex items-start gap-3">
					<TriangleAlert class="mt-0.5 size-5 shrink-0 text-warning-500" />
					<div>
						<span class="font-medium">Cleanup:</span>
						<span class="text-surface-600-400"> Partial</span>
					</div>
				</li>
				<li class="flex items-start gap-3">
					<X class="mt-0.5 size-5 shrink-0 text-error-500" />
					<div>
						<span class="font-medium">Advanced Features:</span>
						<span class="text-surface-600-400"> Not available</span>
					</div>
				</li>
				<li class="flex items-start gap-3">
					<X class="mt-0.5 size-5 shrink-0 text-error-500" />
					<div>
						<span class="font-medium">Recording:</span>
						<span class="text-surface-600-400"> Not available</span>
					</div>
				</li>
			</ul>
		</div>

		<!-- SignalKit -->
		<div
			class="rounded-xl border-2 border-primary-500/50 bg-linear-to-br from-primary-500/10 to-secondary-500/10 p-6"
		>
			<h3 class="mb-4 text-center text-xl font-semibold text-primary-400">SignalKit</h3>
			<ul class="space-y-3 text-sm">
				<li class="flex items-start gap-3">
					<Check class="mt-0.5 size-5 shrink-0 text-success-500" />
					<div>
						<span class="font-medium">Zero Coupling:</span>
						<span class="text-surface-600-400"> ScriptableObject channels</span>
					</div>
				</li>
				<li class="flex items-start gap-3">
					<Check class="mt-0.5 size-5 shrink-0 text-success-500" />
					<div>
						<span class="font-medium">Visual Debugging:</span>
						<span class="text-surface-600-400"> Full debugger window</span>
					</div>
				</li>
				<li class="flex items-start gap-3">
					<Check class="mt-0.5 size-5 shrink-0 text-success-500" />
					<div>
						<span class="font-medium">Type Safety:</span>
						<span class="text-surface-600-400"> Strongly-typed</span>
					</div>
				</li>
				<li class="flex items-start gap-3">
					<Check class="mt-0.5 size-5 shrink-0 text-success-500" />
					<div>
						<span class="font-medium">Cross-Scene:</span>
						<span class="text-surface-600-400"> Persistent channels</span>
					</div>
				</li>
				<li class="flex items-start gap-3">
					<Check class="mt-0.5 size-5 shrink-0 text-success-500" />
					<div>
						<span class="font-medium">Inspector Testing:</span>
						<span class="text-surface-600-400"> One-click testing</span>
					</div>
				</li>
				<li class="flex items-start gap-3">
					<Check class="mt-0.5 size-5 shrink-0 text-success-500" />
					<div>
						<span class="font-medium">Cleanup:</span>
						<span class="text-surface-600-400"> Weak references</span>
					</div>
				</li>
				<li class="flex items-start gap-3">
					<Check class="mt-0.5 size-5 shrink-0 text-success-500" />
					<div>
						<span class="font-medium">Advanced Features:</span>
						<span class="text-surface-600-400"> Built-in</span>
					</div>
				</li>
				<li class="flex items-start gap-3">
					<Check class="mt-0.5 size-5 shrink-0 text-success-500" />
					<div>
						<span class="font-medium">Recording:</span>
						<span class="text-surface-600-400"> Full support</span>
					</div>
				</li>
			</ul>
		</div>
	</div>

	<!-- Bottom Statement -->
	<div class="mt-12 text-center">
		<p class="mx-auto max-w-3xl text-lg text-surface-600-400">
			SignalKit combines the type safety of C# Events with the flexibility of UnityEvents, while
			adding powerful features you won't find anywhere else.
		</p>
	</div>
</section>
