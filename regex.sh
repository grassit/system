Basic characters to match with:

    NMC
    . ?
    () [] {}
    ^ $ *
    |
    \

Notable combos:

    .* 
    ^xyz .* # All that starts with xyz and a space, and all after it in that line.
    \w
    \s
    \K

Notes:

    # The dot says "Match any character." The asterisk says "Repeat previous matching pattern till the end of line."
    # sed -i == sed inverbose.
