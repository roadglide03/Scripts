$folder="C:\Users\ad752h\Documents\Projects";             # Directory to place the new folders in.
$txtFile="C:\Users\ad752h\Documents\Scripts\dc.txt"; # File with list of new folder-names
$pattern="\+.+";              # Pattern that lines must match      

gc $txtFile | %{md $_}

#get-content $txtFile | %{
#mkdir "$folder\$_";
#    if($_ -match $pattern)
#    {
#        mkdir "$folder\$_";
#    }
#}