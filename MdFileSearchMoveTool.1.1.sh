# ------------------------------------------------------------------------------------------
# MdFileSearchMoveTool.sh automates the process to search the contents of the directory which
# this script is in and move all found files to a specified directory
# - If directory doesn't exist, create directory
# v1.1
# ------------------------------------------------------------------------------------------

mdFileNames=($(ls *.md))
destination="./destination"
declare -a foundFiles
if [ ! -d "$destination" ]; then
  mkdir $destination
fi
echo Enter search word:
read searchWord
searchWordUpper=$(echo $searchWord | tr '[:lower:]' '[:upper:]')
echo ...searching...
for i in "${!mdFileNames[@]}"
do
    fileContent=$(<${mdFileNames[$i]})
    fileContentUpper=$(echo $fileContent | tr '[:lower:]' '[:upper:]'
    if [[ $fileContentUpper == *$searchWordUpper* ]]; then
        foundFiles+=(${mdFileNames[$i]})
    fi
done

foundFilesLength=${#foundFiles[@]}
echo "Files found: $foundFilesLength"
for i in "${!foundFiles[@]}"
do
    echo "moving ${foundFiles[$i]} to $destination"
    mv "./${foundFiles[$i]}" "$destination"
done
echo Done
