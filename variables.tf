variable "tfe_organization_name" {
  type        = string
  description = "Name of the organization."
}

variable "organization_members" {
  type        = list(string)
  default     = []
  description = "Add or remove a user from the organization."
}

variable "organization_teams" {
  type = list(object({
    name                     = string
    members                  = optional(list(string), [])
    visibility               = optional(string, "organization")
    organization_access      = optional(map(string), {})
    read_access_workspaces   = optional(list(string), [])
    admin_access_workspaces  = optional(list(string), [])
    plan_access_workspaces   = optional(list(string), [])
    write_access_workspaces  = optional(list(string), [])
    custom_access_workspaces = optional(list(map(string)), [])
  }))
  default     = []
  description = "Manage teams."
}

