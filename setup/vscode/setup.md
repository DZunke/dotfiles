# Setup VSCode
# Setup VSCode

This VSCode setup avoids using the built-in synchronization. It documents a reproducible, sync-free way to configure Visual Studio Code when using the Remote - WSL experience. The file contains:

- A curated extensions list and an install script.
- Copy-pasteable `settings.json` tuned for WSL.
- A small `keybindings.json` snippet.
- Workspace recommendations and maintenance notes.

## VSCode on Windows

- Install VS Code on Windows (example using winget):

```bash
winget install Microsoft.VisualStudioCode
```

- After first start, click the lower-left green indicator and choose "Remote-WSL: New Window" or "Connect to WSL" to open a WSL remote window.
- Work inside a WSL remote window for best performance. When you open a WSL window the `code` CLI will be available inside that WSL environment.

## Principle

Keep configuration in this repository so you can version and update it independently of VS Code's cloud sync. The steps below assume you open VS Code in a WSL remote window and run commands from a terminal inside that WSL window.

## Setup Extensions

As we are within a WSL environment, some extensions, such as themes, must run on the Windows host while others run in the opened WSL window. VS Code's extension management allows installing extensions on the Windows host and then installing supported extensions in WSL with a single click.

To set up all extensions:

 - Execute the `setup/vscode/bin/install-vscode-extension.ps1` script in a PowerShell window on the Windows host.
 - Open a VS Code instance inside WSL.
 - Open the Extensions view.
 - In the "WSL: UBUNTU - INSTALLED" dropdown, click the small cloud icon labeled "Install Local Extensions".
 - All locally runnable extensions should then be installed into the WSL environment.

### Selected Extensions Description

| Extension                              | Category     | Short description                                                    |
| -------------------------------------- | ------------ | -------------------------------------------------------------------- |
| adpyke.codesnap                        | Editor       | Allows creating fancy screenshots of code.                           |
| bierner.markdown-preview-github-styles | Markdown     | GitHub-flavored CSS for the built-in Markdown preview.               |
| bmewburn.vscode-intelephense-client    | PHP          | Fast PHP language server with IntelliSense and indexing.             |
| codezombiech.gitignore                 | Git          | Snippets and templates for .gitignore files.                         |
| docker.docker                          | Container    | Docker explorer, build and run support.                              |
| dracula-theme.theme-dracula            | Editor       | A popular dark theme with vibrant colors.                            |
| editorconfig.editorconfig              | Editor       | EditorConfig support to enforce consistent coding styles.            |
| github.copilot                         | AI assistant | AI code completion powered by GitHub Copilot.                        |
| github.copilot-chat                    | AI assistant | Chat interface for GitHub Copilot inside VS Code.                    |
| github.vscode-github-actions           | GitHub       | Workflow editing and syntax support for GitHub Actions.              |
| github.vscode-pull-request-github      | GitHub       | Pull request and code review support inside VS Code.                 |
| gruntfuggly.todo-tree                  | Editor       | Adds a widget with an overview of TODOs freom the project.           |
| hediet.vscode-drawio                   | Editor       | Support for `.drawio` whiteboards.                                   |
| humao.rest-client                      | Editor       | REST Client with support for `.http` files.                          |
| k--kato.intellij-idea-keybindings      | Editor       | Keybindings inspired by JetBrains IDEs such as PhpStorm.             |
| mehedidracula.php-namespace-resolver   | PHP          | Assist with refactoring and adding PHP namespaces and imports.       |
| mblode.twig-language-2                 | Templating   | Syntax highlighting and basic support for Twig templates.            |
| mikestead.dotenv                       | Editor       | Support for Dotenv file syntax highlighting.                         |
| ms-vscode.makefile-tools               | Build        | Makefile language support and build task integration.                |
| ms-vscode.vscode-copilot-vision        | AI assistant | Visual context for Copilot, image-to-code assistance.                |
| ms-vscode.vscode-speech                | AI assistant | Audio context for Copilot; use voice to interact with the assistant. |
| neilbrayfield.php-docblocker           | PHP          | Helpers for generating PHP DocBlocks.                                |
| oderwat.indent-rainbow                 | Editor       | Colorize indentation levels for easier code navigation.              |
| pomdtr.excalidraw-editor               | Editor       | Support for editing `.excalidraw` whiteboards.                       |
| serhatkaya.twig-formatter              | Templating   | Formatter for Twig files.                                            |
| vscode-icons-team.vscode-icons         | Editor       | Icon pack for the file explorer.                                     |
| yzhang.markdown-all-in-one             | Markdown     | All-In-One-Package for Markdown.                                     |


