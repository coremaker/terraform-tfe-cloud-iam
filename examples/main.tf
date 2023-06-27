module "iam" {
  source = "github.com/coremaker/terraform-tfe-cloud-iam.git"

  tfe_organization_name = "YOUR ORGANIZATION"

  organization_members = ["someone@gmail.com"]
  organization_teams = [
    {
      name    = "dev-test"
      members = ["someone@gmail.com"]
    },
    {
      name    = "devops-test"
      members = ["someone@gmail.com"]
      organization_access = {
        read_workspaces = true
      }
      read_access_workspaces = ["workspace_id"]
    },
    {
      name    = "devops-2"
      members = ["someone@gmail.com"]
      custom_access_workspaces = [
        {
          workspace_id      = "workspace_id"
          runs              = "read"
          variables         = "read"
          state_versions    = "none"
          sentinel_mocks    = "none"
          workspace_locking = "false"
          run_tasks         = "true"
        }
      ]
    }
  ]
}
