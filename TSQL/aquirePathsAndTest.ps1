<#
    https://cmatskas.com/execute-sql-query-with-powershell/
    http://irisclasson.com/2013/10/16/how-do-i-query-a-sql-server-db-using-powershell-and-how-do-i-filter-format-and-output-to-a-file-stupid-question-251-255/
    https://social.technet.microsoft.com/wiki/contents/articles/26366.powershell-scripting-using-and-querying-datasets-directly-in-powershell.aspx
    https://stackoverflow.com/questions/804133/how-to-loop-through-a-dataset-in-powershell
    https://stackoverflow.com/questions/8423541/how-do-you-run-a-sql-server-query-from-powershell
#>

<#
This script will first try to aquire credentials for a SQL Server database, either by reading a file called creds.txt 
(in the same folder as the script), if no such file is found, it will ask for the credentials in the commandprompt.

It will then run a query to get things that looks like pathways in a Windows-environment, 
after that it will try to access these and the result of these attempts will be printed in two lists.
#>

function Invoke-SQL {
    param(
        [string] $server = $(throw "Please specify a server."),
        [string] $database = $(throw "Please specify a database."),
        [string] $username = $(throw "Please specify a username."),
        [string] $dbpwd = $(throw "Please specify a password.")
      )

    $connectionString = "Data Source=$($server); " +
                        "Initial Catalog=$($database); " +
                        "User ID=$($username); " +
                        "Password=$($dbpwd); "

    $sqlCommand = @"
                    SELECT [ColumnA] AS [Path]
                      FROM [dbo].[TABLE]
                      WHERE	[ColumnA] like '[a-zA-Z]!:!\%' ESCAPE '!'
"@
    Try
    {
        $connection = new-object system.data.SqlClient.SQLConnection($connectionString)
        $command = new-object system.data.sqlclient.sqlcommand($sqlCommand,$connection)
        $connection.Open()
    
        $adapter = New-Object System.Data.sqlclient.sqlDataAdapter $command
        $dataset = New-Object System.Data.DataSet
        $adapter.Fill($dataSet) | Out-Null
        $connection.Close()
        $results = @()
        foreach ($Row in $dataSet.Tables[0].Rows)
        {
            $result = new-object psobject -Property @{
                'Path' = $Row[0];
                'Exists' = Test-Path -Path $Row[0]
            }
            $results += $result
        }
    }
    Catch
    {
        $ErrorMessage = $_.Exception.Message
        $FailedItem = $_.Exception.ItemName
        Write-Host $ErrorMessage
        Write-Host $FailedItem
    }

    Write-Host "`nFailed directories"
    $results.ForEach({[PSCustomObject]$_}) | where-object {$_.Exists -eq $false} | Format-Table -AutoSize
    Write-Host "`nWorking directories"
    $results.ForEach({[PSCustomObject]$_}) | where-object {$_.Exists -eq $true} | Format-Table -AutoSize
}


function Get-Creds{
		$credFile = $ScriptDir + '\creds.txt'
		if (Test-Path -Path $credFile)
		{
			$values = Get-Content $credFile | Out-String | ConvertFrom-StringData
			$creds = new-object psobject -Property @{
					'username' = $values.username;
					'password' = $values.password;
					'database' = $values.database;                
					'server' = $values.server
			}
		}
		else # if no cred.txt file is found, ask for credentials from user within the Powershell-terminal
		{
			$server = Read-Host "Enter Servername"
			$db = Read-Host "Enter Database"
			$user = Read-Host "Enter Username"
			$pass = Read-Host "Enter Password"
			$creds = new-object psobject -Property @{
					'username' = $user;
					'password' = $pass;
					'database' = $db;
					'server' = $server
			}
		}
        return $creds
}

$ScriptDir = Split-Path $script:MyInvocation.MyCommand.Path
$auth = Get-Creds

Invoke-SQL -server $auth.server -database $auth.database -userName $auth.username -dbpwd $auth.password
