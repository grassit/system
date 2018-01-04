FD 0 - stdin
FD 1 - stdout
FD 2 - stderr

2>1 may look like redriecting stderr to stdin but it actually says "redirect to a file named 1".
    Thus, the needed is 2>&1

&, in that sense, indicates that follows is a file descriptor and not a filename.