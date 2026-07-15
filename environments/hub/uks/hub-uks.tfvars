#================================================================================================
# Environment Configuration Values
#================================================================================================
subscription_id  = "2bc7b65e-18d6-42ae-afb2-e66d50be6b05" # appl_prd_01.
location         = "uksouth"
enable_telemetry = false
tags = {
  environment = "hub"
}

#================================================================================================
# 010-resource-groups.tf
#================================================================================================
resource_groups = {
  rg-hub-uks-02 = {
    role_assignments = {
      # required to set rbac permissions on storage accounts once oauth has been enabled as default.
      ra1 = {
        role_definition_id_or_name       = "Storage Blob Data Owner"
        principal_id                     = "d08afe7c-ea95-4269-ad22-b9e2f8901242" # enterprise application > object id | sp_terraform_global.
        skip_service_principal_aad_check = true                                   # set to 'true' for service principals.
        principal_type                   = "ServicePrincipal"
      }
      ra2 = {
        role_definition_id_or_name       = "Storage Blob Data Owner"
        principal_id                     = "3a386d84-7142-4085-88ad-e8045ef940ea" # enterprise application > object id | sp_appl_prd_01.
        skip_service_principal_aad_check = true                                   # set to 'true' for service principals.
        principal_type                   = "ServicePrincipal"
      }
      # required to create & update pdns records.
      ra3 = {
        role_definition_id_or_name       = "Private DNS Zone Contributor"
        principal_id                     = "d08afe7c-ea95-4269-ad22-b9e2f8901242" # enterprise application > object id | sp_terraform_global.
        skip_service_principal_aad_check = true                                   # set to 'true' for service principals.
        principal_type                   = "ServicePrincipal"
      }
      # ra4 = {
      #   role_definition_id_or_name       = "Private DNS Zone Contributor"
      #   principal_id                     = "3a386d84-7142-4085-88ad-e8045ef940ea" # enterprise application > object id | sp_appl_prd_01.
      #   skip_service_principal_aad_check = true                                   # set to 'true' for service principals.
      #   principal_type                   = "ServicePrincipal"
      # }
      # required to create & update pdns records.
      # add "Private DNS Zone Contributor" role assignment for each service principal.
    }
  }
}
