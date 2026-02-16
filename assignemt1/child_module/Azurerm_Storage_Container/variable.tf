variable "container_child" {
  description = "A map of storage container names to be created in the storage accounts."
  type        = map(object({
    key = string
    name = string
    storage_account_id = string
    container_access_type = string
    # optional blob to create in the container (provide a local file path in `blob_source`)
    blob_name = optional(string, "")
    blob_source = optional(string, "")
    blob_content_type = optional(string, "text/plain")

  }))
}