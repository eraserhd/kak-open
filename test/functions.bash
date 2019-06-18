TEST_COUNT=0
TESTS_FAILED=0
TEST_OK=true

h2() {
    printf '\n \e[33;1m%s\e[0m\n' "$1"
}

h3() {
    printf '   \e[33m%s\e[0m\n' "$1"
}

fail() {
    if $TEST_OK; then
        printf '\e[31;1mfailed\e[0m\n'
    fi
    TEST_OK=false
    local escaped_out="$TEST_OUT"
    escaped_out="${escaped_out///\\x0E}"
    escaped_out="${escaped_out///\\x0F}"
    printf '      Assertion: \e[31m%s\e[0m\n' "$*"
    printf "       Commands:\n"
    cat test/9commands.txt
    printf "          Debug:\n"
    cat test/debug.txt
    printf '\n'
}

t() {
    local description="$1"
    shift
    printf '     %s ... ' "$description"

    TEST_COUNT=$(( TEST_COUNT + 1 ))
    if $TEST_OK; then
        printf 'ok\n'
    else
        TESTS_FAILED=$(( TESTS_FAILED + 1 ))
    fi
}

summarize() {
    local color=''
    if (( TESTS_FAILED > 0 )); then
        color="$(printf '\e[31;1m')"
    fi
    printf '\n%s%d tests, %d failed.\e[0m\n' "$color" $TEST_COUNT $TESTS_FAILED
}