## User Configuration

As with the extensions, settings for the VS Code environment are split between the host system and the remote (WSL) system. This requires setting up two different configurations. First, update the Windows host settings.

<details>
<summary>> Preferences: Open User Settings (JSON)</summary>

```json
{
	"workbench.colorTheme": "Dracula Theme",
	"files.autoSave": "afterDelay",
	"workbench.iconTheme": "vscode-icons",
	"workbench.tree.indent": 12,
	"workbench.tips.enabled": false,
	"workbench.view.alwaysShowHeaderActions": true,
	"workbench.editor.decorations.badges": false,
	"workbench.editor.pinnedTabsOnSeparateRow": true,
	"explorer.autoRevealExclude": {
		"**/vendor": true
	},
	"zenMode.hideActivityBar": false,
	"telemetry.editStats.enabled": false,
    "telemetry.feedback.enabled": false,
	"codesnap.transparentBackground": true,
	"github.copilot.chat.commitMessageGeneration.instructions": [
        {
            "text": "Use conventional commit message format."
        }
    ],

	"docker.extension.enableComposeLanguageServer": true,
	"git.blame.editorDecoration.enabled": true,

  	"chat.agent.maxRequests": 250,
	"github.copilot.enable": {"*": true},
	"github.copilot.chat.setupTests.enabled": false,
	"github.copilot.nextEditSuggestions.enabled": true,
	"github.copilot.selectedCompletionModel": "gpt-4o-copilot",
	"github.copilot.chat.codesearch.enabled": true,
	"chat.mcp.autostart": "newAndOutdated",

	"chat.tools.terminal.autoApprove": {
			"composer": true,
			"curl": true,
			"docker compose": true,
			"make": true,
			"vendor/bin/rector": true,
			"vendor/bin/phpcs": true,
			"vendor/bin/deptrac": true
	},

	"[markdown]": {
		"editor.defaultFormatter": "yzhang.markdown-all-in-one"
	},
}
```

</details>

And then there has to be a patch to the WSL side of the settings.

<details>
<summary>> Preferences: Open Remote Settings (JSON) (WSL: XXX)</summary>

```json
{
    "github.copilot.chat.codesearch.enabled": true,
    "terminal.integrated.profiles.linux": {
        "bash": {
            "path": "bash",
            "args": ["-c", "source ~/.bashrc; exec bash"]
        },
    },
    "terminal.integrated.defaultProfile.linux": "bash"
}
```

</details>

Done. The default environment is setup with a basic set of extensions and settings.

## Copilot

## MCP Server

With VS Code running in WSL open `> MCP: Open Remote User Configuration`. When NVM installation and MCP configuration were in the same session it is needed to restart the WSL and Visual Studio because otherwise there will be errors with not finding `npx`, so Visual Studio must be forced to reload it's own internal shell session.

MCP Servers not required can be removed, for example the Github MCP server brings a lot of tools that will then fastly make the maximum of 128 tools full, so every chat session would take longer because of AI utilizing AI to find out which tools could fit the request.

Long-Term recommendation, when having a lot of MCP Servers, is to have specialized chat modes configured in which one can configure the tools to utilize, even this can get very long and switching the chat mode.

<details>
<summary>> MCP: Open Remote User Configuration</summary>

```json
{
  "servers": {
    "playwright": {
      "type": "stdio",
      "command": "npx",
      "args": [
        "@playwright/mcp@latest",
        "--ignore-https-errors"
      ]
    },
    "context7": {
      "type": "stdio",
      "command": "npx",
      "args": [
        "-y",
        "@upstash/context7-mcp"
      ]
    },
    "git-mcp-server": {
      "command": "npx",
      "args": [
        "@cyanheads/git-mcp-server"
      ],
      "env": {
        "MCP_LOG_LEVEL": "info",
        "GIT_SIGN_COMMITS": "true"
      }
    },
	"notion": {
		"command": "npx",
		"args": [
			"-y",
			"mcp-remote",
			"https://mcp.notion.com/mcp"
		]
	},
	"atlassian": {
		"command": "npx",
		"args": ["-y", "mcp-remote", "https://mcp.atlassian.com/v1/sse"]
	},
	"github": {
		"type": "http",
		"url": "https://api.githubcopilot.com/mcp/"
	}
  }
}

</details>

## Instructions & ChatModes

All Copiloit related files are living within the Windows environment.
As such you can C&P the `user` subdirectory of this file directly to
`%APPDATA%\Code\User` in the windows explorer.

