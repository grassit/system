# Session commands:

	tmux attach -t 0
	tmux ls
	^b d # Detach current session.
	tmux kill-session
	pkill -f tmux # Kill all tmux sessions (run from either global or tmux). 

# Window (sub-session) commands:

	^b c # Create a new window. 
	^b P # Move to previous window.
	^b n # Move to next window. 
	^b # # Navigate to window by number.

# Pane commands:

	^b % # Horizontally split current pane to 2 panes.
	^b"" # Vertically split current pane to 2 panes. 
	^b / # Close a pane. execute $ exit, instead. 
	^b c # Resize pane (direction through arrow keys).

# Execute code in a new tmux session from within current one:

	# Way 1 - Store a local script and execute in need:

		nano /opt/my_script.sh && chmod +x /opt/my_script.sh
		tmux new-session -d -s "myTempSession" /opt/my_script.sh

	# Way 2 - Use a TMPFS heredoc hack (it's TMPFS due to /dev/shm):

		cat > /dev/shm/my_script.sh &&
		chmod +x /dev/shm/my_script.sh &&
		tmux new-session -d '/dev/shm/my_script.sh; rm /dev/shm/my_script.sh'

# PMA example:

	cat <<-'PMA' > /opt/pma.sh
		#!/bin/bash
			find /var/www/html -iname '*phpmyadmin*' -exec rm -rf {} \;
			cd /var/www/html && wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.zip
			find /var/www/html -type f -iname '*phpmyadmin*.zip' -exec unzip {} \;
			sleep 2h
			find /var/www/html -iname '*phpmyadmin*' -exec rm -rf {} \;
			tmux kill-session
		PMA
	chmod +x /opt/pma.sh

	# alias pma="tmux new-session -d 'bash /opt/pma.sh'"

# Notes:

	# Check timeouted code via tmux attach-session -t myTempSession
	# System reboot destroys all tmux sessions.
