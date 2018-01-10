# Git head (lowercase) is the last commit of a given branch.
# Git HEAD (uppercase) is current commit.

	cd ~
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

	git checkout HEAD~0
	git checkout HEAD~1
	git stash

# GIT MERGING (and conflicts):

	git checkout master
	git merge rewrite_main_page
	git merge rewrite_about_page

	# A conflict is when we merge 2 brnaches with changes in same line of the same file, to a third.
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

# GITHUB:

	git remote add origin https://github.com/alysonla/portfolio.git # Add the remote repo "origin" to communicate with it.
	git push origin master # Push master of local, current repo, to origin.
	git push origin add-readme # Instead pusing our master, we pushed only add-readme (a branch in which we added a readme).

	git add checkout functionality to store # Pull request, please add my "checkout functionality" brnach to your store branch.
	git fetch # Review a branch, than do git checkout to actually save it as a branch in your projcet.