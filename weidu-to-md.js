#!/usr/bin/env node

const fs = require("fs");
const path = require("path");

const inputFile = process.argv[2] || "WeiDU.log";
const outputFile = process.argv[3] || "WeiDU.md";

if (!fs.existsSync(inputFile)) {
  console.error(`Error: Input file "${inputFile}" not found.`);
  console.error(`Usage: node weidu-to-md.js [input.log] [output.md]`);
  process.exit(1);
}

const raw = fs.readFileSync(inputFile, "utf8");
const lines = raw.split("\n");

// Map of mod name -> { version: string|null, components: string[] }
const mods = new Map();
const modOrder = [];

for (const line of lines) {
  const trimmed = line.trim();

  // Skip comments and empty lines
  if (!trimmed || trimmed.startsWith("//")) continue;

  // Match lines like:
  // ~MOD_NAME/MOD_NAME.TP2~ #0 #3 // Component Name: Version
  // or ~SETUP-MOD.TP2~ #0 #0 // Component Name: Version
  const match = trimmed.match(/^~([^/\\~]+)(?:[/\\][^~]*)?\s*~\s*#\d+\s*#\d+\s*\/\/\s*(.+)$/);
  if (!match) continue;

  // Derive a clean mod name from the path segment
  const rawModName = match[1]
    .replace(/^SETUP-/, "")       // strip SETUP- prefix
    .replace(/_/g, " ")           // underscores -> spaces
    .replace(/\b\w/g, (c) => c.toUpperCase()); // Title Case

  // Strip leading !!! markers used by SCS/CDTweaks
  const stripped = match[2].trim().replace(/^!+\s*/, "");

  // Extract trailing version e.g. ": v18" or ": 35.21" or ": v0.11.0-alpha"
  const versionMatch = stripped.match(/^(.*?):\s*(v?[\d.]+(?:-[\w.]+)?)$/);
  const component = versionMatch ? versionMatch[1].trim() : stripped;
  const version   = versionMatch ? versionMatch[2] : null;

  if (!mods.has(rawModName)) {
    mods.set(rawModName, { version: null, components: [] });
    modOrder.push(rawModName);
  }

  const mod = mods.get(rawModName);
  // Use the first version we encounter for the whole mod
  if (version && !mod.version) mod.version = version;
  mod.components.push(component);
}

// Build markdown
const out = [];
out.push("# WeiDU Mod List\n");
out.push(`_Generated from \`${path.basename(inputFile)}\` — ${modOrder.length} mods installed_\n`);
out.push("---\n");

for (const modName of modOrder) {
  const { version, components } = mods.get(modName);
  const heading = version ? `## ${modName} ${version}` : `## ${modName}`;
  out.push(`${heading}\n`);
  for (const comp of components) {
    out.push(`- ${comp}`);
  }
  out.push(""); // blank line between mods
}

fs.writeFileSync(outputFile, out.join("\n"), "utf8");
console.log(`Done! Wrote ${modOrder.length} mods to "${outputFile}"`);