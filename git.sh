Git

	The master is a one long gathering of all other branches. 
	You make changes in each branch with commits, then inject that into master.

	When we give $ git checkout a branch name instead of a commit identifier, git checkout knows to checkout the latest commit for that branch.
	This commit is referred to as the head commit for the branch.

	// Git basics:

		cd ~
		git --version
		git init myRep
		git config --global user.name "benqzq"
		git config --global user.email "benqzq@gmail.com"
		git status 
		git log
		
		cat > ./readme <<< 'Hi!'
		git add readme # Staging area.
		git commit readme -m "commited" || git commit -a -m "commited"

		git checkout -b BRNACHNAME
		git checkout # Back to master branch.
		git branch # List all brnaches in a rep.

		# Latest commit in a branch --- HEAD~0
		# HEAD detachment --- Any commit outside

		git checkout HEAD~0
		git checkout HEAD~1
		git stash

	# GIT MERGING:

		git checkout master
		git merge rewrite_main_page
		git merge rewrite_about_page

		# A conflict is when we merge 2 brnaches with changes IN THE Same line OF THE same file, to the third.
		# Keep the text you'ld like from the 2 branches, to be merged into the third (delete heading, separator, and unwanted text).
		# After pulling or pushing there might be conflicts. Solve these via text editor (see instructions above).

	# REMOTE REPOSITORIES (local/wide):

		# 1. Cloning:

			git clone ~/myRep1 ~/myRep2
			cd ~/myRep2
			git remote # stdout === origin (myRep2 is originated in myRep1. The same wont happen for git remote in myRep1).
		
		# 2. Association (add myClone as remote of origin):

			cd ~/myRep1
			git remote add myClone ~/myRep2
			git remote # stdout === myClone
			# git remote add tommy http://tommysgitstuff.com/git_basics/cool_stuff.git

		# 3. Pull from origin:

			git pull origin new_feature # new_feature === branch.

		# 4. Make changes in the branch.

		# 5. Push to origin:

			git push origin new_feature # new_feature === branch.

	# GIT CONFLICTS:

		#1. X and Y came to change a passage in file with 0 commits in the same time.
		#2. Y finished before X and added commit 1 to that file.
		#3. X tried to change the file but it was too late.
		#4. X was asked by Git to rechange the passage, and save the file.

	# GIT FLOW:

		git flow init myRep 				# New rep.
		git flow feature start myFeature 	# New feature.
		git flow hotfix start myBug		 	# New hotfix for a feature.
		git flow hotfix finish myBug		# Finish hotfix work.
		git flow feature finish myFeature	# Finish whole work and merge back to master.

	# GITHUB:

		git remote add origin https://github.com/alysonla/portfolio.git # Add the remote repo "origin" to communicate with it.
		git push origin master # Push master of local, current repo, to origin.
		git push origin add-readme # Instead pusing our master, we pushed only add-readme (a branch in which we added a readme).

		git add checkout functionality to store # Pull request, please add my "checkout functionality" brnach to your store branch.
		git fetch # Review a branch, than do git checkout to actually save it as a branch in your projcet.