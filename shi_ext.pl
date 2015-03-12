#!/usr/bin/perl

use File::Basename ;
#use integer ;
use Switch ;
use warnings ;

#system command to call the cell info extraction
#system ( "./lef_ext.pl" ) ;

#def file name
#$defHTFree  = "TrojanFree.def" ;
#$defHTIn    = "TrojanIn.def" ;

#output file name
#$outFree    = "Free\_des.txt" ;
#$outIn      = "In\_des.txt" ;

#cell info file
$cellinfo   = "des_ALLCELL.txt" ;

#make sure the shift dimension follows 10x10
$defHTIn    = "def\/" . $ARGV[3] . "\.def" ;

sub dir ;

#write to Trojan Free file
for ( $xdownlimit = $ARGV[0] ; $xdownlimit <= $ARGV[1] ; $xdownlimit =
    $xdownlimit + $ARGV[2] ) {

    $start2shiy     = $xdownlimit + $ARGV[2] / 2 ;
    $start2shix     = $xdownlimit + 3 ;
    $ydownlimit     = $xdownlimit ;
    $xuplimit       = $xdownlimit + 10 ;
    $yuplimit       = $ydownlimit + 10 ;

    $outIn          = "shi\/" . $ARGV[3] . "x" . $xdownlimit . $xuplimit . "y" . $ydownlimit . $yuplimit . "\.txt" ;
    open $writeFree , "+>" , $outIn or die "$outIn is not available!\n" ; 
    print $outIn . " has been successfully opened!\n" ;

    #read Trojan Free file
    open $readFree , "<" , $defHTIn or die "$defHTIn is not available!\n" ;
    print $defHTIn . " has been successfully opened!\n" ;

    #write info the cell
    while ( <$readFree> ) {
        if ( /PLACED/ ) {
            my @definfo     = split ( ' ' , $' ) ;
            my @preinfo     = split ( ' ' , $` ) ;

            if ( @preinfo >= 2 ) {
                $cellins        = $preinfo[1] ;
                $cellname       = $preinfo[2] ;
                $celldir        = $definfo[4] ;
                $cellposx       = $definfo[1] / 2000 ;
                $cellposy       = $definfo[2] / 2000 ;

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

                #cell position limited in a square area  
                if ( ( $cellposx > $xdownlimit ) && ( $cellposx < $xuplimit ) &&
                        ( $cellposy > $ydownlimit ) && ( $cellposy < $yuplimit ) ) {
                    #print "found\n" ; 
                    #print $cellname . "\t" . $cellins . "\t" . $celldir . "\t" . $cellposx . "\t" . $cellposy . "\t" . $celldir . "\t" . $refxsize . "\t" . $refysize ;
                    #print $writeFree $cellname . "\t" . $cellins . "\t" . $cellposx . "\t" . $cellposy . "\t" . $celldir . "\t" . $refxsize . "\t" . $refysize . "\n" ;
                    &dir ( $celldir , $cellname , $cellins , $cellposx , $cellposy , $refxsize , $refysize ) ;
                } #end if
                close ( $cellref ) ;
            }
        }
    }
    close ( $writeFree ) ;
    close ( $readFree ) ;
}

#end of the one readFile

sub dir {
    my ( $celldir , $cellname , $cellins , $cellposx , $cellposy , $refxsize , $refysize ) = @_ ;
    switch ( $celldir ) {
        case "N" { 
            if ( $cellposy <= $start2shiy ) {
                if ( $cellposx < $start2shix ) {
                    $cellposx = $cellposx + 10 - 3 ;
                } else {
                    $cellposx = $cellposx - 3 ;
                }
                print $writeFree $cellname. ("\t") .$cellins .( 
                    "\t" ).( $cellposx ).( "\t" ).( $cellposy + $refysize ).(
                    "\t" ).( $cellposx + $refxsize ).( "\t" ).( $cellposy + $refysize ).(
                    "\t" ).( $cellposx + $refxsize ).( "\t" ).( $cellposy ).(
                    "\t" ).( $cellposx ).( "\t" ).( $cellposy )
                    . "\n" 
            } else {
                print $writeFree $cellname. ("\t") .$cellins .( 
                    "\t" ).( $cellposx ).( "\t" ).( $cellposy + $refysize ).(
                    "\t" ).( $cellposx + $refxsize ).( "\t" ).( $cellposy + $refysize ).(
                    "\t" ).( $cellposx + $refxsize ).( "\t" ).( $cellposy ).(
                    "\t" ).( $cellposx ).( "\t" ).( $cellposy )
                    . "\n" 
            }
        } case "S" {
            if ( $cellposy <= $start2shiy ) {
                if ( $cellposx < $start2shix ) {
                    $cellposx = $cellposx + 10 - 3 ;
                } else {
                    $cellposx = $cellposx - 3 ;
                }
                print $writeFree $cellname. ("\t") .$cellins .( 
                    "\t" ).( $cellposx ).( "\t" ).( $cellposy + $refysize ).(
                    "\t" ).( $cellposx + $refxsize ).( "\t" ).( $cellposy + $refysize ).(
                    "\t" ).( $cellposx + $refxsize ).( "\t" ).( $cellposy ).(
                    "\t" ).( $cellposx ).( "\t" ).( $cellposy )
                    . "\n" 
            } else {
                print $writeFree $cellname. ("\t") .$cellins .( 
                    "\t" ).( $cellposx ).( "\t" ).( $cellposy + $refysize ).(
                    "\t" ).( $cellposx + $refxsize ).( "\t" ).( $cellposy + $refysize ).(
                    "\t" ).( $cellposx + $refxsize ).( "\t" ).( $cellposy ).(
                    "\t" ).( $cellposx ).( "\t" ).( $cellposy )
                    . "\n" 
            } 
        } case "W" {
            print $writeFree $cellname. ("\t") . $cellins .( 
                "\t" ).( $cellposx - $refysize ).( "\t" ).( $cellposy + $refxsize ).(
                "\t" ).( $cellposx ).( "\t" ).( $cellposy + $refxsize ).(
                "\t" ).( $cellposx ).( "\t" ).( $cellposy ).(
                "\t" ).( $cellposx - $refysize ).( "\t" ).( $cellposy )
                . "\n" 
        } case "E" {
            print $writeFree $cellname. ("\t") . $cellins .( 
                "\t" ).( $cellposx ).( "\t" ).( $cellposy ).(
                "\t" ).( $cellposx + $refysize ).( "\t" ).( $cellposy ).(
                "\t" ).( $cellposx + $refysize ).( "\t" ).( $cellposy - $refxsize ).(
                "\t" ).( $cellposx ).( "\t" ).( $cellposy - $refxsize )
                . "\n" 
        } case "FS" {
            if ( $cellposy <= $start2shiy ) {
                if ( $cellposx < $start2shix ) {
                    $cellposx = $cellposx + 10 - 3 ;
                } else {
                    $cellposx = $cellposx - 3 ;
                }
                print $writeFree $cellname. ("\t") .$cellins .( 
                    "\t" ).( $cellposx ).( "\t" ).( $cellposy + $refysize ).(
                    "\t" ).( $cellposx + $refxsize ).( "\t" ).( $cellposy + $refysize ).(
                    "\t" ).( $cellposx + $refxsize ).( "\t" ).( $cellposy ).(
                    "\t" ).( $cellposx ).( "\t" ).( $cellposy )
                    . "\n" 
            } else {
                print $writeFree $cellname. ("\t") .$cellins .( 
                    "\t" ).( $cellposx ).( "\t" ).( $cellposy + $refysize ).(
                    "\t" ).( $cellposx + $refxsize ).( "\t" ).( $cellposy + $refysize ).(
                    "\t" ).( $cellposx + $refxsize ).( "\t" ).( $cellposy ).(
                    "\t" ).( $cellposx ).( "\t" ).( $cellposy )
                    . "\n" 
            } 
        } case "FN" {
            if ( $cellposy <= $start2shiy ) {
                if ( $cellposx < $start2shix ) {
                    $cellposx = $cellposx + 10 - 3 ;
                } else {
                    $cellposx = $cellposx - 3 ;
                }
                print $writeFree $cellname. ("\t") .$cellins .( 
                    "\t" ).( $cellposx ).( "\t" ).( $cellposy + $refysize ).(
                    "\t" ).( $cellposx + $refxsize ).( "\t" ).( $cellposy + $refysize ).(
                    "\t" ).( $cellposx + $refxsize ).( "\t" ).( $cellposy ).(
                    "\t" ).( $cellposx ).( "\t" ).( $cellposy )
                    . "\n" 
            } else {
                print $writeFree $cellname. ("\t") .$cellins .( 
                    "\t" ).( $cellposx ).( "\t" ).( $cellposy + $refysize ).(
                    "\t" ).( $cellposx + $refxsize ).( "\t" ).( $cellposy + $refysize ).(
                    "\t" ).( $cellposx + $refxsize ).( "\t" ).( $cellposy ).(
                    "\t" ).( $cellposx ).( "\t" ).( $cellposy )
                    . "\n" 
            } 
        } case "FW" {
            print $writeFree $cellname. ("\t") . $cellins .( 
                "\t" ).( $cellposx ).( "\t" ).( $cellposy ).(
                "\t" ).( $cellposx + $refysize ).( "\t" ).( $cellposy ).(
                "\t" ).( $cellposx + $refysize ).( "\t" ).( $cellposy - $refxsize ).(
                "\t" ).( $cellposx ).( "\t" ).( $cellposy - $refxsize )
                . "\n" 
        } case "FE" {
            print $writeFree $cellname. ("\t") . $cellins .( 
                "\t" ).( $cellposx - $refysize ).( "\t" ).( $cellposy + $refxsize ).(
                "\t" ).( $cellposx ).( "\t" ).( $cellposy + $refxsize ).(
                "\t" ).( $cellposx ).( "\t" ).( $cellposy ).(
                "\t" ).( $cellposx - $refysize ).( "\t" ).( $cellposy )
                . "\n" 
#        } case "FN"  {
#            print $writeFree $cellname. ("\t") . $cellins .( 
#                "\t" ).( $cellposx - $refxsize ).( "\t" ).( $cellposy + $refysize ).(
#                "\t" ).( $cellposx ).( "\t" ).( $cellposy + $refysize ).(
#                "\t" ).( $cellposx ).( "\t" ).( $cellposy ).(
#                "\t" ).( $cellposx - $refxsize ).( "\t" ).( $cellposy )
#                . "\n" 
#        } case "FS"  {
#            print $writeFree $cellname. ("\t") . $cellins .( 
#                "\t" ).( $cellposx ).( "\t" ).( $cellposy ).(
#                "\t" ).( $cellposx + $refxsize ).( "\t" ).( $cellposy ).(
#                "\t" ).( $cellposx + $refxsize ).( "\t" ).( $cellposy - $refysize ).(
#                "\t" ).( $cellposx ).( "\t" ).( $cellposy - $refysize )
#                . "\n" 
#        } case "FW"  {
#            print $writeFree $cellname. ("\t") . $cellins .( 
#                "\t" ).( $cellposx ).( "\t" ).( $cellposy + $refxsize ).(
#                "\t" ).( $cellposx + $refysize ).( "\t" ).( $cellposy + $refxsize ).(
#                "\t" ).( $cellposx + $refysize ).( "\t" ).( $cellposy ).(
#                "\t" ).( $cellposx ).( "\t" ).( $cellposy )
#                . "\n" 
#        } else  {
#            print $writeFree $cellname. ("\t") . $cellins .( 
#                "\t" ).( $cellposx - $refysize ).( "\t" ).( $cellposy ).(
#                "\t" ).( $cellposx ).( "\t" ).( $cellposy ).(
#                "\t" ).( $cellposx ).( "\t" ).( $cellposy - $refxsize ).(
#                "\t" ).( $cellposx - $refysize ).( "\t" ).( $cellposy - $refxsize )
#                . "\n" 
        } 
    } #end switch
}


