#!/usr/bin/perl

use File::Basename ;
use integer ;
use warnings ;

$lefpre     = "lef\/" ;
$lefsuf     = "\.lef" ;
$lefcell    = $lefpre ;
$lefname    = $lefpre ;

$output     = "setattributefalse.txt" ;
#write to file
open $writeFile , "+>" , $output or die "$output is not available!\n" ; 
print $output . " has been successfully opened!\n" ;

opendir ( DIR , $lefpre ) or die "$lefpre is not available!\n" ;
print $lefpre . " has been successfully opened!\n" ;
close ( DIR ) ;

#cellname creation
while ( $lefcell = readdir ( DIR ) ) {

    #Use a regular expression to ignore files beginning with a period
    next if ($lefcell =~ m/^\./ || $lefcell =~ m/^README\.md/ );

    #define cellname
    $lefname    = $lefpre . $lefcell ;

    #read file
    open $readFile , "<" , $lefname or die "$lefname is not available!\n" ;
    print $lefname . " has been successfully opened!\n" ;

    #write the name of the cell
    $lefcell        =~ s/$lefsuf//g ;
    #print $writeFile $lefcell . "\t" ;

    #write info the cell
    print $writeFile "cd \/libraries\/NangateOpenCellLibrary\/libcells\/$lefcell\n" ;
    print $writeFile "set\_attribute avoid true\n" ;

    #end of the one readFile
    print $writeFile "\n" ;

    close ( $readFile ) ;
}
close ( $writeFile ) ;

