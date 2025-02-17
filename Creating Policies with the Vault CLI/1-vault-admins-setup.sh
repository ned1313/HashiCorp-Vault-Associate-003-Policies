# Start up the dev instance of Vault
vault server -dev

# Set the VAULT_ADDR environment variable
export VAULT_ADDR='http://127.0.0.1:8200'

# Create the auth_admins policy
vault policy write vault-admins vault-admins.hcl
