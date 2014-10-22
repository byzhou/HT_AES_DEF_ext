#!/usr/bin/perl

use File::Basename ;
use integer ;
use warnings ;

#system command to call the cell info extraction
#system ( "./lef_ext.pl" ) ;

#def file name
$defHTFree  = "TrojanFree.def" ;
$defHTIn    = "TrojanIn.def" ;

#output file name
$outFree    = "Free\_des.txt" ;
$outIn      = "In\_des.txt" ;

#cell info file
$celinfo    = "des_ALLCELL.txt" ;

#write to Trojan Free file
open $writeFree , "+>" , $outFree or die "$outFree is not available!\n" ; 
print $outFree . " has been successfully opened!\n" ;

#read Trojan Free file
open $readFree , "<" , $defHTFree or die "$defHTFree is not available!\n" ;
print $defHTFree . " has been successfully opened!\n" ;

#write info the cell
while ( <$readFree> ) {
    if ( /^\-*/ ) {
        #print $writeFile "$&\n" ;

        #matching a floating number [-+]?([0-9]*\.[0-9]+|[0-9]+)
        #while ( /[-+]?([0-9]*\.[0-9]+|[0-9]+)/g ) {

        while ( /[\S]*/g ) {
            $countSpace ++ ;
            if ( $countSpace == 2 ) {
                $cellname       = $& ;
                print $cellname ;
            }
        }
            $countSpace     = 0 ;
 
        while ( /\([0-9]*/g ) {
#            $posX       = $& ;
#            if ( $XorY == 0 ) {
#                print $writeFile "X $&\t" ;
#                $XorY   = 1 ;
#            } else {
#                print $writeFile "Y $&\n" ;
#                $XorY   = 0 ;
#            }
        }
    }
}

#end of the one readFile
close ( $readFree ) ;
close ( $writeFree ) ;

