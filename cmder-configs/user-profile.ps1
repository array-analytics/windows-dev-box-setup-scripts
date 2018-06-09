# Use this file to run your own startup commands

## Prompt Customization
<#
.SYNTAX
    <PrePrompt><CMDER DEFAULT>
    λ <PostPrompt> <repl input>
.EXAMPLE
    <PrePrompt>N:\Documents\src\cmder [master]
    λ <PostPrompt> |
#>

[ScriptBlock]$PrePrompt = {

}

[ScriptBlock]$CmderPrompt = {
    Update-NavigationHistory $pwd.Path
    $Host.UI.RawUI.ForegroundColor = "White"
    Microsoft.PowerShell.Utility\Write-Host '[' -NoNewLine -ForegroundColor Gray
    Microsoft.PowerShell.Utility\Write-Host $(Get-History).Count -NoNewLine -ForegroundColor DarkGray
    Microsoft.PowerShell.Utility\Write-Host '] ' -NoNewLine -ForegroundColor Gray
    $maxPathLength = 75
    $curPath = $pwd.ProviderPath
    if ($curPath.ToLower().StartsWith($Home.ToLower()))
    {
        $curPath = "~" + $curPath.SubString($Home.Length)
    }
    if ($curPath.Length -gt $maxPathLength) {
        $index = $curPath.IndexOf('\', $curPath.IndexOf('\') + 1) + 1;
        #$curPath = '...' + $curPath.SubString($curPath.Length - $maxPathLength + 3)
        $curPath = $curPath.Substring(0, $index) + '.....' + $curPath.Substring($curPath.Length - $maxPathLength + ($index + 5));
    }

    Microsoft.PowerShell.Utility\Write-Host $curPath -NoNewLine -ForegroundColor Green
    checkGit($pwd.ProviderPath)
}



[ScriptBlock]$PostPrompt = {

}

if ($host.Name -eq 'ConsoleHost')
{
  Import-Module PSReadline
}

Import-Module z
Import-Module posh-docker

## <Continue to add your own>

#pushd 'C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\Tools'    
#cmd /c "vsvars32.bat&set" |
#foreach {
#  if ($_ -match "=") {
#    $v = $_.split("="); set-item -force -path "ENV:\$($v[0])"  -value "$($v[1])"
#  }
#}
#popd
#write-host "`nVisual Studio 2015 Command Prompt variables set." -ForegroundColor Yellow

$MaximumHistoryCount = 4KB
$historyPath = Join-Path (split-path $profile) PowerShellHistory.csv

Remove-Item Alias:Curl
Remove-Item Alias:WGet

if (Test-path $historyPath)
{
	Import-CSV $historyPath | ? {$_.CommandLine -ne "Invoke-Expression '. ''C:\tools\cmder\vendor\conemu-maximus5\..\profile.ps1'''"} | ? {$_.CommandLine -ne "exit"} | ? {$_.CommandLine -ne "h"} | ? {$_.CommandLine -ne "ls"}  | ? {$_.CommandLine -ne "fd"} | ? {$count++;$true} | Add-History
	Write-Host -Fore Green "`nLoaded $count history item(s).`n"
}

# Hook powershell's exiting event & hide the registration with -supportevent (from nivot.org)
Register-EngineEvent -SourceIdentifier powershell.exiting -SupportEvent -Action {
	Get-History -Count $MaximumHistoryCount | ? {$_.CommandLine -ne "Invoke-Expression '. ''C:\tools\cmder\vendor\conemu-maximus5\..\profile.ps1'''"} | Export-CSV -Path $historyPath
	exit
}.GetNewClosure()

#Set-Alias bash 'C:\Windows\System32\bash.exe' -cur_console:p1
Set-Alias note 'C:\Program Files\Notepad++\notepad++.exe'
Set-Alias sqll 'C:\Program Files (x86)\SqliteBrowser3\bin\sqlitebrowser.exe'
Set-Alias .. Set-ParentUp
Set-Alias ... Set-ParentUps
Set-Alias dev Set-Code
Set-Alias ppath Print-Path
Set-Alias gs Do-Git-Status
Set-Alias gd Do-Git-Diff
Set-Alias fd Open-Path-Here
Set-Alias clean Clean-Bins
Set-Alias sh Create-Console
#Set-Alias sha Create-Console-Admin
Set-Alias z Search-NavigationHistory

$env:Path += ";$(Split-Path $profile)\Scripts"

function Create-Console($path = $(pwd)) {
  PowerShell -ExecutionPolicy Bypass -NoLogo -NoProfile -NoExit -Command "Invoke-Expression '. ''%ConEmuDir%\..\profile.ps1'''" -new_console:d:$path
}

function Set-ParentUp {
  Set-Location ..
}
function Print-Path {
  ($env:Path).Replace(';',"`n")
}

function Set-ParentUps {
  Set-Location ..
  Set-Location ..
}

function Do-Git-Status {
	git st
}
function Do-Git-Diff($file) {
	git diff $file
}


function Set-Code($code) {
  if($code -eq $null) {
	  Set-Location 'C:\Array'
  } elseif ($code.ToLower().CompareTo('array') -eq 0) {
	  Set-Location 'C:\Array'
  } elseif ($code.ToLower().CompareTo('github') -eq 0) {
	  Set-Location 'C:\GitHub'
  } elseif ($code.ToLower().CompareTo('git') -eq 0) {
	  Set-Location 'C:\GitHub'
  }
}


function Open-Path-Here {
  ii .
}

function Clean-Bins {
	Get-ChildItem .\ -include bin,obj -Recurse | foreach ($_) {
		Write-Host " Removing: $_"
		remove-item $_.fullname -Force -Recurse
	}
}


New-CommandWrapper Out-Default -Process {
  $regex_opts = ([System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
  $compressed = New-Object System.Text.RegularExpressions.Regex('\.(zip|tar|gz|rar|jar|war)$', $regex_opts)
  $executable = New-Object System.Text.RegularExpressions.Regex('\.(exe|bat|cmd|msi|ps1|psm1|vbs|reg|sh)$', $regex_opts)
  $dll = New-Object System.Text.RegularExpressions.Regex('\.(dll)$', $regex_opts)
  $text_files = New-Object System.Text.RegularExpressions.Regex('\.(txt|cfg|conf|ini|csv|log|xml|json|config|xproj|md)$', $regex_opts)
  $array_files = New-Object System.Text.RegularExpressions.Regex('\.(cs|ts|js|java|c|cpp|html)$', $regex_opts)

  if(($_ -is [System.IO.DirectoryInfo]) -or ($_ -is [System.IO.FileInfo]))
  {
    if(-not ($notfirst))
    {
      Write-Host "`n    Directory: " -noNewLine
      Write-Host "$(pwd)`n" -foregroundcolor "Cyan"
      Write-Host "Mode        Last Write Time       Length   Name"
      Write-Host "----        ---------------       ------   ----"
      $notfirst=$true
    }

    if ($_ -is [System.IO.DirectoryInfo])
    {
      Write-Host ("{0}   {1}                {2}" -f $_.mode, ([String]::Format("{0,10} {1,8}", $_.LastWriteTime.ToString("d"), $_.LastWriteTime.ToString("t"))), $_.name) -ForegroundColor "Cyan"
    }
    else
    {
      if ($compressed.IsMatch($_.Name))
      {
        $color = "DarkGreen"
      }
      elseif ($executable.IsMatch($_.Name)) {
        $color =  "Red"
      } elseif ($dll.IsMatch($_.Name)) {
        $color = "DarkGray"
      } elseif ($text_files.IsMatch($_.Name)) {
            $color = "Yellow"
      } elseif ($array_files.IsMatch($_.Name)) {
            $color = "DarkCyan"
      } else {
        $color = "White"
      }
      Write-Host ("{0}   {1}   {2,10}   {3}" -f $_.mode, ([String]::Format("{0,10} {1,8}", $_.LastWriteTime.ToString("d"), $_.LastWriteTime.ToString("t"))), $_.length, $_.name) -ForegroundColor $color
    }

    $_ = $null
  }
} -end {
  Write-Host
}

function Get-DirSize
{
  param ($dir)
  $bytes = 0
  $count = 0

  Get-Childitem $dir -Force | Foreach-Object {
    if ($_ -is [System.IO.FileInfo])
    {
      $bytes += $_.Length
      $count++
    }
  }

  Write-Host "`n    " -NoNewline

  if ($bytes -ge 1KB -and $bytes -lt 1MB)
  {
    Write-Host ("" + [Math]::Round(($bytes / 1KB), 2) + " KB") -ForegroundColor "White" -NoNewLine
  }
  elseif ($bytes -ge 1MB -and $bytes -lt 1GB)
  {
    Write-Host ("" + [Math]::Round(($bytes / 1MB), 2) + " MB") -ForegroundColor "White" -NoNewLine
  }
  elseif ($bytes -ge 1GB)
  {
    Write-Host ("" + [Math]::Round(($bytes / 1GB), 2) + " GB") -ForegroundColor "White" -NoNewLine
  }
  else
  {
    Write-Host ("" + $bytes + " bytes") -ForegroundColor "White" -NoNewLine
  }
  Write-Host " in " -NoNewline
  Write-Host $count -ForegroundColor "White" -NoNewline
  Write-Host " files"

}

function Get-DirWithSize
{
  param ($dir)
  Get-Childitem $dir -Force
  Get-DirSize $dir
}

Remove-Item alias:dir
Remove-Item alias:ls
Set-Alias dir Get-DirWithSize
Set-Alias ls Get-DirWithSize

function Prompt {
    Update-NavigationHistory $pwd.Path
}

Import-Module 'C:\tools\poshgit\dahlbyk-posh-git-9bda399\src\posh-git.psd1'


$GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $true
#$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
#if (Test-Path($ChocolateyProfile)) {
#  Import-Module "$ChocolateyProfile"
#}
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

