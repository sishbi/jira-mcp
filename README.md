# JIRA MCP

Give your AI assistant full JIRA access without burning half its context window on tool selection.

Most JIRA MCPs expose too many tools. Every time the model picks one, it spends tokens deciding between `jira_get_issue`, `jira_fetch_issue`, `jira_issue_get`...

`jiramcp` has three:

| Tool | What it does |
|---|---|
| `jira_read` | Fetch issues by key, search by JQL, list projects/boards/sprints |
| `jira_write` | Create, update, delete, transition, comment — with `dry_run` support |
| `jira_schema` | Discover fields, transitions, and allowed values |

Less tool surface area means more of the context window goes to your actual work. The model makes fewer wrong choices, calls fewer redundant tools, and gets to the answer faster. The three tools compose naturally: schema to discover, read to find, write to change.

Your API token never leaves your machine. `jiramcp` runs as a local process over stdio — no server to host, no proxy in the middle, no credentials sent anywhere except directly to Atlassian.

## Quick start

**Prerequisites:** Go 1.21+ installed, a JIRA Cloud account.

### 1. Get an API token

1. Go to [API token management](https://id.atlassian.com/manage-profile/security/api-tokens)
2. Click "Create API token"
3. Give it a label, click "Create"
4. Copy the token immediately — you can't see it again

### 2. Add to Claude Code

```bash
claude mcp add-json jira \
'{"command":"go","args":["run","github.com/mmatczuk/jiramcp@latest"],"env":{\
"JIRA_URL":"https://yourcompany.atlassian.net",\
"JIRA_EMAIL":"you@company.com",\
"JIRA_API_TOKEN":"your-api-token"\
}}'
```

### 3. Verify it works

Ask Claude: *"List my JIRA projects"* — if you see your projects, you're good.

### Other MCP clients

Use the same Go binary and env vars. The server speaks standard MCP over stdio.

## Compared to [mcp-atlassian](https://github.com/sooperset/mcp-atlassian)

| | jiramcp | mcp-atlassian |
|---|---|---|
| Tools | 3 | 72 |
| Runtime | Go binary | Python |
| Scope | Jira | Jira + Confluence |
| Auth | API token | API token, OAuth 2.0, PAT |
| Transport | stdio (local only) | stdio, SSE |

mcp-atlassian is the right choice if you need Confluence or OAuth. jiramcp is for people who want Jira to just work, with minimal overhead on the model.

## License

MIT
