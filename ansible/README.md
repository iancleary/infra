# Ansible

I use a [justfile](justfile) to drive all commands.

> A `justfile` is a simple way to define and run project-specific tasks. It is similar to a `makefile`. It's documentation is available at [here](https://github.com/casey/just).

Nix is used to manage the environment. The `just` command is installed using nix.

See the [flake.nix](flake.nix) file for the environment.

Direnv is used to manage the environment. The `.envrc` file is used to load the environment.

## Install roles and collections

```bash
just galaxy
```

## Ansible Vault

My vault file(s):

- [group_vars/all/vault.yml](group_vars/all/vault.yml)
- [group_vars/all/vault.yml](group_vars/all/vault.yml)

References:

- <https://docs.ansible.com/ansible/2.8/user_guide/playbooks_best_practices.html#variables-and-vaults>
- <https://docs.ansible.com/ansible/latest/user_guide/vault.html#using-encrypted-variables-and-files>



## Unifi

When adopting new devices, ensure that the router on your LAN has the hostname `unifi` set to the IP address of the Unifi controller. This is because the Unifi controller is used to adopt new devices and the adoption process uses the hostname `unifi` to find the controller.

> Make sure you check your router's DNS settings at <http://192.168.8.1> or <http://192.168.1.1> to ensure that the hostname `unifi` is set to the IP address of the Unifi controller.


## Home Assistant

MQTT must be setup via the "Devices" section of the Home Assistant UI.  I'm not sure why the "Integrations" section doesn't work, but it doesn't.
