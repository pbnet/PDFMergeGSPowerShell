$openFileDialog = New-Object windows.forms.openfiledialog   
$openFileDialog.initialDirectory = [System.IO.Directory]::GetCurrentDirectory()   
$openFileDialog.title = "Select First PDF File to Merge"   
$openFileDialog.filter = "PDF Files (*.pdf)| *.pdf"   
$openFileDialog.filter = "PDF Files|*.*pdf" 
$openFileDialog.ShowHelp = $True   
Write-Host "Select first PDF File... (see FileOpen Dialog)" -ForegroundColor Green  
$result = $openFileDialog.ShowDialog()   # Display the Dialog / Wait for user response 
# in ISE you may have to alt-tab or minimize ISE to see dialog box 
$result 
if($result -eq "OK")    {    
Write-Host "Selected First PDF File:"  -ForegroundColor Green  
$OpenFileDialog.filename   
# $OpenFileDialog.CheckFileExists 
# Unremark the above line if you actually want to perform an import of a publish settings file  
Write-Host "1st PDF File Imported!" -ForegroundColor Green 
} 
else { Write-Host "Import 1st PDF File Cancelled!" -ForegroundColor Yellow} 


$openFileDialog2 = New-Object windows.forms.openfiledialog   
$openFileDialog2.initialDirectory = [System.IO.Directory]::GetCurrentDirectory()   
$openFileDialog2.title = "Select Second PDF File to Merge"   
$openFileDialog2.filter = "PDF Files (*.pdf)| *.pdf"   
$openFileDialog2.filter = "PDF Files|*.*pdf" 
$openFileDialog2.ShowHelp = $True   
Write-Host "Select Downloaded Settings File... (see FileOpen Dialog)" -ForegroundColor Green  
$result2 = $openFileDialog2.ShowDialog()   # Display the Dialog / Wait for user response 
# in ISE you may have to alt-tab or minimize ISE to see dialog box 
$result2 
if($result2 -eq "OK")    {    
Write-Host "Selected 2nd PDF File:"  -ForegroundColor Green  
$OpenFileDialog2.filename   
# $OpenFileDialog.CheckFileExists 
# Unremark the above line if you actually want to perform an import of a publish settings file  
Write-Host "2nd PDF File Imported!" -ForegroundColor Green 
} 
else { Write-Host "Import 2nd PDF File Cancelled!" -ForegroundColor Yellow} 

$file1=$openFileDialog.FileName
$file2=$openFileDialog2.FileName

Function Get-Folder($initialDirectory="")

{
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms")|Out-Null

    $foldername = New-Object System.Windows.Forms.FolderBrowserDialog
    $foldername.Description = "Select a folder"
    $foldername.rootfolder = "MyComputer"
    $foldername.SelectedPath = $initialDirectory

    if($foldername.ShowDialog() -eq "OK")
    {
        $folder += $foldername.SelectedPath
    }
    return $folder
}

$targetfolder = Get-Folder


if($targetfolder -ne $null)    {    
Write-Host "Selected Destination Folder OK"  -ForegroundColor Green  
} 
else { Write-Host "Destination Folder Not Selected!" -ForegroundColor Yellow} 



Start-Process "C:\Program Files (x86)\gs\gs9.52\bin\gswin32" -ArgumentList "-dNOPAUSE", "-sDEVICE=pdfwrite", "-sOUTPUTFILE=$targetfolder\Merged.pdf", "-dBATCH $file1  $file2"