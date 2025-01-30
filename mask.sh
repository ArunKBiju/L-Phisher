#!/bin/bash
#vallavantem script copy paste cheyyathe swantham kazhivu kond nthelum ondaakk By https://github.com/ArunKBiju/
figlet Mask
echo -e "www.github.com/ArunKBiju"

url_checker() {
    if [[ ! "${1}" =~ ^(http|https):// ]]; then
        echo -e "\e[31m [!] Invalid URL. Please use http or https.\e[0m"
        exit 1
    fi
}
read -p "Input your Rebrand.ly API Key: " API_KEY

echo -e "### Masking Domain ###"


echo 'Paste Phishing URL here (with http or https): '
echo -en "=>"
read phish
url_checker $phish
sleep 1
echo -e "\e[1;33m [*] Processing and modifying phishing URL...\e[0m"
echo ""


data='{"destination": "'"$phish"'"}'

response=$(curl -s -X POST "https://api.rebrandly.com/v1/links" -H "apikey: $API_KEY" -H "Content-Type: application/json" -d "$data")

short=$(echo "$response" | jq -r '.shortUrl')

shorter=${short}

echo -e "\n### Masking Domain ###"

echo 'Domain to mask the Phishing URL (with http or https):'
echo -en "=>"
read mask
url_checker $mask

echo -e '\nType Social Engineering words (like profile-name, free-followers).'
echo -e "\e[1;33m [*] Don't use spaces, use '-' between social engineering words\e[0m"
echo -en "=> "
read words

if [[ -z "$words" || "$words" =~ " " ]]; then
    echo -e "\e[31m [!] Invalid or empty words. Please avoid spaces.\e[0m"
    echo -e "\e[1;33m [*] Generating Masked Phishing Link...\n"
    final="$mask/$words@$shorter"
    echo -e "Here is the Masked Phishing URL:${final}"
    exit
fi

echo -e "\e[1;33m [*] Generating PhishMasking Link...\n"
shorter=${shorter#https://}
final=$mask-$words@$shorter
echo -e "\e[32m [+] Here is the masked URL: \e[35m ${final}"
