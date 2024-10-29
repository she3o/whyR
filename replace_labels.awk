#!/usr/bin/awk -f

BEGIN {
    srand()  # Initialize random number generator
}

# Function to generate a random alphanumeric string of length 8
function randstr(n,   i, chars, s) {
    chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    s = ""
    for (i = 1; i <= n; i++) {
        s = s substr(chars, int(rand() * length(chars)) + 1, 1)
    }
    return s
}

{
    # If the line matches the label pattern
    if ($0 ~ /^#\| label: .*/) {
        newlabel = randstr(8)  # Generate a random label
        sub(/^#\| label: .*/, "#| label: " newlabel)  # Replace the label
    }
    print  # Print the modified or original line
}

