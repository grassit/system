# Variables:

	# In Variable substitution we substitute a parameter's variable (and its syntax) in its value passed as an argument in execution.
		ls -l $dir/*$.ext
			# In parsing it becomes:
				ls + -l + $dir/*$.ext
			# If the value of dir is some/path and the value of ext is txt, than the shell rwrites:
				$dir/*.$ext ==> some/path/*.txt
			# Each variable was substituted with its value.

			# Variable substition isn't variable assingment. The variable value will stay the same. in substitution of what's being presented last.
			

	export var1='123' # Glob var.
	var2='456' # loc var.

# Bash quote laws:

	a='123'

	echo '${a}' 		  # ${a}
	echo "${a}" 		  # 123
	echo " ${a}-"456" "   # 123-456
	echo " ${a}-\"456\" " # 123-"456"

# Printing an array:

	DOMAIN=('abc.com' 'def.com')
	echo DOMAIN 										# Only ab.com will come out.
	for domain in ${DOMAIN[@]}; do echo $domain; done 	# All 3 will come out.

# Output redirections

	FD 0 is stdin.
	FD 1 is stdout.
	F2 2 is stderr.

	2>1 may look like a good way to redirect stderr to stdout.
		However, it will actually be interpreted as "redirect stderr to a file named 1".
			& indicates that what follows is a file descriptor and not a filename, so the right construct is 2>&1.

# Zip files:

	zip -r html.zip . # Zip current dir.
	zip x.zip INODES