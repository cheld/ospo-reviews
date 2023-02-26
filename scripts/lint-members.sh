#!/bin/bash
cd "$(dirname "$0")"

MEMBERS=../config/members.yaml

#Check if all members have Allianz email
number_of_failed_members=`yq -o json ". | with_entries(select(.value != \"*@*allianz*\")) | keys | length - 1" <$MEMBERS ` 
for i in `seq 0 $number_of_failed_members`; do
    member_name=`yq -o json ". | with_entries(select(.value != \"*@*allianz*\")) | keys | .[$i]" <$MEMBERS `

    echo "Error: $member_name must use Allianz email"
    exit 1
done