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
}

resource "tfe_team_organization_members" "main" {
    for_each = local.teams

    team_id = tfe_team.main[each.key].id
    organization_membership_ids = [for member in each.value["members"] : tfe_organization_membership.main[member].id]
}