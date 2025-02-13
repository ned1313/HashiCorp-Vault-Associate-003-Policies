# Add Ford as another user to the userpass auth method
vault write auth/userpass/users/ford username="ford" password="prefect"

# Create an internal group named secrets-admins
vault write identity/group name="secrets-admins"

# Create ford as an entity and associate it with the secrets-admins group
vault write identity/entity name="ford" policies="default"

# Associate the ford userpass alias with the ford entity
mount_accessor = $(vault auth list -format=json | jq -r '.["userpass/"].accessor')
entity_id = $(vault read -format=json identity/entity/name/ford | jq -r '.data.id')

vault write identity/entity-alias name="ford" canonical_id=$entity_id mount_accessor=$mount_accessor

# Associate the secrets-admins group with the ford entity
vault write identity/group name="secrets-admins" member_entity_ids=$entity_id