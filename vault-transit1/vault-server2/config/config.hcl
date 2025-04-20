#https://developer.hashicorp.com/vault/docs/configuration/storage
#https://developer.hashicorp.com/vault/docs/configuration/storage/raft

disable_mlock = true

storage "raft" {
  path    = "/vault/file"
  node_id = "node2"
}

#https://developer.hashicorp.com/vault/docs/configuration/listener/tcp


listener "tcp" {
  address = "0.0.0.0:8200"
  tls_disable = true
}

seal "transit" {
  address = "http://vault-server4:8200"
  token = "xx"
  disable_renewal = "false"
  key_name = "autounseal"
  mount_path = "hellocloud/"
  tls_skip_verify = "true"
}

api_addr = "http://vault-server2:8200"
cluster_addr  = "http://vault-server2:8201"
cluster_name = "sg-vault-cluster"

ui = true
log_level = "debug"