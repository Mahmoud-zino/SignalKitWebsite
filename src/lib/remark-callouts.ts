import { visit } from 'unist-util-visit';
import type { Root, Blockquote, Paragraph, Text, PhrasingContent, LinkReference } from 'mdast';
import type { Plugin } from 'unified';

// Define the callout types
type CalloutType = 'note' | 'tip' | 'important' | 'warning' | 'caution';

// Lucide icon SVG paths
const iconPaths: Record<CalloutType, string> = {
	note: 'M12 16v-4m0-4h.01M22 12c0 5.523-4.477 10-10 10S2 17.523 2 12 6.477 2 12 2s10 4.477 10 10z',
	tip: 'M15 14c.2-1 .7-1.7 1.5-2.5 1-.9 1.5-2.2 1.5-3.5A6 6 0 0 0 6 8c0 1 .2 2.2 1.5 3.5.7.7 1.3 1.5 1.5 2.5M9 18h6M10 22h4',
	important:
		'M12 9v4m0 4h.01M10.29 3.86 1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z',
	warning:
		'M12 9v4m0 4h.01M10.29 3.86 1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z',
	caution: 'M12 8v4m0 4h.01M7.86 2h8.28L22 7.86v8.28L16.14 22H7.86L2 16.14V7.86z'
};

// Type guard to check if a value is a valid callout type
function isCalloutType(value: string): value is CalloutType {
	return ['note', 'tip', 'important', 'warning', 'caution'].includes(value);
}

// Type for HTML node (not in mdast types, but used by remark-rehype)
interface HtmlNode {
	type: 'html';
	value: string;
}

// Extended types with data property for hProperties
interface BlockquoteWithData extends Blockquote {
	data?: {
		hProperties?: {
			className?: string[];
		};
	};
}

interface ParagraphWithData extends Paragraph {
	data?: {
		hProperties?: {
			className?: string[];
		};
	};
}

// Type guard to check if a node is a linkReference
function isLinkReference(node: PhrasingContent): node is LinkReference {
	return node.type === 'linkReference';
}

// Type guard to check if a node is a Text node
function isTextNode(node: PhrasingContent): node is Text {
	return node.type === 'text';
}

/**
 * Custom remark plugin to transform GitHub-style callouts
 * Transforms: > [!NOTE] into styled blockquotes with icons
 */
export const remarkCallouts: Plugin<[], Root> = function () {
	return (tree: Root) => {
		visit(tree, 'blockquote', (node: Blockquote) => {
			// Check if the first child is a paragraph
			if (!node.children || node.children.length === 0) return;

			const firstChild = node.children[0];
			if (firstChild.type !== 'paragraph') return;

			// Check if the paragraph starts with [!TYPE] (parsed as linkReference)
			const firstNode = firstChild.children[0];
			if (!firstNode) return;

			// Check for linkReference node (markdown parses [!NOTE] as a link reference)
			if (isLinkReference(firstNode)) {
				const identifier = firstNode.identifier || '';
				const match = identifier.match(/^!(note|tip|important|warning|caution)$/i);

				if (match) {
					const typeMatch = match[1].toLowerCase();
					if (!isCalloutType(typeMatch)) return;

					const type: CalloutType = typeMatch;

					// Remove the linkReference node from the paragraph
					firstChild.children.shift();

					// Clean up any leading newline/whitespace in the remaining text
					if (firstChild.children.length > 0 && isTextNode(firstChild.children[0])) {
						firstChild.children[0].value = firstChild.children[0].value.replace(/^\s+/, '');
					}

					// If the first paragraph is now empty, remove it
					if (firstChild.children.length === 0) {
						node.children.shift();
					}

					// Add custom properties to the blockquote node
					const blockquoteWithData = node as BlockquoteWithData;
					blockquoteWithData.data = blockquoteWithData.data || {};
					blockquoteWithData.data.hProperties = blockquoteWithData.data.hProperties || {};
					blockquoteWithData.data.hProperties.className = ['callout', `callout-${type}`];

					// Create SVG icon node
					const svgIcon: HtmlNode = {
						type: 'html',
						value: `<svg class="callout-icon" xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="${iconPaths[type]}"/></svg>`
					};

					// Add a title paragraph at the beginning with icon
					const titleNode: ParagraphWithData = {
						type: 'paragraph',
						data: {
							hProperties: {
								className: ['callout-title']
							}
						},
						children: [
							svgIcon as unknown as PhrasingContent,
							{
								type: 'text',
								value: type.charAt(0).toUpperCase() + type.slice(1)
							}
						]
					};

					// Insert title as first child
					node.children.unshift(titleNode);
				}
			}
		});
	};
};
