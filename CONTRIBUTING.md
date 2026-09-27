# Contributing to macos-webview

Thank you for your interest in contributing to macos-webview! Every contribution helps, whether it's a bug report, a fix or a documentation update.

Please keep all communication respectful and constructive, in issues, discussions, pull requests and reviews alike. Be kind to others, assume good intent, and critique ideas and code, never people. Harassment, insults and discriminatory language are not tolerated, and the maintainers may remove comments or block users who don't follow these rules.

- [Development Guide](#development-guide)

- [AI Tools Policy](#ai-tools-policy)

## Development Guide

> [!NOTE]
> The project is at an early stage and this guide is still incomplete. It will grow as the framework takes shape.

### Prerequisites

- macOS with Xcode installed
- [Node.js](https://nodejs.org/) 24 or newer (the exact version is pinned in [`.node-version`](.node-version))
- [pnpm](https://pnpm.io/) 11 or newer
- [Homebrew](https://brew.sh/) for the native toolchain

### Setup

1. Fork and clone the repository.
2. Install the native toolchain (`swift-format` and `swiftlint`):

   ```sh
   brew bundle
   ```

3. Install the dependencies. This also installs the git hooks:

   ```sh
   pnpm install
   ```

### Useful scripts

| Command                                         | Description                                 |
| ----------------------------------------------- | ------------------------------------------- |
| `pnpm run format:check` / `pnpm run format:fix` | Check or fix formatting with oxfmt          |
| `pnpm run lint:check` / `pnpm run lint:fix`     | Lint JS and TS files with oxlint            |
| `pnpm run typecheck`                            | Typecheck all packages                      |
| `pnpm run knip:check` / `pnpm run knip:fix`     | Find unused files, exports and dependencies |

### Git conventions

- **Branch names:** `<type>/<kebab-case-description>`, for example `feat/add-fs-bindings`.
- **Commit messages:** a single line, `<type>: <subject>`, at most 100 characters, with no trailing period. For example `feat: add file system bindings`.
- Allowed types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`.

The git hooks check these rules and, before each commit, format and lint the staged files and run the typecheck, knip and sherif. Don't skip the hooks; if one fails, fix the cause.

### Dependencies

Open an issue or ask in your pull request before adding, removing or upgrading a dependency. Prefer the standard library, platform APIs (Foundation, WebKit) or an existing dependency where possible.

## AI Tools Policy

Using AI tools to help write code is fine, with a few rules:

- **You are responsible for your contribution.** Understand and review every change you submit, as if you had written it yourself.
- **Test your changes manually.** Build and run the app and confirm your change works before opening a pull request. Passing checks alone are not enough.
- **Communicate in your own words.** Don't use AI to write responses to issues, discussions or review comments.
