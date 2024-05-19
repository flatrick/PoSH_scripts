$paths = ([System.Environment]::GetEnvironmentVariable( 'PATH', 'Machine' )).Split(";") | Where-Object { $_ } | Select -Unique
$newPath

$pathsToRemove = 'C:\tools\jruby92\bin', 
'C:\LUA\bin'

foreach ($thePath in $paths){
    if ($pathsToRemove -notcontains $thePath){
		  if (-Not (Test-Path $thePath)) { "$($thePath)  <-- is missing!" }
		  else {
        $newPath = $newpath, $thePath -join ";"
		  }
    }
}

($newPath).Split(";")

[System.Environment]::SetEnvironmentVariable( 'PATH', $newPath, 'Machine' )
