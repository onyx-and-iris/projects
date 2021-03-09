Function Convert{
    param(
        $FF, [string[]]$FILES
    )
    
    ForEach ($file_in in $FILES) {
        $file_out = $(Join-Path -Path $((Get-Item $file_in).DirectoryName) `
        -ChildPath $((Get-Item $file_in).Basename + ".mxf"))

        if ([System.IO.File]::Exists($file_out)) {
            Write-Host "$file_in was already converted."
        } else {
            Write-Host "Converting $file_in to $file_out"
            
            & $FF.FFMPEG -i $file_in `
            -c:v dnxhd -profile:v dnxhr_hq -pix_fmt yuv422p -r 60 `
            $file_out
        }
    }
}


if ($MyInvocation.InvocationName -ne '.')
{
    $CONFIG_FILE = 'config.txt'

    $FF = Get-Content $CONFIG_FILE | ConvertFrom-StringData

    Get-ChildItem ./ -recurse | Where {$_.extension -eq ".backup"} | % {
        [string[]]$FILES += $_.FullName
    }

    Convert -FF $FF -FILES $FILES
}
