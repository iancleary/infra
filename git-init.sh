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
if ( cat ansible/vars/vault.yml | grep -q "\$ANSIBLE_VAULT;" ); then
echo "[38;5;108mVault Encrypted. Safe to commit.[0m"
else
echo "[38;5;208mVault not encrypted! Run 'make encrypt' and try again.[0m"
exit 1
fi
EOT

fi

chmod +x .git/hooks/pre-commit
