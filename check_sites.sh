#!/bin/bash

#chmod +x check_sites.sh
## This script checks the availability of a list of websites and logs the results.
sites=(
    "https://www.google.com"
    "https://www.facebook.com"
    "https://www.twitter.com"
    )

# Log file to store the results
log_file="site_check.log"

# Clear the log file before starting the checks
> "$log_file"

# Function to check the availability of a website
check_site() {
    # -L іде за редиректами, -w "%{http_code}" отримує тільки код відповіді
    status_code=$(curl -L -s -o /dev/null -w "%{http_code}" --connect-timeout 5 "$1")

    if [ "$status_code" -eq 200 ]; then
        echo "<$1> is UP" >> "$log_file"
    else
        echo "<$1> is DOWN" >> "$log_file"
    fi
}

# Loop through the list of sites and check each one
for site in "${sites[@]}"; do
    check_site "$site"
done

# Print the results to the console
echo "Site availability check completed. Results logged in $log_file."
