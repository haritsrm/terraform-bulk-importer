#!/bin/bash

echo "Installing terraform-bulk-importer"
SYMLINK_COMMAND="sudo ln terraform-bulk-importer.sh /usr/local/bin/terraform-bulk-importer"
echo "$SYMLINK_COMMAND"
eval "$SYMLINK_COMMAND"
echo -e "Installed. \n"
echo -e "\n"
echo -e "Please use: terraform-bulk-importer <DIR> <ARG> \n"
echo -e "Example: terraform-bulk-importer examples -i \n"