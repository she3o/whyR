#!/usr/bin/awk -f

BEGIN {
    srand()  # Initialize random number generator
    in_code_block = 0
    first_line_in_chunk = 0
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
    # Check for code chunk start
    if ($0 ~ /^```{[^}]*}$/) {
        in_code_block = 1
        first_line_in_chunk = 1
        print  # Print the code chunk start line
        next
    }

    # Check for code chunk end
    if ($0 ~ /^```$/) {
        in_code_block = 0
        print  # Print the code chunk end line
        next
    }

    if (in_code_block) {
        if (first_line_in_chunk) {
            if ($0 ~ /^#\| label: .*/) {
                # Replace the label
                newlabel = randstr(8)  # Generate a random label
                sub(/^#\| label: .*/, "#| label: " newlabel)
                print
            } else {
                # Insert a label comment
                newlabel = randstr(8)
                print "#| label: " newlabel
                print $0
            }
            first_line_in_chunk = 0
        } else {
            print  # Print the line as is
        }
    } else {
        print  # Outside code chunk, print the line as is
    }
}

