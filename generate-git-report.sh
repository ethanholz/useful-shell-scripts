#!/usr/bin/env bash
if [ -f "git-log-`date -I`.txt" ]; then
	rm git-log-`date -I`.txt
fi
for f in *; do
	if [ -d "$f" ]; then
		if git -C $f rev-parse --git-dir > /dev/null 2>&1; then
			echo "This is a git repo: $f"
			git -C $f fetch
			string=$(git -C $f log --pretty="format:%<(20)%ae %<(20)%ai %<(20) %s" --all --since="last week")
			len=`expr length "$string"`
			if [ ! $len -eq 0 ]; then
				echo -e "REPO: $f\n$string\n" >> git-log-`date -I`.txt
			fi
		fi
	fi
done
