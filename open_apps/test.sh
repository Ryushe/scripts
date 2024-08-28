input="profile1"

# Extract the number at the end
number="${input//[!0-9]/}"

# Capitalize the first letter and combine with the number
output="Profile $number"

echo "$output"
