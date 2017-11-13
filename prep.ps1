echo "$PSScriptRoot"
<#
cmd /c rmdir /s /q "$PSScriptRoot\node_modules\@microsoft.azure\autorest.azureresourceschema\node_modules"
cmd /c rmdir /s /q "$PSScriptRoot\node_modules\@microsoft.azure\autorest.csharp\node_modules"
cmd /c rmdir /s /q "$PSScriptRoot\node_modules\@microsoft.azure\autorest.go\node_modules"
cmd /c rmdir /s /q "$PSScriptRoot\node_modules\@microsoft.azure\autorest.java\node_modules"
cmd /c rmdir /s /q "$PSScriptRoot\node_modules\@microsoft.azure\autorest.modeler\node_modules"
cmd /c rmdir /s /q "$PSScriptRoot\node_modules\@microsoft.azure\autorest.nodejs\node_modules"
cmd /c rmdir /s /q "$PSScriptRoot\node_modules\@microsoft.azure\autorest.python\node_modules"
cmd /c rmdir /s /q "$PSScriptRoot\node_modules\@microsoft.azure\autorest.ruby\node_modules"
cmd /c rmdir /s /q "$PSScriptRoot\node_modules\@microsoft.azure\autorest.typescript\node_modules"
cmd /c erase "$PSScriptRoot\node_modules\.bin\d*"
#>
# clean  up files we don't want in the PATH
cmd /c erase "$PSScriptRoot\node_modules\.bin\es*"
cmd /c erase "$PSScriptRoot\node_modules\.bin\autorest*"
cmd /c erase "$PSScriptRoot\node_modules\.bin\j*"
cmd /c erase "$PSScriptRoot\node_modules\.bin\i*"
cmd /c erase "$PSScriptRoot\node_modules\.bin\dotnet-*"
cmd /c erase "$PSScriptRoot\node_modules\.bin\dn*"


copy (node -p "process.argv[0]") ./node_modules/.bin/node.exe

$cmd = @"
@echo off
setlocal
set PATH=%~dp0\node_modules\dotnet-2.0.0-win;%~dp0\node_modules\.bin;%PATH%
call "%~dp0\node_modules\.bin\node" "%~dp0\node_modules\autorest\dist\app.js" %*
"@

set-content -Path .\autorest.cmd -Value $cmd -Encoding Ascii

$v = (ConvertFrom-Json (get-content -raw $PSScriptRoot\node_modules\autorest\package.json)).version

echo $v

Compress-Archive @( "node_modules","autorest.cmd" ) "autorest-$v.zip"