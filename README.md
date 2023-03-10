# infra

Personal Infrastructure as code

This repo demonstrates my use of the Infrastructure as Code philosophy using [NixOS](https://nixos.org), [Ansible](https://docs.ansible.com/ansible_community.html), [Terraform](https://www.terraform.io/), and [Chocolatey](https://chocolatey.org/).

## Operating Systems

### Windows Laptops and Desktops

I originally started down a path of using [dotfiles](https://github.com/iancleary/dotfiles_old) and ansible to manage my (Ubuntu LTS) desktop configuration, [iancleary/ubuntu-dev-playbook](https://github.com/iancleary/ubuntu-dev-playbook).

Since then, I've discovered the Nix package manager, and the NixOS Operating System.

I still use a dotfiles repo, [iancleary/dotfiles](https://github.com/iancleary/dotfiles), but have switched from [yadm](https://yadm.io) to [chezmoi](https://chezmoi.io), as the latter supports Windows, while `yadm` is Unix only.  I recommend both, but Chezmoi fit my changing needs.

At work ([Payload Systems Engineering on Communications Satellites](https://en.wikipedia.org/wiki/Communications_satellite)), the ubiquitous operating system is Windows.

I've dabbled with Ubuntu LTS as a host operating system, but the Microsoft ecosystem can be high friction, depending on what kind of tasks you do, day to day.
I went to try Windows Subsystem for Linux, but experienced issues while connecting to the work VPN and DNS issues, when using WSL2.  There are probably ways to get that to work now (at the time of writing this) or in the future.  However, that's not where I want to spend my time.

So, for now, I've focused on how to cultivate all the tools and systems I'd like, while using Windows as the host Operating System.

I explored various options in Virtual Machines, while on a Windows host: Hyper-V, VirtualBox.  The performance of Hyper-V was intriguing to me, but the lack of static IP Addresses was frustrating.  Again, there might be ways to setup Hyper-V to consistently address VMs by IP Address, across reboots, but the only workflow I found was to use PowerShell to get the IP Address after reboot.  That worked fairly well with Ubuntu guests, but I experienced intermittent issues recently. See [iancleary/local-ssh-config](https://github.com/iancleary/local-ssh-config) for a Python package that helps script the update process (get IP Address, update ssh config files).

I've landed on Virtual Box, with a few tricks to make SSH consistent across reboots.  Port Forwarding!

So my solution, Virtual Box, allows me to use NixOS, have an immutable file system with rollbacks via GRUB entries, that I can pause/resume as needed.  I really enjoyed learning Ansible, and it is a fantastic tool, but the discover of the recovery and rollback features of NixOS were a *illuminating discovery for me.  The build with fail if it causes issues with other parts of the configuration.

### NixOS

There are some excellent write up on Nix and NixOS, so I'll defer to them rather than repeat them (poorly) here:

#### First Party Nix Articles (nixos.org/wiki)

* [Overview of the NixOS Linux Distribution](https://nixos.wiki/wiki/Overview_of_the_NixOS_Linux_distribution)

* [Home Manager](https://nixos.wiki/wiki/Home_Manager), which appears to be a preference on whether you care for it and want to use it.

* [Forum Post about Git(Hub) strategies for Nix Configuration](https://discourse.nixos.org/t/github-strategies-for-configuration-nix/1983)

#### Third Party Nix Articles

* [Example Home Manager Configuration, by michaelpj](https://github.com/michaelpj/nixos-config/blob/master/modules/home.nix)

* [Declarative management of dotfiles with Nix and Home Manager](https://www.bekk.christmas/post/2021/16/dotfiles-with-nix-and-home-manager). Nix is a declarative package manager with rising popularity. One of the best ways to actually learn it is to use it, and what better way to learn it than using it every day to manage your dotfiles? 10 min read, by Ole Kristian Pedersen

### MacOS

I bought a Macbook Air and use it for leisure, catching up with friends, and when I just need to get some personal things done.  I do less configuration and development on my Mac.

I've used the `brew` (Homebrew) package manager, and have repeated my terminal configuration from Ubuntu and NixOS there.  I likely will bring some of that configuration into this repo.  Maybe; maybe not.

## Server Configuration

### Tooling

Install [ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) and [terraform](https://www.terraform.io/downloads).

#### Ansible

I have an [UnRaid](https://unraid.net/) server at home, that I use as Network Attached Storage (NAS) server.  I also run many docker containers, and several virtual machines (Home Assistant and an Ubuntu server running PiHole).

* [ansible/playbook_local-dns.yml](ansible/playbook_local-dns.yml)

I don't believe it is a good idea to open any ports from that server up to the internet, from my local network.  
I use Tailscale to connect back to these systems and am protected by WireGuard, and prompt security patches on all my systems, [ansible\playbook_upgrade.yml](ansible\playbook_upgrade.yml).

I also maintain a Tailscale Docker Image for UnRaid, [iancleary/unraid-tailscale](https://github.com/iancleary/unraid-tailscale).

#### Terraform

Modeling of of <https://github.com/selfhostedshow/infra>, I use an config file for token and default password for Linode.  I've extended this concept for Vercel as well.  These tokens are used with Terraform.

> I'm in the processing of migrating to (learning) terraform cloud.  In that environment I'm using environment variables (sensitive) rather than plaintext tokens on my machines.

##### Linode Token

```yaml
---
# ~/.config/tokens/linode.yaml
default-root-pass: "supersecretpassword"
token: 123456789abcdefghijklmnopqrstuvqxyz123456789abcdefghijklmnopqrst
```

##### Vercel Token

```yaml
---
# ~/.config/tokens/vercel.yaml
token: qrstuvqxyz123456789abcdefghi
```

> I've since switched my Email from a Mail-in-a-box server on Linode to Fastmail, so my DNS entries are no longer in Vercel and controlled here.
