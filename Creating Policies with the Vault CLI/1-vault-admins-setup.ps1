# Start up the dev instance of Vault
vault server -dev

# Set the VAULT_ADDR environment variable
$env:VAULT_ADDR = "http://127.0.0.1:8200"

# Create the auth_admins policy
vault policy write vault-admins vault-admins.hcl

# Create a token with the auth_admins policy
vault token create -policy=auth_admins

# Login with the token
vault login