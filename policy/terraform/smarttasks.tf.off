locals {
  smarttask_log_all = <<EOT
#!/bin/bash

# not for production use - mind log rotation!
LOGFILE="/var/log/smarttasks.log"

# is $1 file path?
if [[ ! -f "$1" ]]; then
  echo "Error: Input is not a file." >&2
else
    # append formatted to logfile
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" >> "$LOGFILE"
    cat "$1" | jq -c .  >> "$LOGFILE"
    echo >> "$LOGFILE"
fi

printf '{"result":"success"}\n'
exit 0
EOT

  smarttask_protect_made_by_terraform_tag = <<EOT
#!/bin/bash

# not for production use - mind log rotation!
LOGFILE="/var/log/smarttasks.log"

# is $1 file path?
if [[ ! -f "$1" ]]; then
  echo "Error: Input is not a file." >&2
else
  # at least one deleted object with tag MadeByTerraform?
  TRIGGER=$(cat "$1" | jq -r -c '[ .operations."deleted-objects"[] | {type: .type, name: .name, tagMadeByTf:( ( [ ((.tags // [])[].name  )  ] | index("MadeByTerraform") ) | . != null ) } | select(.tagMadeByTf) ] | length')
  echo "$(date +'%Y-%m-%d %H:%M:%S') - $1 trigger $TRIGGER" >> "$LOGFILE"
  
  if [[ "$TRIGGER" -gt 0 ]]; then
    printf '{"result":"failure","message":"Not allowed to delete objects with tag MadeByTerraform"}\n'
    exit 0
  fi

  echo "$(date +'%Y-%m-%d %H:%M:%S') - $1 trigger $TRIGGER not relevant" >> "$LOGFILE"
fi

printf '{"result":"success"}\n'
exit 0
EOT
}

resource "checkpoint_management_repository_script" "smarttask_log_all" {
  name        = "SmartTask Log All"
  script_body = local.smarttask_log_all
}

resource "checkpoint_management_smart_task" "smarttask_log_all_before_publish" {
  name    = "Before Publish - Log All"
  trigger = "Before Publish"
  action {
    run_script {
      repository_script = checkpoint_management_repository_script.smarttask_log_all.name
    }
  }
  enabled = true
  custom_data = jsonencode({
    a = 10
    b = 20
    c = "Hello World"
    d = { z : 14, y : "test" }
  })
}


resource "checkpoint_management_repository_script" "smarttask_protect_made_by_terraform_tag" {
  name        = "SmartTask Reject Delete tagged with MadeByTerraform Tag"
  script_body = local.smarttask_protect_made_by_terraform_tag
}

resource "checkpoint_management_smart_task" "smarttask_protect_made_by_terraform_tag_before_publish" {
  name    = "Before Publish - Reject Delete tagged with MadeByTerraform Tag"
  trigger = "Before Publish"
  action {
    run_script {
      repository_script = checkpoint_management_repository_script.smarttask_protect_made_by_terraform_tag.name
    }
  }
  enabled = true
  custom_data = jsonencode({
    a = 10
    b = 20
    c = "Hello World"
    d = { z : 14, y : "test" }
  })
}

