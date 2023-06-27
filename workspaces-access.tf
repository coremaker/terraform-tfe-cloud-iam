locals {
  read_workspaces = flatten([
    for team in var.organization_teams : [
      for workspace in team.read_access_workspaces : {
        workspace  = workspace
        team   = team.name
        rsName = join("_", [team.name, workspace])
      }
    ]
  ])

  admin_workspaces = flatten([
    for team in var.organization_teams : [
      for workspace in team.admin_access_workspaces : {
        workspace  = workspace
        team   = team.name
        rsName = join("_", [team.name, workspace])
      }
    ]
  ])

  plan_workspaces = flatten([
    for team in var.organization_teams : [
      for workspace in team.plan_access_workspaces : {
        workspace  = workspace
        team   = team.name
        rsName = join("_", [team.name, workspace])
      }
    ]
  ])

  write_workspaces = flatten([
    for team in var.organization_teams : [
      for workspace in team.write_access_workspaces : {
        workspace  = workspace
        team   = team.name
        rsName = join("_", [team.name, workspace])
      }
    ]
  ])

  custom_workspaces = flatten([
    for team in var.organization_teams : [
      for workspace in team.custom_access_workspaces : {
        workspace  = workspace
        team   = team.name
        rsName = join("_", [team.name, workspace.workspace_id])
      }
    ]
  ])
}

resource "tfe_team_access" "read" {
    for_each = { for i in local.read_workspaces : i["rsName"] => i }

  access       = "read"
  team_id      = tfe_team.main[each.value["team"]].id
  workspace_id = each.value["workspace"]
}

resource "tfe_team_access" "admin" {
    for_each = { for i in local.admin_workspaces : i["rsName"] => i }

  access       = "admin"
  team_id      = tfe_team.main[each.value["team"]].id
  workspace_id = each.value["workspace"]
}

resource "tfe_team_access" "plan" {
    for_each = { for i in local.plan_workspaces : i["rsName"] => i }

  access       = "plan"
  team_id      = tfe_team.main[each.value["team"]].id
  workspace_id = each.value["workspace"]
}

resource "tfe_team_access" "write" {
    for_each = { for i in local.write_workspaces : i["rsName"] => i }

  access       = "write"
  team_id      = tfe_team.main[each.value["team"]].id
  workspace_id = each.value["workspace"]
}

resource "tfe_team_access" "custom" {
    for_each = { for i in local.custom_workspaces : i["rsName"] => i }

  team_id      = tfe_team.main[each.value["team"]].id
  workspace_id = each.value["workspace"]["workspace_id"]

  permissions {
    runs = each.value["workspace"]["runs"]
    variables = each.value["workspace"]["variables"]
    state_versions = each.value["workspace"]["state_versions"]
    sentinel_mocks = each.value["workspace"]["sentinel_mocks"]
    workspace_locking = each.value["workspace"]["workspace_locking"]
    run_tasks = each.value["workspace"]["run_tasks"]
  }
}