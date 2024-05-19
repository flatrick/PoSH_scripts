$machinePaths = ([System.Environment]::GetEnvironmentVariable( 'PATH', 'Machine' )).Split(";") | Where-Object { $_ } | Select -Unique
$userPaths = ([System.Environment]::GetEnvironmentVariable( 'PATH', 'Machine' )).Split(";") | Where-Object { $_ } | Select -Unique

Write-Host "Checking Machine environment variables for dead paths"
foreach ($pathToTest in $machinePaths) {
  if (-Not (Test-Path $pathToTest) {
    Write-Host "MISSING! -> : $($pathtotest)"
  }
}

Write-Host "`tChecking User environment variables for dead paths"
foreach ($pathToTest in $userPaths) {
  if (-Not (Test-Path $pathToTest) {
    Write-Host "MISSING! -> : $($pathtotest)"
  }
}
