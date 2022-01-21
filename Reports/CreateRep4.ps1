If(test-path ".\AllBudgets")
{
    Remove-Item ".\AllBudgets" -Force
}

$foundChildren = get-childitem -Directory

foreach($folder in $foundChildren) {
    $files = get-childitem $folder;
    $reportName = $folder.Name
    if($files.Length -gt 0){
        $zipFileName = ".\AllBudgets\" + $reportName + "\" + $reportName + ".zip"
        $rep4FileName = $reportName + ".rep4"
        $mdFileName = ".\AllBudgets\"+ $reportName + "\"  + $reportName + ".md"
        $dataSourceFileName = ".\" + $reportName + "\Datasource.cs"
        $reportFileName = ".\" + $reportName + "\Report.repx" 
        $orgMdFileName = ".\" + $reportName + "\" + $reportName + ".md" 
        $releaseFolder = ".\AllBudgets\" + $reportName

        New-Item -ItemType Directory -Force -Path $releaseFolder

        Compress-Archive -Path $dataSourceFileName, $reportFileName -DestinationPath $zipFileName

        if (Test-Path $rep4FileName) {
            Remove-Item $rep4FileName
        }

        Rename-Item $zipFileName $rep4FileName

        Copy-Item $orgMdFileName -Destination $mdFileName
    }
}

if (Test-Path "AllBudgets.zip") {
    Remove-Item "AllBudgets.zip"
}

Compress-Archive -Path ".\AllBudgets\*" -DestinationPath "AllBudgets.zip"

