#!/usr/bin/env bash
function write_repo_history {
	git -C $1 fetch
	repo_name=$(basename $(git -C $1 remote get-url origin) .git)
	string=$(git -C $1 log --pretty="format:%<(20)%ae %<(20)%ai %<(20) %s" --all --since="last week")
	len=`expr length "$string"`
	if [ ! $len -eq 0 ]; then
		echo -e "REPO: $repo_name\n$string\n" >> git-log-`date -I`.txt
	fi	
	
}

function check_repo {
	if [ -d "$1" ]; then
		if git -C $1 rev-parse --git-dir > /dev/null 2>&1; then
			echo "This is a git repo: $1"
			write_repo_history $1
		fi
		
	fi
}
	

if [ -f "git-log-`date -I`.txt" ]; then
	rm git-log-`date -I`.txt
fi
while getopts "r:" opt; do
	case $opt in
		r) 
		set -f
		IFS=' '
		repos+=($OPTARG);;
	esac
done
if [ ${#repos[@]} -eq 0 ]; then
	for f in *; do
		check_repo $f
	done
else
	for repo in "${repos[@]}"; do
		check_repo $repo
	done
fi

