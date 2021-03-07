<# This form was created using POSHGUI.com  a free online gui designer for PowerShell
.NAME
    PewPewTools
#>

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName PresentationCore,PresentationFramework
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(400,400)
$Form.minimumSize                = New-Object System.Drawing.Size(400,400)
$Form.maximumSize                = New-Object System.Drawing.Size(400,400)
$Form.FormBorderStyle            = 'Fixed3D'
$Form.MaximizeBox                = $false
$Form.text                       = "PewPew Tools Installer"
$Form.TopMost                    = $false
$Form.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#040e13")

$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "PewPew Tools"
$Label1.AutoSize                 = $true
$Label1.width                    = 25
$Label1.height                   = 10
$Label1.Anchor                   = 'top,right,left'
$Label1.location                 = New-Object System.Drawing.Point(128,11)
$Label1.Font                     = New-Object System.Drawing.Font('Segoe UI',15)
$Label1.ForeColor                = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")

$Button1                         = New-Object system.Windows.Forms.Button
$Button1.text                    = "Install"
$Button1.width                   = 60
$Button1.height                  = 30
$Button1.Anchor                  = 'right,bottom,left'
$Button1.location                = New-Object System.Drawing.Point(167,321)
$Button1.Font                    = New-Object System.Drawing.Font('Segoe UI',10)
$Button1.ForeColor               = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$Button1.BackColor               = [System.Drawing.ColorTranslator]::FromHtml("#000102")

$CheckBox1                       = New-Object system.Windows.Forms.CheckBox
$CheckBox1.text                  = "ppl-utils"
$CheckBox1.AutoSize              = $false
$CheckBox1.width                 = 95
$CheckBox1.height                = 20
$CheckBox1.location              = New-Object System.Drawing.Point(27,80)
$CheckBox1.Font                  = New-Object System.Drawing.Font('Segoe UI',10)
$CheckBox1.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#e6e6e6")

$CheckBox2                       = New-Object system.Windows.Forms.CheckBox
$CheckBox2.text                  = "PewPew Blender Add-On"
$CheckBox2.AutoSize              = $false
$CheckBox2.width                 = 210
$CheckBox2.height                = 20
$CheckBox2.location              = New-Object System.Drawing.Point(27,110)
$CheckBox2.Font                  = New-Object System.Drawing.Font('Segoe UI',10)
$CheckBox2.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#e6e6e6")

$CheckBox3                       = New-Object system.Windows.Forms.CheckBox
$CheckBox3.text                  = "PewPew Live VSCode extension"
$CheckBox3.AutoSize              = $false
$CheckBox3.width                 = 246
$CheckBox3.height                = 20
$CheckBox3.location              = New-Object System.Drawing.Point(27,141)
$CheckBox3.Font                  = New-Object System.Drawing.Font('Segoe UI',10)
$CheckBox3.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#e6e6e6")

$CheckBox4                       = New-Object system.Windows.Forms.CheckBox
$CheckBox4.text                  = "MidiToPewPew"
$CheckBox4.AutoSize              = $false
$CheckBox4.width                 = 207
$CheckBox4.height                = 20
$CheckBox4.location              = New-Object System.Drawing.Point(27,171)
$CheckBox4.Font                  = New-Object System.Drawing.Font('Segoe UI',10)
$CheckBox4.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#e6e6e6")

$ToolTip1                        = New-Object system.Windows.Forms.ToolTip

$ToolTip1.SetToolTip($Button1,'Click to install selected tools.')
$ToolTip1.SetToolTip($CheckBox1,'ppl-utils is a utility for creating custom levels for PewPew Live. 
Made by JF')
$ToolTip1.SetToolTip($CheckBox2,'PewPew Live Blender Add-On helps you create and convert meshes easier.
Made by ModEngineer')
$ToolTip1.SetToolTip($CheckBox3,'A VSCode extension that has useful snippets to enhance level creation for PewPew Live.
Made by Tasty Kiwi')
$ToolTip1.SetToolTip($CheckBox4,'This application lets you convert MIDI files into PewPew Live.
Made by SKPG-Tech')
$Form.controls.AddRange(@($Label1,$Button1,$CheckBox1,$CheckBox2,$CheckBox3,$CheckBox4))


#Write your logic code here
$Button1.Add_Click({
    $chooses = @{
        "pplu"=$checkbox1.checked
        "pplbp"=$checkbox2.checked
        "pplve"=$checkbox3.checked
        "mtpp"=$checkbox4.checked
    }
    $choosesjson = $chooses | ConvertTo-Json
    Write-Host $choosesjson
    $testpath1 = Test-Path -path "~\PewPewTools" 
    if ($testpath1 -eq $false){
        mkdir "~\PewPewTools"
        Write-Host "INFO: PewPew Tools directory was created." -ForegroundColor Green
    } else {
        Write-Host "INFO: PewPew Tools directory found." -ForegroundColor Green
    }
    if ($chooses.pplu -eq $true){
        Write-Host "INFO: Downloading PPLU" -ForegroundColor Green
        Invoke-WebRequest "https://github.com/jyaif/ppl-utils/releases/latest/download/ppl-utils-windows-x64.zip" -OutFile "~\PewPewTools\pplu.zip"
        Expand-Archive -LiteralPath "~\PewPewTools\pplu.zip" -DestinationPath "~\PewPewTools\pplu" -Force
        Remove-Item "~\PewPewTools\pplu.zip"
        Write-Host "INFO: Download complete." -ForegroundColor Green
        
    }
    if ($chooses.pplbp -eq $true){
        Write-Host "INFO: Downloading PPLBP" -ForegroundColor Green
        Invoke-WebRequest "https://firebasestorage.googleapis.com/v0/b/sharing-test-f7235.appspot.com/o/ppl-things%2Fppl-blender.zip?alt=media&token=ab56c19c-6021-40ea-9a09-4ff00ab526ad" -OutFile "~\PewPewTools\pplbp.zip"
        #Expand-Archive -LiteralPath "~\PewPewTools\pplbp.zip" -DestinationPath "~\PewPewTools\pplbp" -Force
        #Remove-Item "~\PewPewTools\ppl.zip"
        Write-Host "INFO: Download complete." -ForegroundColor Green
    }
    if ($chooses.pplve -eq $true){
        Write-Host "INFO: Downloading PPLVE" -ForegroundColor Green
        Invoke-WebRequest "https://github.com/PapuasinisPingvinas/Pewhelp-vscode/releases/latest/download/pewhelp-0.0.1.vsix" -OutFile "~\PewPewTools\pplbp.vsix"
        Write-Host "INFO: Download complete." -ForegroundColor Green
    }
    else {
        Write-Host "WARNING: nothing is selected." -ForegroundColor Yellow
    }
    $choosesjson | Out-File -FilePath "~\PewPewTools\config.json"
    Write-Host "INFO: Downloading Updater" -ForegroundColor Green
    Invoke-WebRequest "https://raw.githubusercontent.com/PapuasinisPingvinas/PewPew-Tools/master/PewPewToolsUpdater.ps1" -OutFile "~\PewPewTools\updater.ps1"
    Write-Host "INFO: Download complete." -ForegroundColor Green
    [System.Windows.MessageBox]::Show('Download complete.','Operation Successful','OK','Info')
})
[void]$Form.ShowDialog()