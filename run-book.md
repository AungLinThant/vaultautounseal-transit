vault operator init
vault operator unseal -migrate xx
vault operator unseal -migrate xx
vault operator unseal -migrate xx
vault login xx

vault operator raft list-peers

vault operator raft join http://vault-server1:8200

vault secrets enable -path=hellocloud transit

vault write -f hellocloud/keys/autounseal auto_rotate_period=1h

policy.hcl
path "hellocloud/encrypt/autounseal" {
    capabilities = [ "update" ]
}

path "hellocloud/decrypt/autounseal" {
    capabilities = [ "update" ]
}

vault policy write autounseal policy.hcl
vault token create -orphan -policy=autounseal
vault token create -orphan -policy=autounseal -period=24h -wrap-ttl=120 -field=wrapping_token

vault unwrap

vault list hellocloud/keys/
vault read hellocloud/keys/autounseal
vault write -f hellocloud/keys/autounseal/rotate

vault operator generate-root -init
vault operator generate-root
vault operator generate-root -decode=


#### run in vault-transit2 ####
vault operator init
vault operator unseal xx
vault operator unseal xx
vault operator unseal xx
vault login xx

vault operator raft list-peers

vault operator raft join http://vault-server4:8200

policy.hcl
path "hellocloud/encrypt/autounseal" {
    capabilities = [ "update" ]
}

path "hellocloud/decrypt/autounseal" {
    capabilities = [ "update" ]
}

vault secrets enable -path=hellocloud transit

vault write -f hellocloud/keys/autounseal auto_rotate_period=1h
vault policy write autounseal policy.hcl
vault token create -orphan -policy=autounseal
vault token create -orphan -policy=autounseal -period=24h -wrap-ttl=120 -field=wrapping_token