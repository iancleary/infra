# Ansible

## Install roles and collections

```bash
ansible-galaxy install -r ansible/requirements.yml
```

## Mailserver

Create a certificate using Lets Encrypt

https://docker-mailserver.github.io/docker-mailserver/edge/config/security/ssl/#lets-encrypt-recommended


## become password
ansible-playbook raspberrypi3bv2p0.yml --extra-vars='ansible_become_pass=replace-me-with-password'

> pihole
> ansible-playbook raspberrypi3bv2p0.yml --tags='pi-hole-provision' --extra-vars='ansible_become_pass=replace-me-with-password'
> ansible-playbook raspberrypi3bv2p0.yml --tags='pi-hole-service' --extra-vars='ansible_become_pass=replace-me-with-password'

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