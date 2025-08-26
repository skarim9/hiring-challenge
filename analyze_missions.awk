#!/usr/bin/awk -f

BEGIN {
    # Initialize variables
    max_duration = 0
    security_code = ""
    FS = "|"  # Set field separator to pipe character
}

# Skip comment lines and empty lines
/^#/ || /^$/ {
    next
}

# Process data lines
NF >= 8 {
    # Remove leading/trailing whitespace from fields
    for (i = 1; i <= NF; i++) {
        gsub(/^[ \t]+|[ \t]+$/, "", $i)
    }
    
    # Extract fields
    date = $1
    mission_id = $2
    destination = $3
    status = $4
    crew_size = $5
    duration = $6
    success_rate = $7
    sec_code = $8
    
    # Check if this is a completed Mars mission
    if (status == "Completed" && destination == "Mars") {
        # Convert duration to number and compare
        duration_num = duration + 0
        if (duration_num > max_duration) {
            max_duration = duration_num
            security_code = sec_code
        }
    }
}

END {
    if (security_code != "") {
        print security_code
    } else {
        print "No completed Mars missions found"
    }
}
