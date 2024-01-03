#  -----------DUMPS-----------------------------------------------------

# Defina as variáveis comuns
$hostname = "localhost"
$port = "5432"
$username = "*"
$password = "*"

# Lista de bancos de dados
$databases = @("dvdrental", "db2", "db3", "db4")



# Diretório de saída comum para os dumps
$outputDirectory = "C:\BackupsPG"

foreach ($database in $databases) {
    # Construa o nome do arquivo de saída com base no nome do banco de dados
    $outputFile = Join-Path -Path $outputDirectory -ChildPath "$database.dump"

    # Caminho completo para o executável pg_dump.exe
    $pgDumpCommand = "C:\Program Files\PostgreSQL\16\bin\pg_dump.exe"

    # Construa a string de comando para pg_dump
    $pgDumpArguments = "-h $hostname -p $port -U $username -d $database -F c -b -v -f $outputFile"

    # Execute o comando pg_dump
    Start-Process -FilePath $pgDumpCommand -ArgumentList $pgDumpArguments -Wait -NoNewWindow
}
