# This script is for batch renaming lectures into specific format containing date

# Works for very specific name format
# Can mess up your files if not modified suitably
# Need to modify:
# 1. extract date from the file name
# 2. sort the filenames by date
# 3. prepend give lecture numbers to the sorted dates
# 4. take folder path as argument
# 5. https://stackoverflow.com/q/8789729/17819859

list=$(ls)
declare -i idx=0;
printf "Caution: can mess up your files.\nPress Enter if you have gone through the code. Else press Ctrl-c"
read char
for word in $list; do
	if [[ $word =~ 2022-[0-1][0-9]-[0-3][0-9] ]]; then
		size=${#word}
		idx+=1
		mv *$word* lec-${idx}_${word:1:size-1}.mp4
	fi; done
