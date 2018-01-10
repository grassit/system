Basic characters to match with:

    NMC
    . ?
    () [] {}
    ^ $ *
    |
    \

Notable combos:

    .* 
    ^xyz .* # All that starts with xyz and all after it in that line.
    \w
    \s
    \K

Notes:

    # The dot says "any character." The asterisk says "Match till end of line."
    # sed -i == sed inverbose.
