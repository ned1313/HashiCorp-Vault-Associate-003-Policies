# View the current policy
vault policy read vault-admins 

# Create a new policy file from the policy
vault policy read vault-admins > "vault-admins-update.hcl"

# Get the policies that need to be created
vault auth enable -output-policy ldap

vault auth tune -description="something" -output-policy ldap

vault auth disable -output-policy ldap

vault write -output-policy auth/ldap/config userdn="something"

# Format the updated policy file
vault policy fmt vault-admins-update.hcl

# Write the updated policy to Vault
vault policy write security-team vault-admins-update.hcl

# Create a token with the updated policy
vault token create -policy=security-team

# Store the root token in a variable
root_token=$(vault print token)

# Store the new token in a variable
new_token=TOKEN_VALUE

# Login with the new token
vault login $new_token

# Test out commands
vault auth enable ldap

vault auth tune -description="something" ldap

vault auth list

# Check permissions on that path
vault token capabilities sys/auth

# Create the policy block
vault auth list -output-policy

# Log back in with the root token
vault login $root_token

# Update the policy
vault policy write security-team vault-admins-update.hcl

# Log back in with the new token
vault login $new_token

# Test out commands
vault auth list

vault auth disable ldap

# Log back in with the root token
vault login $root_token

# Delete the original policy
vault policy delete vault-admins