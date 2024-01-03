# Automatic-Dumps

The powershell scripts in this repository are intended to automate the task of backing up your PostgreSQL databases.

# PostgreSQL Database Backup

This PowerShell script is used to make backups (dumps) of PostgreSQL databases using the `pg_dump` tool. Let's understand what each part does:

## Initial setting
We define some basic information, such as the server name (`localhost`), port (`5432`), username (asterisk indicates that the password will be requested manually) and a list of databases to be included in the backup.

```powershell
$hostname = "localhost"
$port = "5432"
$username = "*"
$password = "*"
$databases = @("dvdrental", "db2", "db3", "db4")
$outputDirectory = "C:\BackupsPG"
```
