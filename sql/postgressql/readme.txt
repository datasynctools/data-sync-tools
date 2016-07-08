Instructions for Mac

#PostgresSql Install

1. Download and install 'http://postgresapp.com/'

2. Start the Postgres.app and choose 'open psql'

#Database Install

3. Check the existing databases by issuing the command '\list'

If the database isn't there, install it

4. Install the new database by issuing the command:
'\i /Users/doug/Documents/GitHub/threads/src/sql/postgressql/create-database.txt'
(Change your path as needed to the source file as necessary)

#Create Tables

5. Connect to the database that was created with the following command: '\connect threads'
(where 'threads' is replaced witht he name of the database you created)
5. Check that the tables are not present the command '\dt'

If the tables are not there, install them. 
To confirm a table's definition, use the command '\d+ tablename'
To confirm a table's access privileges, use the command '\dp tablename'

6. Install the tables by the command:
'doug-# \i /Users/doug/Documents/GitHub/threads/src/sql/postgressql/create-data-sync-tools.sql'
(Change your path as needed to the source file as necessary)
(In the sql file, change the desired privileges)


#Database Drop
x. Drop the database by issuing the command:
'\i /Users/doug/Documents/GitHub/threads/src/sql/postgressql/drop-database.txt'
(Change your path as needed to the source file)
