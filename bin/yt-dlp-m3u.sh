#! /usr/bin/env bash

usage() {
    echo "Usage: $0 --url URL --output PATH"
    exit 1
}

# Parse arguments
OPTS=$(getopt \
           -o u:o: \
           -l url:,output: \
           -n "$0" \
           -- "$@"
    )

if [[ $? -ne 0 ]]; then
    usage
fi

eval set -- "$OPTS"

url=""
output=""

while true; do
    case "$1" in
        -u|--url)
            url="$2"
            shift 2
            ;;
        -o|--output)
            output="$2"
            shift 2
            ;;
        --)
            shift
            break
            ;;
        *)
            usage
            ;;
    esac
done

# Mandatory argument check
if [[ -z "$url" ]]; then
    echo "Error: --url is required." >&2
    usage
fi

if [[ -z "$output" ]]; then
    echo "Error: --output is required." >&2
    usage
fi

echo "URL: $url"
echo "Output: $output"
echo "======================="

yt-dlp -f "bv*+ba/best" --merge-output-format mp4 --remux-video mp4  --postprocessor-args "ffmpeg:-movflags +faststart" -o "${output}"   "${url}"



