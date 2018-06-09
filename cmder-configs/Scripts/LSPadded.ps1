function LS-Padded
{
    param ($dir)
    Get-Childitem $dir
    Write-Host
    getDirSize $dir
}

function getDirSize
{
    param ($dir)
    $bytes = 0

    Get-Childitem $dir | foreach-object {

        if ($_ -is [System.IO.FileInfo])
        {
            $bytes += $_.Length
        }
    }

    if ($bytes -ge 1KB -and $bytes -lt 1MB)
    {
        Write-Host ("Total Size: " + [Math]::Round(($bytes / 1KB), 2) + " KB")
    }

    elseif ($bytes -ge 1MB -and $bytes -lt 1GB)
    {
        Write-Host ("Total Size: " + [Math]::Round(($bytes / 1MB), 2) + " MB")
    }

    elseif ($bytes -ge 1GB)
    {
        Write-Host ("Total Size: " + [Math]::Round(($bytes / 1GB), 2) + " GB")
    }

    else
    {
        Write-Host ("Total Size: " + $bytes + " bytes")
    }
}