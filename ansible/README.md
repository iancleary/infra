# Ansible

## Install roles and collections

```bash
ansible-galaxy install -r ansible/requirements.yml
```

## Linode Plugin

The Ansible [communnity.general.linode plugin](https://docs.ansible.com/ansible/latest/collections/community/general/linode_inventory.html)
requires the LINODE_ACCESS_TOKEN to be set as an environment variable

```bash
export LINODE_ACCESS_TOKEN=123456789abcdefghijklmnopqrstuvqxyz123456789abcdefghijklmnopqrst
```


```bash
python3 -m pip install --user linode_api4
```