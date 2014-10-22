#!/usr/bin/perl

use File::Basename ;
use integer ;
use warnings ;

#def file name
$defHTFree  = "TrojanFree.def"
$defHTIn    = "TrojanIn.def"

#output file name
$outFree    = "Free\_des.txt" ;
$outIn      = "In\_des.txt" ;

#write to Trojan Free file
open $writeFree , "+>" , $outFree or die "$outFree is not available!\n" ; 
print $outFree . " has been successfully opened!\n" ;

#read Trojan Free file
open $readFree , "<" , $defHTFree or die "$defHTFree is not available!\n" ;
print $defHTFree . " has been successfully opened!\n" ;

#write the name of the cell
print $writeFile $lefname . "\n" ;

#write info the cell
while ( <$readFile> ) {
    if ( /SIZE*/ ) {
        print $writeFile "$&\n" ;
        #matching a floating number [-+]?([0-9]*\.[0-9]+|[0-9]+)
        while ( /[-+]?([0-9]*\.[0-9]+|[0-9]+)/g ) {
            if ( $XorY == 0 ) {
                print $writeFile "X $&\t" ;
                $XorY   = 1 ;
            } else {
                print $writeFile "Y $&\n" ;
                $XorY   = 0 ;
            }
        }
    }
    if ( /POLYGON*/ ) {
        print $writeFile "$&\n" ;
        while ( /[-+]?([0-9]*\.[0-9]+|[0-9]+)/g ) {
            if ( $XorY == 0 ) {
                print $writeFile "X $&\t" ;
                $XorY   = 1 ;
            } else {
                print $writeFile "Y $&\n" ;
                $XorY   = 0 ;
            }
        }
    }
}

    #end of the one readFile
    print $writeFile "\n" ;
    close ( $readFile ) ;
}

close ( $writeFile ) ;

