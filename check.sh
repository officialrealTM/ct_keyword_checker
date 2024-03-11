#!/bin/bash
###################################################################
#Script Name	: ct_keyword_checker                                                                                        
#Description	: Bash Script for checking text for keywords.                                                                                                                                                                
#Author       : officialrealTM aka. realTM                                              
#Email        : support@realtm.de
#GitHub       : https://github.com/officialrealTM/ct_keyword_checker                                     
###################################################################

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <case_sensitive: true/false>"
    exit 1
fi

case_sensitive=$1
wordlist="wordlist"
textfile="textfile"
not_found_words=()

# Check if the wordlist and textfile exist
if [ ! -f "$wordlist" ] || [ ! -f "$textfile" ]; then
    echo "Error: Make sure both 'wordlist' and 'textfile' files exist."
    exit 1
fi

while IFS= read -r word; do
    if [ "$case_sensitive" = "true" ]; then
        # Case-sensitive search
        count=$(grep -o "\\b$word\\b" "$textfile" | wc -l)
    else
        # Case-insensitive search
        count=$(grep -io "\\b$word\\b" "$textfile" | wc -l)
    fi

    if [ "$count" -eq 0 ]; then
        not_found_words+=("$word")
    else
        echo "$word: $count"
    fi
done < "$wordlist"

# Check if there are any words not found and report them
if [ ${#not_found_words[@]} -ne 0 ]; then
echo ""
echo "Words not found in the text:"
    for word in "${not_found_words[@]}"; do
        echo "$word"
    done
else
    echo "All words in the wordlist were found in the text."
fi
