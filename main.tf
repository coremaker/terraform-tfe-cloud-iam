locals {
    teams = {
        for name in var.organization_teams :
        name.name => name
    }
}

resource "tfe_organization_membership" "main" {
    for_each = toset(var.organization_members)

    organization = var.tfe_organization_name
    email = each.key
}

resource "tfe_team" "main" {
    for_each = local.teams

    name         = each.key
    organization = var.tfe_organization_name
    visibility   = each.value["visibility"]
    organization_access {
        read_workspaces = lookup(each.value["organization_access"], "read_workspaces", null)
        read_projects = lookup(each.value["organization_access"], "read_projects", null)
        manage_policies = lookup(each.value["organization_access"], "manage_policies", null)
        manage_policy_overrides = lookup(each.value["organization_access"], "manage_policy_overrides", null)
        manage_workspaces = lookup(each.value["organization_access"], "manage_workspaces", null)
        manage_vcs_settings = lookup(each.value["organization_access"], "manage_vcs_settings", null)
        manage_providers = lookup(each.value["organization_access"], "manage_providers", null)
        manage_modules = lookup(each.value["organization_access"], "manage_modules", null)
        manage_run_tasks = lookup(each.value["organization_access"], "manage_run_tasks", null)
        manage_projects = lookup(each.value["organization_access"], "manage_projects", null)
        manage_membership =lookup(each.value["organization_access"], "manage_membership", null)
    }
}

resource "tfe_team_organization_members" "main" {
    for_each = local.teams

    team_id = tfe_team.main[each.key].id
    organization_membership_ids = [for member in each.value["members"] : tfe_organization_membership.main[member].id]
}