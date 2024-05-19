$machinePaths = ([System.Environment]::GetEnvironmentVariable( 'PATH', 'Machine' )).Split(";") | Where-Object { $_ } | Select -Unique
$userPaths = ([System.Environment]::GetEnvironmentVariable( 'PATH', 'Machine' )).Split(";") | Where-Object { $_ } | Select -Unique

foreach ($pathToTest in $machinePaths) {
  if (-Not (Test-Path $pathToTest) {
    Write-Host "MISSING! -> : $($pathtotest)"
  }
}

foreach ($pathToTest in $userPaths) {
  if (-Not (Test-Path $pathToTest) {
    Write-Host "MISSING! -> : $($pathtotest)"
  }
}
