<# My script is derived from a gist on GitHub 
https://gist.githubusercontent.com/ScriptAutomate/02e0cf33786f869740ee963ed6a913c1/raw/e9d9a82a4cff9a889011a1fdb47977d6fd111eb0/Install-ChocoStarterPackages.ps1
#>

<#
Simple, nice bootstrap to get Windows 10 up-and-running with nice setup!

- Installs chocolatey (choco)
- Installs common software

I highly recommend Windows Subsystem for Linux (WSL), also, which is covered in
  a separate gist. It also has a choco command for installing Docker Desktop after:
  - https://gist.github.com/ScriptAutomate/f94cd44dacd0f420fae65414e717212d
#>

## IN AN ELEVATED SHELL
## Right-click PowerShell -> Run As Administrator

# Install chocolatey
## For more info on chocolatey, see: https://chocolatey.org/docs/getting-started
## For more info on this install approach: https://chocolatey.org/install#individual
###
# WARNING: As said by Chocolatey, themselves:
# "Please inspect https://chocolatey.org/install.ps1 prior to running any of these scripts
# to ensure safety. We already know it's safe, but you should verify the security and contents
# of any script from the internet you are not familiar with. All of these scripts download a
# remote PowerShell script and execute it on your machine. We take security very seriously."
# Learn more about Chocolatey security protocols: https://docs.chocolatey.org/en-us/information/security
###
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

### Install things with chocolatey!

# Allow global confirmation so I don't have to have '-y' everywhere in this script
choco feature enable -n=allowGlobalConfirmation

## Search from terminal: choco search <package>
## View locally installed choco packages: choco list --local-only
## Search visually on site: https://chocolatey.org/packages
## I like installing the below packages, for example

# Windows Terminal: Huge improvement over native tooling
choco install microsoft-windows-terminal

# PowerShell Core: Latest PowerShell, can sit ontop of Windows PowerShell
## run with pwsh.exe or in Microsoft Terminal when installed
choco install powershell-core

# Powertoys
choco install powertoys

# Visual Studio Code: Cross-platform IDE of choice for me
choco install vscode
choco install vscode-icons
choco install vscode-markdownlint

# Docker
choco install Containers Microsoft-Hyper-V --source windowsfeatures
choco install docker-desktop
choco install vscode-docker

# Command Line tools
choco install wget

# Git: Should be hard to avoid needing this at work
choco install git.install --params "/GitAndUnixToolsOnPath /NoGitLfs /SChannel /NoAutoCrlf /WindowsTerminal /WindowsTerminalProfile /DefaultBranchName:main /Editor:VisualStudioCode"

# GitHub CLI
choco install gh

# GPG4Win
choco install gpg4win

# Terraform
choco install terraform

# Python3
choco install python3
choco install vscode-python

# Spotify
choco install spotify

# Greenshot
choco install greenshot

# Path Copy Copy
choco install path-copy-copy

# Node
choco install nodejs