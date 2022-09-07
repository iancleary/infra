#!/bin/bash
# sets up a pre-commit hook to ensure that vault.yaml is encrypted
#
# credit goes to nick busey from homelabos for this neat little trick
# https://gitlab.com/NickBusey/HomelabOS/-/issues/355
# I found out about this from IronicBadger
# https://github.com/selfhostedshow/infra/blob/master/git-init.sh

if [ -d .git/ ]; then
rm .git/hooks/pre-commit
cat << EOT >> .git/hooks/pre-commit
if ( cat ansible/group_vars/raspberrypi3bv2p0/vault.yml | grep -q "\$ANSIBLE_VAULT;" ); then
echo "[38;5;108mraspberrypi3bv2p0 Vault Encrypted. Safe to commit.[0m"
else
echo "[38;5;208mraspberrypi3bv2p0 Vault not encrypted! Run 'make encrypt' and try again.[0m"
exit 1
fi

cat << EOT >> .git/hooks/pre-commit
if ( cat ansible/group_vars/dns_local/vault.yml | grep -q "\$ANSIBLE_VAULT;" ); then
echo "[38;5;108mdns_local Vault Encrypted. Safe to commit.[0m"
else
echo "[38;5;208mdns_local Vault not encrypted! Run 'make encrypt' and try again.[0m"
exit 1
fi
EOT

fi

chmod +x .git/hooks/pre-commit
