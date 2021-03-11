# Backup RESOURCE to DESTINATION
# Only add file
rsync -avu "RESOURCE" "DESTINATION"


# Prevent IGNORE_NAME backup to DESTINAION
rsync -avu --exclude "IGNORE_NAME" "RESOURCE" "DESTINATION"


# Delete no longer exists file in DESTINATION
rsync -avu --delete "RESOURCE" "DESTINATION"


# Output result to LOG_PATH
rsync -avu "RESOURCE" "DESTINATION" > "LOG_PATH"


# Ignore .git, node_modules, vendor folder.
# Delete no longer exists file in DESTINATION
# Output result to LOG_PATH
rsync -avu --exclude ".git" --exclude "node_modules" --exclude "vendor" --delete "RESOURCE" "DESTINATION" > "LOG_PATH"
