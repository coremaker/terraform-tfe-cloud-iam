# terraform-tfe-cloud-iam

Manage members, teams and access of your Terraform Cloud organization.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) | ~> 0.45.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | 0.45.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [tfe_organization_membership.main](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/organization_membership) | resource |
| [tfe_team.main](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team) | resource |
| [tfe_team_access.admin](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team_access) | resource |
| [tfe_team_access.custom](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team_access) | resource |
| [tfe_team_access.plan](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team_access) | resource |
| [tfe_team_access.read](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team_access) | resource |
| [tfe_team_access.write](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team_access) | resource |
| [tfe_team_organization_members.main](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team_organization_members) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_organization_members"></a> [organization\_members](#input\_organization\_members) | Add or remove a user from the organization. | `list(string)` | `[]` | no |
| <a name="input_organization_teams"></a> [organization\_teams](#input\_organization\_teams) | Manage teams. | <pre>list(object({<br>    name                     = string<br>    members                  = optional(list(string), [])<br>    visibility               = optional(string, "organization")<br>    organization_access      = optional(map(string), {})<br>    read_access_workspaces   = optional(list(string), [])<br>    admin_access_workspaces  = optional(list(string), [])<br>    plan_access_workspaces   = optional(list(string), [])<br>    write_access_workspaces  = optional(list(string), [])<br>    custom_access_workspaces = optional(list(map(string)), [])<br>  }))</pre> | `[]` | no |
| <a name="input_tfe_organization_name"></a> [tfe\_organization\_name](#input\_tfe\_organization\_name) | Name of the organization. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->