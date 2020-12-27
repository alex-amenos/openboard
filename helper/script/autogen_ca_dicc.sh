#!/bin/bash

cd ./assets

echo "Generating ca_frequency_words.combined file..."
cat ca_frequency_words.txt | tail -n +2 | awk '{print " word="$1", f="$2}' >  ca_wordlist_parsed_1.combined
# unix timestamp
date +%s
echo "ca_frequency_words_parsed.combined generated..."

echo ""
echo "Parsing ca_wordlist_parsed_1.combined file..."
perl parser.pl ca_wordlist_parsed_1.combined > ca_wordlist_parsed_2.combined
echo "Parsed ca_wordlist_parsed_1.combined to ca_wordlist_parsed_2.combined file..."

echo ""
echo "Generating ca_wordlist.combined file..."
echo "dictionary=main:ca,locale=ca,description=Català wordlist by Àlex Amenós,date=1609099824,version=1" > ca_wordlist.combined
cat ca_wordlist_parsed_2.combined >> ca_wordlist.combined

echo ""
echo "Creating main_ca.dict file..."
java -jar dicttool_aosp.jar makedict -s ca_wordlist.combined -d main_ca.dict
echo "Created main_ca.dict file..."

echo ""
echo "Cleaning files"
rm -r ca_wordlist_parsed_1.combined
rm -r ca_wordlist_parsed_2.combined
rm -r ca_wordlist.combined
echo "Cleaned files"

echo ""
echo "Move main_ca.dict to app/src/main/res/raw folder"