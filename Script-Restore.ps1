------------------------------RESTORE---------------------------------------------------------

# Defina as variáveis comuns
$sourceDirectory = "C:\BackupsPG"
$destinationHostname = "*" # Coloque o IP do servidor de destino no restore
$destinationPort = "5432"
$destinationUsername = "*"
$destinationPassword = "*"

# Lista de bancos de dados
$databases = @("dvdrental", "db2", "db3", "db4")

foreach ($database in $databases) {
    # Construa o caminho do arquivo de entrada com base no nome do banco de dados
    $inputFile = Join-Path -Path $sourceDirectory -ChildPath "$database.dump"

    # Caminho completo para o executável pg_restore.exe no servidor de destino
    $pgRestoreCommand = "C:\Program Files\PostgreSQL\16\bin\pg_restore.exe"

    # Construa a string de comando para pg_restore
    $pgRestoreArguments = "-h $destinationHostname -p $destinationPort -U $destinationUsername -d $database -v `"$inputFile`""

    # Execute o comando pg_restore
    Start-Process -FilePath $pgRestoreCommand -ArgumentList $pgRestoreArguments -Wait -NoNewWindow
}
