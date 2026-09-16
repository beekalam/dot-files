#!/bin/bash


# Function to display help
usage() {
    echo "Usage: $0 [OPTIONS]"
    echo
    echo "Required options:"
    echo "  -t, --window-title TITLE   Window title to search for"
    echo "  -s, --sleep SECONDS        Sleep interval between checks"
    echo "  -o, --output-dir DIR       Directory to save screenshots"
    echo
    echo "Other options:"
    echo "  -h, --help                 Show this help message"
    echo
    echo "Example:"
    echo "  $0 -t \"Grok\" -s 0.5 -o ./screenshots"
    echo "  $0 --window-title \"Grok\" --sleep 0.5 --output-dir ./screenshots"
}

# Parse command line arguments with getopt
TEMP=$(getopt -o t:s:o:h --long window-title:,sleep:,output-dir:,help -n "$(basename "$0")" -- "$@")

if [ $? -ne 0 ]; then
    echo "Error: Failed to parse options." >&2
    usage
    exit 1
fi

# Reset positional parameters
eval set -- "$TEMP"

# Initialize variables (empty)
window_title=""
sleep=""
output_dir=""

# Process options
while true; do
    case "$1" in
        -t|--window-title)
            window_title="$2"
            shift 2
            ;;
        -s|--sleep)
            sleep="$2"
            shift 2
            ;;
        -o|--output-dir)
            output_dir="$2"
            shift 2
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        --)
            shift
            break
            ;;
        *)
            echo "Internal error!" >&2
            exit 1
            ;;
    esac
done

# Check that all required arguments were provided
if [[ -z "$window_title" || -z "$sleep" || -z "$output_dir" ]]; then
    echo "Error: All arguments are required." >&2
    echo
    usage
    exit 1
fi

# Create output directory
mkdir -p "$output_dir"

echo "Monitoring window: \"$window_title\""
echo "Sleep interval: ${sleep}s"
echo "Output directory: $output_dir"
echo "Press Ctrl+C to stop"
echo "----------------------------------------"

while true; do
    if wmctrl -l | grep -qi "${window_title}"; then
        echo "${window_title} exists"

        # Get the first matching window ID
        win_id=$(wmctrl -l | grep -i "${window_title}" | awk '{print $1}' | head -n1)

        # Create a unique filename with timestamp
        timestamp=$(date +%Y%m%d_%H%M%S_%N)
        filename="${output_dir}/grok_${timestamp}.png"

        # Take the screenshot of the specific window
        import -window "$win_id" "$filename"

        echo "Screenshot saved → $filename"
    else
        echo "does not exist"
    fi
    sleep "${sleep}"
done

