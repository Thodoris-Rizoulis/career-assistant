#!/usr/bin/env bash
# Collect public GitHub profile data for a user, as plain text for review.
#
# Usage: github_summary.sh <github-username> [max-repos-to-check-readme]
#
# Needs: gh (GitHub CLI), logged in with `gh auth login`.
# Only reads PUBLIC information. Makes no changes.

set -uo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 <github-username> [max-readme-checks]" >&2
  exit 1
fi

LOGIN="$1"
MAX_README_CHECKS="${2:-30}"

if ! command -v gh >/dev/null 2>&1; then
  echo "ERROR: GitHub CLI (gh) is not installed. See https://cli.github.com" >&2
  exit 2
fi
if ! gh auth status >/dev/null 2>&1; then
  echo "ERROR: gh is not logged in. Run: gh auth login" >&2
  exit 2
fi

echo "# GitHub summary for $LOGIN"
echo "Collected: $(date +%Y-%m-%d)"
echo

echo "## Profile"
gh api "users/$LOGIN" --jq '
  "Name: \(.name // "-")",
  "Bio: \(.bio // "-")",
  "Location: \(.location // "-")",
  "Company: \(.company // "-")",
  "Website: \(.blog // "-")",
  "Public repos: \(.public_repos)",
  "Followers: \(.followers)",
  "Account created: \(.created_at[0:10])"' || echo "(could not read profile)"
echo

echo "## Profile README (repo $LOGIN/$LOGIN)"
if gh api "repos/$LOGIN/$LOGIN/readme" --jq '.name' >/dev/null 2>&1; then
  echo "Exists."
else
  echo "Missing."
fi
echo

echo "## Pinned repositories"
gh api graphql -F login="$LOGIN" -f query='
  query($login: String!) {
    user(login: $login) {
      pinnedItems(first: 6, types: REPOSITORY) {
        nodes { ... on Repository { name description } }
      }
    }
  }' --jq '.data.user.pinnedItems.nodes[] | "- \(.name): \(.description // "(no description)")"' 2>/dev/null \
  || echo "(could not read pinned repos)"
echo

echo "## Contributions in the last year"
gh api graphql -F login="$LOGIN" -f query='
  query($login: String!) {
    user(login: $login) {
      contributionsCollection { contributionCalendar { totalContributions } }
    }
  }' --jq '"Total: \(.data.user.contributionsCollection.contributionCalendar.totalContributions)"' 2>/dev/null \
  || echo "(could not read contributions)"
echo

echo "## Public repositories (own, not forks), most recently pushed first"
echo "Format: name | language | stars | forks | last push | archived | homepage | topics | description"
REPOS="$(gh repo list "$LOGIN" --source --visibility public --limit 200 \
  --json name,description,primaryLanguage,stargazerCount,forkCount,pushedAt,isArchived,homepageUrl,repositoryTopics \
  --jq 'sort_by(.pushedAt) | reverse | .[] |
    "\(.name) | \(.primaryLanguage.name // "-") | \(.stargazerCount) | \(.forkCount) | \(.pushedAt[0:10]) | \(.isArchived) | \(.homepageUrl // "-") | \([(.repositoryTopics // [])[] | .name] | join(",")) | \(.description // "(no description)")"' 2>/dev/null)"

if [ -z "$REPOS" ]; then
  echo "(no public source repositories found)"
else
  echo "$REPOS"
fi
echo

echo "## Language spread (own public repos, by primary language)"
gh repo list "$LOGIN" --source --visibility public --limit 200 --json primaryLanguage \
  --jq '[.[] | .primaryLanguage.name // "None"] | group_by(.) | map({lang: .[0], n: length}) | sort_by(-.n) | .[] | "- \(.lang): \(.n)"' 2>/dev/null \
  || echo "(could not compute)"
echo

echo "## README check (first $MAX_README_CHECKS repos above)"
COUNT=0
while IFS='|' read -r NAME _; do
  NAME="$(echo "$NAME" | xargs)"
  [ -z "$NAME" ] && continue
  COUNT=$((COUNT + 1))
  [ "$COUNT" -gt "$MAX_README_CHECKS" ] && break
  SIZE="$(gh api "repos/$LOGIN/$NAME/readme" --jq '.size' 2>/dev/null || true)"
  if [ -z "$SIZE" ]; then
    echo "- $NAME: NO README"
  elif [ "$SIZE" -lt 500 ]; then
    echo "- $NAME: short README ($SIZE bytes)"
  else
    echo "- $NAME: README ok ($SIZE bytes)"
  fi
done <<< "$REPOS"
