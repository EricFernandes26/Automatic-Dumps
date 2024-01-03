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

# Performing Backups
The script goes through the list of databases and creates a backup file for each of them.

```powershell
foreach ($database in $databases) {
    # Construindo o nome do arquivo de saída
    $outputFile = Join-Path -Path $outputDirectory -ChildPath "$database.dump"

    # Caminho para o executável pg_dump.exe
    $pgDumpCommand = "C:\Program Files\PostgreSQL\16\bin\pg_dump.exe"

    # Construindo a string de comando para pg_dump
    $pgDumpArguments = "-h $hostname -p $port -U $username -d $database -F c -b -v -f $outputFile"

    # Executando o comando pg_dump
    Start-Process -FilePath $pgDumpCommand -ArgumentList $pgDumpArguments -Wait -NoNewWindow
}
```
Backup files are saved in the C:\BackupsPG directory. This process is useful to ensure the security and integrity of data stored in PostgreSQL databases.
