#!/usr/bin/env bash
rows=0
cols=0
progress_row=0
scroll_bottom=0
processed=0
total=0

get_terminal_size() {
    rows=$(tput lines)
    cols=$(tput cols)

    if (( rows < 4 )); then
        echo "Terminal is too small." >&2
        exit 1
    fi

    progress_row=$((rows - 1))
    scroll_bottom=$((rows - 2))
}

setup_terminal() {
    get_terminal_size

    tput clear
    tput civis

    # Reserve all lines except the last one for scrolling output.
    # Last row is used only for the progress bar.
    tput csr 0 "$scroll_bottom"
    tput cup 0 0
}

restore_terminal() {
    local last_row

    last_row=$(( $(tput lines) - 1 ))

    # Restore normal full-screen scrolling.
    tput csr 0 "$last_row"
    tput sgr0
    tput cnorm

    # Keep the final progress bar visible.
    # Move to the line below it by printing a newline from the progress row.
    tput cup "$last_row" 0
    printf '\n'
}

draw_progress() {
    local done_count="$1"
    local total_count="$2"
    local status="${3:-}"

    local percent=0
    if (( total_count > 0 )); then
        percent=$((done_count * 100 / total_count))
    fi

    local suffix=" ${percent}% (${done_count}/${total_count}) ${status}"
    local bar_width=$((cols - ${#suffix} - 3))

    if (( bar_width < 10 )); then
        bar_width=10
    fi

    local filled=$((percent * bar_width / 100))
    local empty=$((bar_width - filled))

    local fill_part
    local empty_part

    printf -v fill_part '%*s' "$filled" ''
    printf -v empty_part '%*s' "$empty" ''

    fill_part=${fill_part// /#}
    empty_part=${empty_part// /-}

    # Save cursor, draw on bottom line, then restore cursor.
    tput sc
    tput cup "$progress_row" 0
    tput el
    printf '[%s%s]%s' "$fill_part" "$empty_part" "$suffix"
    tput rc
}

handle_resize() {
    get_terminal_size
    tput csr 0 "$scroll_bottom"
    draw_progress "$processed" "$total" "resized"
}
