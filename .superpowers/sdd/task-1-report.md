# Task 1 Report: Backup current live Droid config

## Objective

Create point-in-time backups of the current live Droid configuration files so they can be used for rollback during the OpenCode BYOK models and MCP servers migration.

## Files processed

| Source file | Backup file |
|-------------|-------------|
| `~/.factory/settings.json` | `~/.factory/settings.json.bak.2026-07-06` |
| `~/.factory/mcp.json` | `~/.factory/mcp.json.bak.2026-07-06` |

## Procedure

1. Read `~/.factory/settings.json` — confirmed present and valid JSON (724 lines).
2. Read `~/.factory/mcp.json` — confirmed present and valid JSON (9 lines).
3. Copied `~/.factory/settings.json` to `~/.factory/settings.json.bak.2026-07-06`.
4. Copied `~/.factory/mcp.json` to `~/.factory/mcp.json.bak.2026-07-06`.
5. Verified both backup files exist and are non-empty.
6. Verified both backup files are valid JSON.

## Verification

```bash
ls -l ~/.factory/settings.json.bak.2026-07-06 ~/.factory/mcp.json.bak.2026-07-06
```

Output:

```text
-rw-------  1 tao  staff    140 Jul  6 13:33 /Users/tao/.factory/mcp.json.bak.2026-07-06
-rw-------  1 tao  staff  21218 Jul  6 13:33 /Users/tao/.factory/settings.json.bak.2026-07-06
```

JSON validity check:

```bash
python3 -c "import json; json.load(open('/Users/tao/.factory/settings.json.bak.2026-07-06')); json.load(open('/Users/tao/.factory/mcp.json.bak.2026-07-06')); print('Both backups are valid JSON')"
```

Output:

```text
Both backups are valid JSON
```

Both backups exist and have non-zero size (`settings.json` backup: 21,218 bytes; `mcp.json` backup: 140 bytes).

## Notes / concerns

- The backup files contain live API keys and remain in `~/.factory/`, consistent with the source files. They were not added to the chezmoi repository.
- No changes were made to the live `settings.json` or `mcp.json` files.
- The report file itself contains no secrets.
