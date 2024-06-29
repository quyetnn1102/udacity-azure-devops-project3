# Azure subscription vars
subscription_id = ""
client_id = ""
client_secret = ""
tenant_id = ""

# Resource Group/Location
location = "East US"
resource_group = "Azuredevops3"
application_type = "myApplication"

# Network
virtual_network_name = "myNetwork"
address_space = ["10.5.0.0/16"]
address_prefixes = ["10.5.1.0/24"]
address_prefix_test = "10.5.1.0/24"

# VM
admin_username = "vm_admin"
admin_password = "Fsoft@1234"
public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDXtNUBYh+wUNcuLLAGVCWYQIpRF0khtznJmFoBSvPqb6QUZNL0xVb/3brU2eSEP3u1ajfk074wv/Qe+W0acCG22cSfRYFb8YBjpwMsEuMMDgPZs238a8ExsMeXbUeOw+JAWVNz0OgBRik4OL4sMZzpnXqPyB2ZhM3AB6wAfUp56SxRch9PKvPLenjRdVwI4zFNXLYBwQ3zOSd2n6GodbqmGngSA5DtGsf8lICd4wnz1r9J9fJ+HLUePbCyRVRwxNm4GnPl0nXYWfpVYLW2MUc0QNVJAJ8rIDuQHCdHJ08qzLjGdLlLTr7Y3dDiAf85sxBI6lnp9BAwGV04iuUT0d2t9i12Y7DSKSdS5PCAS0h6a5kC/duNewk3Qst0RaOH1Ia7qo04RGuquucV2bkInWV2uOCc0IsD+RPG9CtOb8ctQBwRw2SaGGjE4v0tyPKwtstY5ZVD5ZYWodKkeiOGRyFzf4z9q65ScKOo3og8DpPWvAYySLzLnWoU3rEzGzAxLKs= odl_user@SandboxHost-638536862762395844"

#public key on pipeline
public_key_path = "/home/vsts/work/_temp/id_rsa.pub"
