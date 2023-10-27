resource "shoreline_notebook" "mongodb_deadlock_issues" {
  name       = "mongodb_deadlock_issues"
  data       = file("${path.module}/data/mongodb_deadlock_issues.json")
  depends_on = [shoreline_action.invoke_set_mongo_lock_timeout_and_max_connections]
}

resource "shoreline_file" "set_mongo_lock_timeout_and_max_connections" {
  name             = "set_mongo_lock_timeout_and_max_connections"
  input_file       = "${path.module}/data/set_mongo_lock_timeout_and_max_connections.sh"
  md5              = filemd5("${path.module}/data/set_mongo_lock_timeout_and_max_connections.sh")
  description      = "Tune the MongoDB server parameters, such as the lock timeout and the maximum number of connections, to improve its performance and avoid deadlocks."
  destination_path = "/tmp/set_mongo_lock_timeout_and_max_connections.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_set_mongo_lock_timeout_and_max_connections" {
  name        = "invoke_set_mongo_lock_timeout_and_max_connections"
  description = "Tune the MongoDB server parameters, such as the lock timeout and the maximum number of connections, to improve its performance and avoid deadlocks."
  command     = "`chmod +x /tmp/set_mongo_lock_timeout_and_max_connections.sh && /tmp/set_mongo_lock_timeout_and_max_connections.sh`"
  params      = ["MONGODB_URI"]
  file_deps   = ["set_mongo_lock_timeout_and_max_connections"]
  enabled     = true
  depends_on  = [shoreline_file.set_mongo_lock_timeout_and_max_connections]
}

