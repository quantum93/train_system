In real world applications, it's essential that companies back up their data. Let's go over the process of "dumping" database data into a file and then importing that dump into a fresh database. This will be helpful for the two-day project later this week and will also be essential for backing up your data for Friday's independent project.

To back up your database, go to the root directory of your project in the terminal. Run the following command in the bash shell (not in psql):

`pg_dump train_system_test > database_backup.sql`

You should input your database name in place of [YOUR DATABASE NAME]. You can name the backup something other than database_backup.sql as long as you include the .sql extension.

pg_dump is a command that allows us to dump (or back up) the database. You can find more information about this command here.

'>' is a shell command that redirects the output of the pg_dump command into our backup file. We won't cover redirects here as they are a separate concept related to I/O (input/output), which is an essential part of bash. For now, just be aware that the output of our command would normally go somewhere else so we need to redirect that output into database_backup.sql. The end result is that our dump is "saved" to the backup file.

Now that we have a backup, we can quickly create a fresh database that includes our backup schema. Let's do that using some convenient Postgres commands that we can run directly in the terminal:

`createdb train_system_test`<br>
`psql train_system_test < database_backup.sql`<br>
`createdb -T train_system_test train_system`


createdb creates a database with the specified [DATABASE NAME]. The second line directs the database backup into the database with the specified name. createdb -T creates a test database. The first argument is the name of the database you want to copy while the second argument is the name of the test database you're creating.

These commands are easier than navigating into psql and creating databases there. You can now easily back up your database and recreate it elsewhere. You will be expected to backup your database for Friday's independent project; this makes it much easier to quickly reconstruct a database.
