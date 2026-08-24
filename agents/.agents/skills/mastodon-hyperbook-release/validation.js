#!/usr/bin/env node

/**
 * Validates Mastodon post character length.
 * Usage: node check-post-length.js "Your post text content"
 */

const input = process.argv.slice(2).join(" ");

if (!input.trim()) {
  console.error("Error: No post text provided.");
  process.exit(1);
}

// Mastodon counts any web URL (http:// or https://) as exactly 23 characters
const URL_REGEX = /https?:\/\/[^\s]+/g;

// Replace all URLs with a dummy 23-character string to simulate Mastodon's counting rule
const mastodonFormattedText = input.replace(URL_REGEX, "https://t.co/123456789012");
const mastodonCharCount = mastodonFormattedText.length;
const rawCharCount = input.length;
const MAX_LIMIT = 500;

console.log(`Raw Character Count: ${rawCharCount}`);
console.log(`Mastodon Weighted Count: ${mastodonCharCount} / ${MAX_LIMIT}`);

if (mastodonCharCount > MAX_LIMIT) {
  console.error(`❌ Over limit by ${mastodonCharCount - MAX_LIMIT} characters!`);
  process.exit(1);
} else {
  console.log(`✅ Valid post length (${MAX_LIMIT - mastodonCharCount} characters remaining).`);
  process.exit(0);
}
