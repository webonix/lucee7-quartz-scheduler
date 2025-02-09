#!/bin/bash
COMMAND=$1
VALUE=$2


# Example usage:
# open_in_chrome "https://example.com"
open_in_chrome() {
    local URL="$1"

    osascript <<EOF
tell application "Google Chrome"
    set targetURL to "$URL"
    set foundTab to false
    set foundWindowIndex to 0
    set foundTabIndex to 0

    repeat with w from 1 to (count of windows)
        set tabIndex to 1
        repeat with t in tabs of window w
            if URL of t starts with targetURL then
                set foundTab to true
                set foundWindowIndex to w
                set foundTabIndex to tabIndex
                exit repeat
            end if
            set tabIndex to tabIndex + 1
        end repeat
        if foundTab then exit repeat
    end repeat

    if foundTab then
        tell window foundWindowIndex
            set active tab index to foundTabIndex
            set index to 1
        end tell
    else
        open location targetURL
    end if
end tell

# Bring Chrome to the front
tell application "Google Chrome" to activate
EOF
}


# Check the command provided by the user
case "$COMMAND" in
    build)
        docker compose down -v
        rm -rf ./lucee/lucee-server/
        rm -rf ./lucee/lucee-web/

        docker compose up -d --build 

        open_in_chrome "http://127.0.0.1:8888/index.cfm"
        ;;
    
    build-no-cache)
        docker compose up -d --build --no-cache
        rm -rf ./lucee/lucee-server/
        rm -rf ./lucee/lucee-web/

        docker compose up -d --build 

        open_in_chrome "http://127.0.0.1:8888/index.cfm"
        ;;

    up)
        docker compose up -d 

        open_in_chrome "http://127.0.0.1:8888/index.cfm"
        ;;

    restart)
        docker compose down -v
        docker compose up -d 

        open_in_chrome "http://127.0.0.1:8888/index.cfm"
        ;;

    scale)
        docker compose up -d --scale lucee-worker=$VALUE
        ;;

    down)
        docker compose down -v
        rm -rf ./lucee/lucee-server/
        rm -rf ./lucee/lucee-web/
        ;;

    log)
        docker compose logs -f 
        ;;

    docker-clean-up)
        docker builder prune --force
        docker system prune --all --volumes --force
        ;;

    *)
        echo "Usage: $0 {build|up|down|restart|scale 3|log}"
        exit 1
        ;;
esac




