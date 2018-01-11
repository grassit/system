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
    \K      # Negate all before it, in that line, so the bring all that is after it.

Notes:

    # The dot says "Match any character." The asterisk says "Repeat previous matching pattern till the end of line."
    # sed -i == sed inverbose.
