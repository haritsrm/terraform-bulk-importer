#!/bin/bash

count=0
imported_count=0
removed_count=0

STATE_FILE="/tmp/state"
MODULE_FILE="$HOME/Tools/terraform-state-importer/$1/modules"
VALUE_FILE="$HOME/Tools/terraform-state-importer/$1/values"

STATE_LIST_COMMAND="terraform state list"
GET_STATE_COMMAND="$STATE_LIST_COMMAND > $STATE_FILE"
echo "Validating.. $GET_STATE_COMMAND"
eval "$GET_STATE_COMMAND"
echo "Validated."

case "$2" in
    -i) operation="import"; shift 2;;
    -l) operation="state-list"; shift 2;;
    -rm) operation="state-rm"; shift 2;;
esac

trap "exit" INT
if [ $operation = "import" ]; then
  while read -r m v
  do
    if grep -Fxcq "$m" $STATE_FILE ;
    then
      continue
    else
      IMPORT_COMMAND="terraform import '$m' $v"
      echo "-- Importing.. $m"
      if eval "$IMPORT_COMMAND"; then
        echo "-- $m imported."
        (( imported_count++ ))
      fi
    fi
    ((count++))
  done < <(paste "$MODULE_FILE" "$VALUE_FILE")
  if [ "$imported_count" = 0 ]; then
    echo "Nothing imported"
  fi
elif [ $operation = "state-list" ]; then
  echo "List of imported state."
  eval "cat $STATE_FILE"
elif [ $operation = "state-rm" ]; then
  while read -r m
  do
    if grep -Fxcq "$m" $STATE_FILE ;
    then
      STATE_RM_COMMAND="terraform state rm '$m'"
      echo "-- Removing.. $m"
      if eval "$STATE_RM_COMMAND"; then
        echo "-- $m already removed."
        ((removed_count++))
      fi
    fi
    ((count++))
  done < <(paste "$MODULE_FILE")
  if [ "$removed_count" = 0 ]; then
    echo "Nothing removed"
  fi
else
  echo "Wrong arguments."
fi

echo "--------------------------------------------------------------------------"
echo "Total operation: $count, imported: $imported_count, removed: $removed_count"