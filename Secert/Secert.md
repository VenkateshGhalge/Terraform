we will use the Vault as the secert agent to store the secert

## installing vault on linux

1. Update the package manager and install GPG and wget.
   
   sudo apt update && sudo apt install gpg wget

2. Download the keyring
  
   wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

3. Verify the keyring

   gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint

4. Add the HashiCorp repository.

   echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

5. Install Vault.

   sudo apt update && sudo apt install vault

## starting the vault 

 To start Vault, you can use the following command:

  vault server -dev -dev-listen-address="0.0.0.0:8200"

## configuring terraform to read the secert from vault 

1. Enable the AppRole Authenication 
   we can enble approle authenication by CLI or VAULT http url 

   ### using vault CLI 
       
       vault auth enable approle

2. Create an policy 
   
    We need to create policy first,

      vault policy write terraform - << EOF
      path "*" {
      capabilities = ["list", "read"]
      }
 
      path "kv/*" {
      capabilities = ["create", "read","update","delete","list"]
      }

      path "auth/token/create" {
      capabilities = ["create", "read", "update", "list"]
      }
      EOF

    Now you'll need to create an AppRole with appropriate policies

3. create the AppRole 
   
    vault write auth/approle/role/terraform \
    secret_id_ttl=10m \
    token_num_uses=10 \
    token_ttl=20m \
    token_max_ttl=30m \
    secret_id_num_uses=40 \
    token_policies=terraform

4. reading the Role ID

  You can retrieve the Role ID using the Vault CLI:

  vault read auth/approle/role/my-approle/role-id

5. Generate Secert ID

  To generate a Secret ID, you can use the following command

  vault write -f auth/approle/role/my-approle/secret-id