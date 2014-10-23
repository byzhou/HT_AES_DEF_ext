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

#write to Trojan Free file
open $writeFree , "+>" , $outFree or die "$outFree is not available!\n" ; 
print $outFree . " has been successfully opened!\n" ;

#read Trojan Free file
open $readFree , "<" , $defHTFree or die "$defHTFree is not available!\n" ;
print $defHTFree . " has been successfully opened!\n" ;


#write info the cell
while ( <$readFree> ) {
    if ( /^\-/ ) {
        
        my @definfo     = split ( ' ' , $' ) ;
        if ( @definfo >= 2 ) {
            $cellname       = $definfo[1] ;
         
            #read the all standard cell reference file
            open $cellref , "<" , $cellinfo or die "$cellinfo is not available!\n" ;

            while ( <$cellref> ) {
                my @refinfo     = split ( '\t' , $_ ) ;
                $refcellname    = $refinfo[0] ;
                #print $refcellname . "\n" ;
                if ( $refcellname eq $cellname ) {
                    $refxsize       = $refinfo[3] ;
                    $refysize       = $refinfo[5] ;
                    last ;
                }
            }

            close ( $cellref ) ;
            #print $cellname . "\t" . $refxsize . "\t" . $refysize . "\n" ;
        }
    }
}

#end of the one readFile
close ( $readFree ) ;
close ( $writeFree ) ;

