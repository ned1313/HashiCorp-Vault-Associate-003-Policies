# Add Ford as another user to the userpass auth method
vault write auth/userpass/users/ford username="ford" password="prefect"

# Create an internal group named secrets-admins
vault write identity/group name="secrets-admins"

# Create ford as an entity and associate it with the secrets-admins group
vault write identity/entity name="ford" policies="default"

# Associate the ford userpass alias with the ford entity
$auths = $(vault auth list -format=json) | ConvertFrom-Json
$entity = $(vault read -format=json identity/entity/name/ford) | ConvertFrom-Json

vault write identity/entity-alias name="ford" canonical_id=$($entity.data.id) mount_accessor=$($auths.'userpass/'.accessor)

# Associate the secrets-admins group with the ford entity
vault write identity/group name="secrets-admins" member_entity_ids=$($entity.data.id)