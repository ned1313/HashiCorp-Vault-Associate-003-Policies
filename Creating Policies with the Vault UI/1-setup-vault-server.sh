# Start up dev instance
vault server -dev

# Set the VAULT_ADDR environment variable
export VAULT_ADDR='http://127.0.0.1:8200'

# Enabled the userpass auth method
vault auth enable userpass

# Create the user Arthur
vault write auth/userpass/users/arthur username="arthur" password="dent"

# Enabled the kv-v1 secrets engine at app1
vault secrets enable -path=app1 kv-v1

# Write a few secrets to app1/tacotruck
vault write app1/tacotruck/beeftaco filling=beef
vault write app1/tacotruck/chickentaco filling=chicken
vault write app1/tacotruck/vegtaco filling=veggies

# Write admin password
vault write app1/admin_credentials username="vespa" password="12345"
