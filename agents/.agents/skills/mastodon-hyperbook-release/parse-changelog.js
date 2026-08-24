#!/usr/node
const fs = require("fs");
const path = require("path");

const filePath = process.argv[2] || "website/en/book/changelog.md";
const targetVersion = process.argv[3]; // Optional: e.g., "v0.100.0" or "0.100.0"

if (!fs.existsSync(filePath)) {
  console.error(`Error: File not found at ${filePath}`);
  process.exit(1);
}

const content = fs.readFileSync(filePath, "utf-8");

// Split by release headers (## v...)
const sections = content.split(/(?=\n## v)/);

let resultSection = "";

if (targetVersion) {
  const normalized = targetVersion.startsWith("v") ? targetVersion : `v${targetVersion}`;
  resultSection = sections.find(s => s.trim().startsWith(`## ${normalized}`));
  
  if (!resultSection) {
    console.error(`Error: Version ${targetVersion} not found in changelog.`);
    process.exit(1);
  }
} else {
  // Find first section that isn't vNEXT
  resultSection = sections.find(s => {
    const trimmed = s.trim();
    return trimmed.startsWith("## v") && !trimmed.startsWith("## vNEXT");
  });
}

if (!resultSection) {
  console.error("Error: No valid release section found.");
  process.exit(1);
}

console.log(resultSection.trim());
