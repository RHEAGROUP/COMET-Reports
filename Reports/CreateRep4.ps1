$foundChildren = get-childitem -Directory

foreach($folder in $foundChildren) {
    $files = get-childitem $folder;
    $reportName = $folder.Name
    if($files.Length -gt 0){
        $zipFileName = ".\" + $reportName + ".zip"
        $rep4FileName = ".\" + $reportName + ".rep4"
        $dataSourceFileName = ".\" + $reportName + "\Datasource.cs"
        $reportFileName = ".\" + $reportName + "\Report.repx" 

        Compress-Archive -Path $dataSourceFileName, $reportFileName -DestinationPath $zipFileName

        if (Test-Path $rep4FileName) {
            Remove-Item $rep4FileName
        }

        Rename-Item $zipFileName $rep4FileName
    }
}
