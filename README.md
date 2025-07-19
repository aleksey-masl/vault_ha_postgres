# vault_ha_postgres

**#Migration from file to postgres**

docker exec -it vault bash

vault operator migrate -config=/vault/config/mgr.json

**#Volumes**

/vault/config - for config

vault/data - for data

/vault/ca - for CA kubernetes cluster

/vault/policies - for policies

**#env**

MY_VAULT_TOKEN: ${MY_VAULT_TOKEN:-test} - custom token 
