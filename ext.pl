#!/usr/bin/perl

use File::Basename ;
#use integer ;
use Switch ;
use warnings ;

#system command to call the cell info extraction
#system ( "./lef_ext.pl" ) ;

#def file name
$defHTFree  = "TrojanFree.def" ;
#$defHTIn    = "TrojanIn.def" ;

#output file name
$outFree    = "Free\_des.txt" ;
#$outIn      = "In\_des.txt" ;

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

    if ( /PLACED/ ) {
        
        my @definfo     = split ( ' ' , $' ) ;
        my @preinfo     = split ( ' ' , $` ) ;
        if ( @preinfo >= 2 ) {
            $cellname       = $preinfo[2] ;
            $celldir        = $definfo[4] ;
            $cellposx       = $definfo[1] ;
            $cellposy       = $definfo[2] ;

            #print $celldir . "\n" ;
            print  $. . "\n" ;
            #print  $writeFree $. . "\n" ;
         
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

            #cell position limited in a square area  549860 424200
            if ( ( $cellposx > 549860 ) && ( $cellposx < 424200 ) &&
                    ( $cellposy > 550860 ) && ( $cellposy < 425200 ) ) {
                switch ( $celldir ) {
                    case "N"    { 
                        print $writeFree $cellname . 
                            "\t" . $cellposx . "\t" . $cellposy + $refysize .
                            "\t" . $cellposx + $refxsize . "\t" . $cellposy + $refysize .
                            "\t" . $cellposx + $refxsize . "\t" . $cellposy .
                            "\t" . $cellposx . "\t" . $cellposy 
                    } case "S"  {
                        print $writeFree $cellname . 
                            "\t" . $cellposx - $refxsize . "\t" . $cellposy .
                            "\t" . $cellposx . "\t" . $cellposy .
                            "\t" . $cellposx . "\t" . $cellposy - $refysize .
                            "\t" . $cellposx - $refxsize . "\t" . $cellposy - $refysize 
                    } case "W"  {
                        print $writeFree $cellname . 
                            "\t" . $cellposx - $refysize . "\t" . $cellposy + $refxsize .
                            "\t" . $cellposx . "\t" . $cellposy + $refxsize .
                            "\t" . $cellposx . "\t" . $cellposy .
                            "\t" . $cellposx - $refysize . "\t" . $cellposy 
                    } case "E"  {
                        print $writeFree $cellname . 
                            "\t" . $cellposx . "\t" . $cellposy .
                            "\t" . $cellposx + $refysize . "\t" . $cellposy .
                            "\t" . $cellposx + $refysize . "\t" . $cellposy - $refxsize .
                            "\t" . $cellposx . "\t" . $cellposy - $refxsize 
                    } case "FN"  {
                        print $writeFree $cellname . 
                            "\t" . $cellposx - $refxsize . "\t" . $cellposy + $refysize .
                            "\t" . $cellposx . "\t" . $cellposy + $refysize .
                            "\t" . $cellposx . "\t" . $cellposy .
                            "\t" . $cellposx - $refxsize . "\t" . $cellposy 
                    } case "FS"  {
                        print $writeFree $cellname . 
                            "\t" . $cellposx . "\t" . $cellposy .
                            "\t" . $cellposx + $refxsize . "\t" . $cellposy .
                            "\t" . $cellposx + $refxsize . "\t" . $cellposy - $refysize .
                            "\t" . $cellposx . "\t" . $cellposy - $refysize 
                    } case "FW"  {
                        print $writeFree $cellname . 
                            "\t" . $cellposx . "\t" . $cellposy + $refxsize .
                            "\t" . $cellposx + $refysize . "\t" . $cellposy + $refxsize .
                            "\t" . $cellposx + $refysize . "\t" . $cellposy .
                            "\t" . $cellposx . "\t" . $cellposy 
                    } else  {
                        print $writeFree $cellname . 
                            "\t" . $cellposx - $refysize . "\t" . $cellposy .
                            "\t" . $cellposx . "\t" . $cellposy .
                            "\t" . $cellposx . "\t" . $cellposy - $refxsize .
                            "\t" . $cellposx - $refysize . "\t" . $cellposy - $refxsize 
                    } 
                } #end switch

            #print $cellname . "\t" . $refxsize . "\t" . $refysize . "\n" ;
            } #end if
            close ( $cellref ) ;
        }
    }
}

#end of the one readFile
close ( $readFree ) ;
close ( $writeFree ) ;

