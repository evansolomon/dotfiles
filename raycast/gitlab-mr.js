#!/usr/bin/env node

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Open GitLab MR
// @raycast.mode compact

// Optional parameters:
// @raycast.icon 🧪
// @raycast.argument1 { "type": "text", "placeholder": "repo!mr_id" }

// Documentation:
// @raycast.description Opens a GitLab merge request from a short form string
// @raycast.author YourName

import { exec } from "child_process";

// Get the input string from Raycast arguments
const input = process.argv.slice(2)[0];

// Parse the input string (format: project/repo!mrID)
function parseGitLabString(input) {
  const regex = /^(.+?)!(\d+)$/;
  const match = input.match(regex);
  
  if (!match) {
    console.error("Invalid format. Use 'project/repo!mrID'");
    return null;
  }
  
  const [, projectPath, mrId] = match;
  return { projectPath, mrId };
}

// Convert to GitLab URL
function generateGitLabURL(parsed) {
  if (!parsed) return null;
  
  const { projectPath, mrId } = parsed;
  // Replace the ! with /-/merge_requests/
  return `https://gitlab.com/${projectPath}/-/merge_requests/${mrId}`;
}

// Main function
function main() {
  const parsed = parseGitLabString(input);
  const url = generateGitLabURL(parsed);
  
  if (!url) {
    console.error("Could not generate URL");
    process.exit(1);
  }
  
  // Open the URL in the default browser
  exec(`open "${url}"`, (error) => {
    if (error) {
      console.error(`Error opening URL: ${error.message}`);
      process.exit(1);
    }
    process.exit(0);
  });
}

main();
