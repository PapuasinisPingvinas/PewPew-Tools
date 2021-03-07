<# This form was created using POSHGUI.com  a free online gui designer for PowerShell
.NAME
    Updater
#>

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName PresentationCore,PresentationFramework
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(400,400)
$Form.minimumSize                = New-Object System.Drawing.Size(420,100)
$Form.maximumSize                = New-Object System.Drawing.Size(420,100)
$Form.FormBorderStyle            = 'Fixed3D'
$Form.MaximizeBox                = $false
$Form.text                       = "Updater"
$Form.TopMost                    = $false
$Form.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#040e13")

$Button1                         = New-Object system.Windows.Forms.Button
$Button1.text                    = "Update / Reinstall"
$Button1.width                   = 187
$Button1.height                  = 30
$Button1.location                = New-Object System.Drawing.Point(10,11)
$Button1.Font                    = New-Object System.Drawing.Font('Segoe UI',10)
$Button1.ForeColor               = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$Button1.BackColor               = [System.Drawing.ColorTranslator]::FromHtml("#000102")

$Button2                         = New-Object system.Windows.Forms.Button
$Button2.text                    = "Remove"
$Button2.width                   = 176
$Button2.height                  = 30
$Button2.location                = New-Object System.Drawing.Point(215,11)
$Button2.Font                    = New-Object System.Drawing.Font('Segoe UI',10)
$Button2.ForeColor               = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$Button2.BackColor               = [System.Drawing.ColorTranslator]::FromHtml("#000102")

$Form.controls.AddRange(@($Button1,$Button2))


$testedpath = Test-Path "~\PewPewTools\config.json"
if ($testedpath -eq $false){
    [System.Windows.MessageBox]::Show('config.json was not found.','Critical Error','OK','Error')
} else {
    $rawjson = Get-Content "~\PewPewTools\config.json"
$convertedjson =  $rawjson | ConvertFrom-Json
$Button1.Add_Click({
    $msgBoxInput1 = [System.Windows.MessageBox]::Show('Do you want to Update / Reinstall PewPew Tools?','Warning','YesNo','Warning')
    switch ($msgBoxInput1) {
    'Yes' {
        if ($convertedjson.pplu -eq $true){
            Write-Host "INFO: Downloading PPLU" -ForegroundColor Green
            Invoke-WebRequest "https://pewpew-tools.web.app/mirror/ppl-utils/latest.zip" -OutFile "~\PewPewTools\pplu.zip"
            Expand-Archive -LiteralPath "~\PewPewTools\pplu.zip" -DestinationPath "~\PewPewTools\pplu" -Force
            Remove-Item "~\PewPewTools\pplu.zip"
            Write-Host "INFO: Download complete." -ForegroundColor Green
            
        }
        if ($convertedjson.pplbp -eq $true){
            Write-Host "INFO: Downloading PPLBP" -ForegroundColor Green
            Invoke-WebRequest "https://pewpew-tools.web.app/mirror/ppl-blender-plugin/latest.zip" -OutFile "~\PewPewTools\pplbp.zip"
            #Expand-Archive -LiteralPath "~\PewPewTools\pplbp.zip" -DestinationPath "~\PewPewTools\pplbp" -Force
            #Remove-Item "~\PewPewTools\ppl.zip"
            Write-Host "INFO: Download complete." -ForegroundColor Green
        }
        if ($convertedjson.pplve -eq $true){
            Write-Host "INFO: Downloading PPLVE" -ForegroundColor Green
            Invoke-WebRequest "https://pewpew-tools.web.app/mirror/pewhelp-vscode/latest.vsix" -OutFile "~\PewPewTools\pplve.vsix"
            Write-Host "INFO: Download complete." -ForegroundColor Green
        }
        else {
            Write-Host "WARNING: There is nothing to update." -ForegroundColor Green
        }
        [System.Windows.MessageBox]::Show('Update complete.','Operation Successful','OK','Info')
        break
    }

    'No' {
        break
    }
    }
})
$Button2.Add_Click({
    $msgBoxInput2 =  [System.Windows.MessageBox]::Show('Do you want to remove EVERYTHING in PewPewTools directory?','Warning','YesNo','Warning')
    switch  ($msgBoxInput2) {
    'Yes' {
        if ($convertedjson.pplu -eq $true){
            Write-Host "INFO: Removing PPLU" -ForegroundColor Green
            Remove-Item "~\PewPewTools\pplu" -Recurse
            Write-Host "INFO: Remove complete." -ForegroundColor Green
            
        }
        if ($convertedjson.pplbp -eq $true){
            Write-Host "INFO: Removing PPLBP" -ForegroundColor Green
            Remove-Item "~\PewPewTools\pplbp.zip"
            Write-Host "INFO: Remove complete." -ForegroundColor Green
        }
        if ($convertedjson.pplve -eq $true){
            Write-Host "INFO: Removing PPLVE" -ForegroundColor Green
            Remove-Item "~\PewPewTools\pplve.vsix"
            Write-Host "INFO: Remove complete." -ForegroundColor Green
        }
        break
    }

    'No' {
        break
    }
    }
})

[void]$Form.ShowDialog()
}