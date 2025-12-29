import type { BookOpen } from 'lucide-svelte';

/**
 * Type representing a Lucide icon component
 */
export type IconComponent = typeof BookOpen;

/**
 * Navigation link item with label, href, and icon
 */
export interface NavLink {
	label: string;
	href: string;
	icon: IconComponent;
}
