# jiramcp

A minimal Jira MCP server. Three tools, one binary.

## Design

LLMs work best with fewer, well-composed tools. Instead of 72 specialized endpoints, jiramcp offers three:

| Tool | Purpose |
|---|---|
| `jira_read` | Fetch issues by key, search by JQL, list projects/boards/sprints |
| `jira_write` | Create, update, delete, transition, comment -- with `dry_run` support |
| `jira_schema` | Discover fields, transitions, and allowed values |

They compose naturally: schema to discover, read to find, write to change.

### Compared to [mcp-atlassian](https://github.com/sooperset/mcp-atlassian)

| | jiramcp | mcp-atlassian |
|---|---|---|
| Tools | 3 | 72 |
| Runtime | Go binary | Python |
| Scope | Jira | Jira + Confluence |
| Auth | API token | API token, OAuth 2.0, PAT |

mcp-atlassian covers more ground. jiramcp is deliberately smaller -- less context for the model to parse, fewer tools to choose from, simpler to operate.

## Quick start

### API token

1. Go to [API token management](https://id.atlassian.com/manage-profile/security/api-tokens)
2. Click "Create API token"
3. Give it a label, click "Create"
4. Copy the token immediately -- you can't see it again

### Claude Code

```bash
claude mcp add-json jira \
'{"command":"go","args":["run","github.com/mmatczuk/jiramcp@latest"],"env":{\
"JIRA_URL":"https://yourcompany.atlassian.net",\
"JIRA_EMAIL":"you@company.com",\
"JIRA_API_TOKEN":"your-api-token"\
}}'
```

## License

MIT
