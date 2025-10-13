#!/usr/bin/env pwsh
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# Resolve the 'code' CLI
$codeCmd = (Get-Command code -ErrorAction SilentlyContinue) `
       -or (Get-Command code.cmd -ErrorAction SilentlyContinue) `
       -or (Get-Command code.exe -ErrorAction SilentlyContinue)

if (-not $codeCmd) {
    Write-Error "VS Code 'code' CLI not found in PATH. Ensure the VS Code command line is installed and available."
    exit 1
}

$extensions = @(
  "adpyke.codesnap"
  "bierner.markdown-preview-github-styles"
  "bmewburn.vscode-intelephense-client"
  "codezombiech.gitignore"
  "docker.docker"
  "dracula-theme.theme-dracula"
  "editorconfig.editorconfig"
  "github.copilot"
  "github.copilot-chat"
  "github.vscode-github-actions"
  "github.vscode-pull-request-github"
  "gruntfuggly.todo-tree"
  "hediet.vscode-drawio"
  "humao.rest-client"
  "k--kato.intellij-idea-keybindings"
  "mblode.twig-language-2"
  "mehedidracula.php-namespace-resolver"
  "mikestead.dotenv"
  "ms-vscode.makefile-tools"
  "ms-vscode.vscode-copilot-vision"
  "ms-vscode.vscode-speech"
  "neilbrayfield.php-docblocker"
  "oderwat.indent-rainbow"
  "pomdtr.excalidraw-editor"
  "serhatkaya.twig-formatter"
  "vscode-icons-team.vscode-icons"
  "yzhang.markdown-all-in-one"
)

foreach ($ext in $extensions) {
    Write-Host "Installing $ext"
    try {
        & $codeCmd.Path --install-extension $ext | Out-Null
    } catch {
        Write-Warning "Failed to install $ext"
    }
}

Write-Host "Done. Restart VS Code if prompted."
