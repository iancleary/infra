# windows-chocolatey

This repo helps install the [chocolatey](https://docs.chocolatey.org/en-us/) software management solution on Windows and installs some applications I like to have on all my Windows machines.


# Choco install

Open a Power Shell terminal as an administrator, and install chocolately:

```ps1
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

Then install [just](https://github.com/casey/just) to run the justfile.

`choco install just`
