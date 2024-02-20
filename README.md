# infra

Personal Infrastructure as code

This repo demonstrates my use of the Infrastructure as Code philosophy using [NixOS](https://nixos.org), [Ansible](https://docs.ansible.com/ansible_community.html), and [Chocolatey](https://chocolatey.org/).

### Tooling

Install [nix](https://nixos.org) and [direnv](https://direnv.net).

Clone the repo and run `direnv allow` to load the environment.

## Ansible

I used to use an [UnRaid](https://unraid.net/) server at home, that I use as Network Attached Storage (NAS) server. It also run many docker containers, and several virtual machines (Home Assistant). It became a server that I had confidence in, but couldn't recreate or adjust easily. I've since moved to a NixOS server, and use Ansible to manage it.

> Why Ansible? I've used Ansible for a few years now, and I'm comfortable with it. It allows me to template docker compose easilty and it's vault is familiar to me. There are ways to use NixOS entirely manage the server, but I'm not there yet (and don't want to have to create the secrets files manually). I haven't seen how tools on NixOS handle secrets without manually making the file after ssh'ing into the server.

To me, I see the NixOS server as a way to manage the server and it's configuration, packages, networking, and anything to do with the host. On top of that extremely stable base, the Ansible playbooks are a tried and true way to manage the configuration of the containers.

There are ways to use NixOS to manage the containers, but there are currently more questions than paved road solutions. I'm not sure how to handle the secrets files (/nix/store is world readible). I haven't seen how tools on NixOS handle secrets without manually making the file after ssh'ing into the server. To me it seems like a good idea to use Ansible to manage the containers, and NixOS to manage the host.

When I change the ansible files for the NixOS configuration, it will fail to build if I have an issue that impacts the host.

> Full stop! That is powerful. The only thing to avoid is to make a change that removes tailscale...which would remove my ability to ssh into the server.
> I could go grab the server, plug in a keyboard and monitor, and revert with GRUB. That is a pain, but is a nice physical backup plan.

## Initial Setup of a Server with NixOS

The first setup can copy the configuration.nix file directly, then I can run `sudo tailscale up --ssh` to connect to the server, and then run the ansible playbook to configure the containers and adjust the nix configuration, rebuilding and switching to the new configuration as needed.

I don't believe it is a good idea to open any ports from that server up to the internet, from my local network.

I use Tailscale to connect back to these systems and am protected by WireGuard and no exposed ports to the internet. I allow some local ports to be exposed to the local area network, but only ones needed to configure my Wireless Access Points (to facilitate there adoption).

## Operating Systems

### MacOS

I bought a Macbook Air and use it for development, catching up with friends, and when I just need to get some personal things done. Since Nix runs very well on Apple Silicon Macs, I have started to do a lot of configuration with Nix. This removes the need for Development Containers and any virtualization...speed!

### Windows Laptops and Desktops

I originally started down a path of using [dotfiles](https://github.com/iancleary/dotfiles_old) and ansible to manage my (Ubuntu LTS) desktop configuration, [iancleary/ubuntu-dev-playbook](https://github.com/iancleary/ubuntu-dev-playbook).

Since then, I've discovered the Nix package manager, and the NixOS Operating System.

I still use a dotfiles repo, [iancleary/dotfiles](https://github.com/iancleary/dotfiles), but have switched from [yadm](https://yadm.io) to [chezmoi](https://chezmoi.io), as the latter supports Windows, while `yadm` is Unix only. I recommend both, but Chezmoi fit my changing needs.

At work ([RF Systems Engineering on Communications Satellites](https://en.wikipedia.org/wiki/Communications_satellite)), the ubiquitous operating system is Windows.

I've dabbled with Ubuntu LTS as a host operating system, but the Microsoft ecosystem can be high friction, depending on what kind of tasks you do, day to day.
I went to try Windows Subsystem for Linux, but experienced issues while connecting to the work VPN and DNS issues, when using WSL2. There are probably ways to get that to work now (at the time of writing this) or in the future. However, that's not where I want to spend my time. So, for now, I've focused on how to cultivate all the tools and systems I'd like, while using Windows as the host Operating System.

I explored various options in Virtual Machines, while on a Windows host: Hyper-V, VirtualBox. The performance of Hyper-V was intriguing to me, but the lack of static IP Addresses was frustrating. Again, there might be ways to setup Hyper-V to consistently address VMs by IP Address, across reboots, but the only workflow I found was to use PowerShell to get the IP Address after reboot. That worked fairly well with Ubuntu guests, but I experienced intermittent issues recently. See [iancleary/local-ssh-config](https://github.com/iancleary/local-ssh-config) for a Python package that helps script the update process (get IP Address, update ssh config files).

I've landed on Virtual Box, with a few tricks to make SSH consistent across reboots. Port Forwarding!

> TBD to add a repo, but search online for "Virtual Box Port Forwarding +SSH" and you'll find the solution. It maps a host port to a guest's port 22 (or whatever port the guest uses for the openssh server).

So my solution, Virtual Box, allows me to use NixOS, have an immutable file system with rollbacks via GRUB entries, that I can pause/resume as needed. I really enjoyed learning Ansible, and it is a fantastic tool, but the discover of the recovery and rollback features of NixOS were a \*illuminating discovery for me. The build with fail if it causes issues with other parts of the configuration.

### NixOS

I have dabbled with NixOS as a desktop Operating System and can say it is fantastic.

> My NixOS Configuration is in the [iancleary/nixos-config](https://github.com/iancleary/nixos-config) repo.

There are some excellent write up on Nix and NixOS, so I'll defer to them rather than repeat them (poorly) here:

#### First Party Nix Articles (nixos.org/wiki)

- [Overview of the NixOS Linux Distribution](https://nixos.wiki/wiki/Overview_of_the_NixOS_Linux_distribution)

- [Home Manager](https://nixos.wiki/wiki/Home_Manager), which appears to be a preference on whether you care for it and want to use it.

- [Forum Post about Git(Hub) strategies for Nix Configuration](https://discourse.nixos.org/t/github-strategies-for-configuration-nix/1983)

#### Third Party Nix Articles

- [Example Home Manager Configuration, by michaelpj](https://github.com/michaelpj/nixos-config/blob/master/modules/home.nix)

- [Declarative management of dotfiles with Nix and Home Manager](https://www.bekk.christmas/post/2021/16/dotfiles-with-nix-and-home-manager). Nix is a declarative package manager with rising popularity. One of the best ways to actually learn it is to use it, and what better way to learn it than using it every day to manage your dotfiles? 10 min read, by Ole Kristian Pedersen
