variable "tfe_organization_name" {
  type        = string
  description = "Name of the organization."
}

variable "organization_members" {
    type = list(string)
    default = []
    description = "Add or remove a user from the organization."
}

variable "organization_teams" {
    type = list(object({
        name      = string
        members   = optional(list(string), [])
        visibility = optional(string, "organization")
        organization_access = optional(map(string))
    }))
    default     = []
    description = "Manage teams."
}