#! /bin/sh
set -ex

INIT_FILE=/vault/keys/vault.init

unseal () {
vault operator unseal $(grep 'Key 1:' ${INIT_FILE} | awk '{print $NF}')
vault operator unseal $(grep 'Key 2:' ${INIT_FILE} | awk '{print $NF}')
}

init () {
echo "Initializing Vault..."
sleep 5
vault operator init -key-shares=3 -key-threshold=2 | tee ${INIT_FILE} > /dev/null ### 3 fragments, 2 are required to unseal
}

log_in () {
   export ROOT_TOKEN=$(grep 'Initial Root Token:' ${INIT_FILE} | awk '{print $NF}')
   vault login $ROOT_TOKEN
}

create_token () {
   vault token create -id $MY_VAULT_TOKEN
}

if [ -s ${INIT_FILE} ]; then
   unseal
else
   init
   unseal
   log_in
   create_token
fi

vault status > /vault/keys/status
