# Automatic-Dumps

The powershell scripts in this repository are intended to automate the task of backing up your PostgreSQL databases.
Note:

1 - Create a folder in C: called BackupsPG so the script will run without problems

2 - Remember to access Windows PowerShell in the directory where the pg_dump and pg_restore executables are located on Windows, which is found in the path C:\Program Files\PostgreSQL\16\bin>

3 - After entering the directory you can copy and paste the scripts into this directory

![image](https://github.com/EricFernandes26/Automatic-Dumps/assets/83287307/471c096e-fcb7-43c4-972a-d4818217a6e2)


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



#Restoration of PostgreSQL Databases
This PowerShell script is used to restore PostgreSQL databases from previously created backups. Let's understand each part of the script:

# Initial setting
We define important information, such as the source directory of the backups (C:\BackupsPG), the IP address of the destination server for the restore (* indicates that it must be provided manually), port (5432), username (asterisk indicates that the password will be requested manually) and a list of databases to be restored.

```powershell
# Defina as variáveis comuns
$sourceDirectory = "C:\BackupsPG"
$destinationHostname = "*" # Coloque o IP do servidor de destino no restore
$destinationPort = "5432"
$destinationUsername = "*"
$destinationPassword = "*"
$databases = @("dvdrental", "db2", "db3", "db4")
```

# Database Restoration
The script goes through the list of databases and performs the restore for each of them.

```powershell
foreach ($database in $databases) {
    # Construindo o caminho do arquivo de entrada
    $inputFile = Join-Path -Path $sourceDirectory -ChildPath "$database.dump"

    # Caminho completo para o executável pg_restore.exe no servidor de destino
    $pgRestoreCommand = "C:\Program Files\PostgreSQL\16\bin\pg_restore.exe"

    # Construindo a string de comando para pg_restore
    $pgRestoreArguments = "-h $destinationHostname -p $destinationPort -U $destinationUsername -d $database -v `"$inputFile`""

    # Executando o comando pg_restore
    Start-Process -FilePath $pgRestoreCommand -ArgumentList $pgRestoreArguments -Wait -NoNewWindow
}
```
The backup files are located in the C:\BackupsPG directory, and the restore is done to the specified destination server. This process is essential for recovering data from backups and restoring the functionality of PostgreSQL databases.
