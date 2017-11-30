Mysql CLI

	mysql -u root -p

	show databases;
	SELECT user FROM mysql.user;

		create user '${DOMAIN}'@'localhost' identified by 'mypassword';
		create database ${DOMAIN};
		GRANT ALL PRIVILEGES ON ${DOMAIN}.* TO ${domain}@localhost;
		show grants for '${DOMAIN}'@'${DOMAIN}';

	drop database ${DOMAIN};
	drop user '${DOMAIN}'@'localhost';

	# Notes:

		#  REVOKE [type of permission] ON [database name].[table name] FROM ‘[username]’@‘localhost’;
		# Never forget delimiting (;).

SQL

	/* AS, AND, OR */

		SELECT * FROM results WHERE away_team = "Hessle" AND played_on >= "2015-10-01"; /* >= means ON OR AFTER */
		SELECT first_name AS "First Name", last_name AS "Last Name" FROM users WHERE username = "sosoMania" AND usertype = "niceUser";
		SELECT first_name, last_name FROM users WHERE username = "sosoMania" OR sallaryUSD = "5000";

	/* IN, NOT IN, BETWEEN */

		SELECT * FROM products WHERE price IN (7.99, 9.99);
		SELECT * FROM products WHERE price NOT IN (7.99, 9.99);
		SELECT * FROM results WHERE played_on BETWEEN "2015-09-01" AND "2015-09-30";

		/* SELECT name, description FROM products WHERE price BETWEEN 0.01 AND 9.99; */

	/* LIKE and its wildcards */

		SELECT * FROM users WHERE username LIKE "tion%"; /* Find all usernames starting with the phrase. */
		SELECT * FROM users WHERE username LIKE "%tion"; /* Find all usernames ending with the phrase. */
		SELECT * FROM users WHERE username LIKE "%tion%"; /* Find all usernames with the prhase anywhere. */

	/* The IS keyword */

		SELECT * FROM phone_book WHERE phone IS NULL
		SELECT last_name FROM phone_book WHERE last_name IS NOT NULL;

	/* Vertical syntax */

		SELECT * FROM table1, table2
		WHERE table1.first_name = table2.first_name;

			/* All rows which has similar values in both first_name and first_name, will appear */