# Ansible

## Install roles and collections

```bash
ansible-galaxy install -r ansible/requirements.yml
```

## Mailserver

Create a certificate using Lets Encrypt

https://docker-mailserver.github.io/docker-mailserver/edge/config/security/ssl/#lets-encrypt-recommended


## Ansible Vault

My vault file(s):

* [group_vars/raspberrypi3bv2p0/vault.yml](group_vars/raspberrypi3bv2p0/vault.yml)
* [group_vars/dns-local/vault.yml](group_vars/dns-local/vault.yml)

References:

* <https://docs.ansible.com/ansible/2.8/user_guide/playbooks_best_practices.html#variables-and-vaults>
* <https://docs.ansible.com/ansible/latest/user_guide/vault.html#using-encrypted-variables-and-files>


## become password
ansible-playbook dns-local.yml --extra-vars='ansible_become_pass=replace-me-with-password'

> pihole
> ansible-playbook dns-local.yml --tags='pi-hole-provision' --ask-vault-pass
> ansible-playbook dns-local.yml --tags='pi-hole-service' --ask-vault-pass
> ansible-playbook dns-local.yml --ask-vault-pass

## Setup user on remote machine

Run the playbook to execute the `github_users` role to allow `iancleary` to exits

# login as original user
ssh pi@192.168.1.78

# update password of iancleary
sudo password iancleary
# enter new password
# confirm new password

Change username in playbooks

From
```yaml
  remote_user: pi/ubuntu/etc.
```


From
```yaml
  remote_user: iancleary
```