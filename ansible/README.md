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
