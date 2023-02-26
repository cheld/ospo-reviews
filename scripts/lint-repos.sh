#!/bin/bash
cd "$(dirname "$0")"
rm -Rf ../results
REPOS=../config/repos.yaml

#Check if all repos comply with project guidelines
number_of_repos_to_be_linted=`yq "[ . | to_entries | .[] | {.key: .value.[]} ] | length - 1" <$REPOS ` 
for i in `seq 0 $number_of_repos_to_be_linted`; do
    org=`yq "[ . | to_entries | .[] | {.key: .value.[]} ]  | .[$i] | keys | .[0]" <$REPOS` 
    repo=`yq "[ . | to_entries | .[] | {.key: .value.[]} ] | .[$i].* " <$REPOS`

    echo  "Linting $org/$repo..."
    mkdir -p ../results/$org
    
    repolinter -g https://github.com/$org/$repo -f markdown> ../results/$org/$repo.md
    if [ $? -eq 1 ] && [ $1 == "--create-issues" ]; then
        echo "The repository $repo does not aligned with repository best practices."
        result=`cat ../results/$org/$repo.md`
        gh issue create --title "Repo linting error" --body="$result" --repo "$org/$repo"
    fi
done