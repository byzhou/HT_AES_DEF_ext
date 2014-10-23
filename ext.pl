#!/usr/bin/perl

use File::Basename ;
#use integer ;
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
$cellinfo   = "des_ALLCELL.txt" ;
my @definfo ;

#write to Trojan Free file
open $writeFree , "+>" , $outFree or die "$outFree is not available!\n" ; 
print $outFree . " has been successfully opened!\n" ;

#read Trojan Free file
open $readFree , "<" , $defHTFree or die "$defHTFree is not available!\n" ;
print $defHTFree . " has been successfully opened!\n" ;

$countLoop      = 0 ;
#write info the cell
while ( <$readFree> && ( $countLoop < 1000 ) ) {
    if ( /FE/ ) {
        #print "found\n" ;
        #print $writeFile "$&\n" ;

        #matching a floating number [-+]?([0-9]*\.[0-9]+|[0-9]+)
        #while ( /[-+]?([0-9]*\.[0-9]+|[0-9]+)/g ) {
        
        #@definfo    = split ( ' ' , $' ) ;
        #print $definfo[3] ;
 
#        while ( /\([0-9]*/g ) {
#            $posX       = $& ;
#            if ( $XorY == 0 ) {
#                print $writeFile "X $&\t" ;
#                $XorY   = 1 ;
#            } else {
#                print $writeFile "Y $&\n" ;
#                $XorY   = 0 ;
#            }
#        }
    }
    $countLoop ++ ;
}

#end of the one readFile
close ( $readFree ) ;
close ( $writeFree ) ;

