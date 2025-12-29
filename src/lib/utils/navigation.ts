import type { NavLink } from '$lib/types/navigation';

export interface PageNavigation {
	previous: NavLink | null;
	next: NavLink | null;
}

/**
 * Flattens the navigation groups into a single ordered array
 */
export function flattenNavigation(navGroups: Record<string, NavLink[]>): NavLink[] {
	return Object.values(navGroups).flat();
}

/**
 * Finds the previous and next pages for the current path
 */
export function getPageNavigation(
	currentPath: string,
	navGroups: Record<string, NavLink[]>
): PageNavigation {
	const allPages = flattenNavigation(navGroups);
	const currentIndex = allPages.findIndex((page) => page.href === currentPath);

	if (currentIndex === -1) {
		return { previous: null, next: null };
	}

	return {
		previous: currentIndex > 0 ? allPages[currentIndex - 1] : null,
		next: currentIndex < allPages.length - 1 ? allPages[currentIndex + 1] : null
	};
}
