# windows-chocolatey

This repo helps install the [chocolatey](https://docs.chocolatey.org/en-us/) software management solution on Windows and installs some applications I like to have on all my Windows machines.

## Choco install

Open a Power Shell terminal as an administrator, and install chocolately:

```ps1
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

Then install [just](https://github.com/casey/just) to run the justfile.

`choco install just`

## Fonts

When using SSH, Windows Terminal, or VS Code with a shared directory to NixOS
You need the fonts installed on the host machine, not the Virtual Machine
[nixos/modules/common/zsh.nix](../nixos/modules/common/zsh.nix) installs them on the Virtual Machine.

To install them on your local machine, visit <https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k>, click each font and hit "Install".

This is copied below for my reference:

## Manual font installation

1. Download these four ttf files:
   - [MesloLGS NF Regular.ttf](
       <https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf>)
   - [MesloLGS NF Bold.ttf](
       <https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf>)
   - [MesloLGS NF Italic.ttf](
       <https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf>)
   - [MesloLGS NF Bold Italic.ttf](
       <https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf>)
1. Double-click on each file and click "Install". This will make `MesloLGS NF` font available to all
   applications on your system.
1. Configure your terminal to use this font:
   - **Visual Studio Code**: Open *File → Preferences → Settings* (PC) or
     *Code → Preferences → Settings* (Mac), enter `terminal.integrated.fontFamily` in the search box at
     the top of *Settings* tab and set the value below to `MesloLGS NF`.
     Consult [this screenshot](
       <https://raw.githubusercontent.com/romkatv/powerlevel10k-media/389133fb8c9a2347929a23702ce3039aacc46c3d/visual-studio-code-font-settings.jpg>)
     to see how it should look like or see [this issue](
       <https://github.com/romkatv/powerlevel10k/issues/671>) for extra information.
   - **Windows Terminal** by Microsoft (the new thing): Open *Settings* (`Ctrl+,`), click
     either on the selected profile under *Profiles* or on *Defaults*, click *Appearance* and set
     *Font face* to `MesloLGS NF`.
