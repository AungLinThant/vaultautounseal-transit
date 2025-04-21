# vaultautounseal-transit
Auto-unseal vault transit secret engine

Lab experience procedure for running vault-transit secrte engine
In vault-transit1
1 run vault-server1,2,3 as shamir seal type in vault-transit1
2 enable transit secret engine
vault secrets enable -path=hellocloud transit
3 write autounseal
vault write -f hellocloud/keys/autounseal auto_rotate_period=1h
4 apply policy
vault policy write autounseal policy.hcl
5 generate token
vault token create -orphan -policy=autounseal

In vault-transit2
1 run vault-server4,5,6 as transit seal type in vault-transit2
2 enable transit secret engine
vault secrets enable -path=hellocloud transit
3 write autounseal
vault write -f hellocloud/keys/autounseal auto_rotate_period=1h
4 apply policy
vault policy write autounseal policy.hcl
5 generate token
vault token create -orphan -policy=autounseal

In vault-transit1, migrate as transit seal type from shamir seal type
1 stop docker-container1,2,3
2 open scripts for transmit seal in each config using token
3 docker start again
output is
seal types will be transit and it does not need to unseal due to using
vault transit secret engine.
