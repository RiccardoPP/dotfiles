#!/bin/bash
#
# Riccardo Palombo - https://riccardo.im
# Preparato per la community Patreon: patreon.com/riccardopalombo
# Basato su: https://github.com/claudiodangelis/rofi-todo
#

TODO_FILE=~/.rofi_todos # Percorso di salvataggio delle note

if [[ ! -a "${TODO_FILE}" ]]; then
    touch "${TODO_FILE}"
fi

function add_todo() {
    echo -e "`date +"%d %B %Y "` $*" >> "${TODO_FILE}"
}

function remove_todo() {
    sed -i "/^${*}$/d" "${TODO_FILE}"
}

function get_todos() {
    echo "$(cat "${TODO_FILE}")"
}

if [ -z "$@" ]; then
    get_todos
else
    LINE=$(echo "${@}" | sed "s/\([^a-zA-Z0-9]\)/\\\\\\1/g")
    LINE_UNESCAPED=${@}
    if [[ $LINE_UNESCAPED == +* ]]; then
        LINE_UNESCAPED=$(echo $LINE_UNESCAPED | sed s/^+//g |sed s/^\s+//g )
        add_todo ${LINE_UNESCAPED}
    else
        MATCHING=$(grep "^${LINE_UNESCAPED}$" "${TODO_FILE}")
        if [[ -n "${MATCHING}" ]]; then
            remove_todo ${LINE_UNESCAPED}
        fi
    fi
    get_todos
fi
