$source = @"
    using System;
    public class Search {

        public static string getSearch (){
            string toReturn = " ";
            toReturn = Console.ReadLine();
            return toReturn;
        }
    }
"@

Add-Type -TypeDefinition $source


function Get-CustomElement(){
    $obj = New-Object 'Search'

    Write-Output "Search Directory or file":

    [string] $objectToSearch = $obj::getSearch()

    [string] $startLocationSearch = $env:HOME

    [System.Collections.Generic.List[string]]$ListWithoutExtension

    [System.Collections.Generic.List[string]]$ListWithExtension

    $ListWithoutExtension =  Get-ChildItem $startLocationSearch

    $ListWithExtension =  Get-ChildItem -Path $startLocationSearch -Include "$objectToSearch.*" -File -Recurse -ErrorAction SilentlyContinue

    foreach ($path in $ListWithoutExtension){
        [string] $pathObject = "$path/$objectToSearch"
        [bool] $condition = Test-Path $pathObject

        if ($condition) {
            foreach ($id in $pathObject){
                Write-Output $id
            }
        }
    }

    foreach($id in $ListWithExtension){
        [string] $path = $id
        Write-Output $path
    }
}