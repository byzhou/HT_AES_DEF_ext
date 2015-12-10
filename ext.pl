#!/usr/bin/perl

use File::Basename ;
#use integer ;
use Switch ;
use warnings ;

$cmd        = "perl lef_ext.pl";
system ($cmd) ;

#def file name
$inputFile  = $ARGV[3] ;

#cell info file
$cellinfo   = "des_ALLCELL.txt" ;

sub dir ;

$helpInfo   = << "EOF" ;

Usage: Sample the square areas from bottom left to the top right. The output
format is more organized then the lef files.

    - First argument    # start point
    - Second argument   # end point
    - Third argument    # step size
    - Fourth argument   # input file
    - Fifth argument    # output file name

    example:
        ./ext.pl 0 100 10 inputFileName outputFileName # sampling data from the first 10x10 square to the top
        lef 10x10 square
EOF

if ( $#ARGV != 4 ) {
    print $helpInfo . "\n" ;
    exit;
}

$cmd    = "rm txt/*";
system ($cmd);

for ( $xdownlimit = $ARGV[0] ; $xdownlimit <= $ARGV[1] ; $xdownlimit = $xdownlimit + $ARGV[2] ) {
    for ( $ydownlimit = $ARGV[0] ; $ydownlimit <= $ARGV[1] ; $ydownlimit = $ydownlimit + $ARGV[2] ) {
        $xuplimit       = $xdownlimit + $ARGV[2] ;
        $yuplimit       = $ydownlimit + $ARGV[2] ;

        $outputFile          = "txt/" . $ARGV[4] . "x" . $xdownlimit . $xuplimit . "y" . $ydownlimit . $yuplimit . "\.txt" ;
        open $writeFree , "+>" , $outputFile or die "$outputFile is not available!\n" ; 
        print $outputFile . " has been successfully opened!\n" ;

        #read Trojan Free file
        open $readFree , "<" , $inputFile or die "$inputFile is not available!\n" ;
        print $inputFile . " has been successfully opened!\n" ;

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
                        &dir ( $celldir , $cellname , $cellins , $cellposx , $cellposy , $refxsize , $refysize ) ;
                    } #end if
                    close ( $cellref ) ;
                }
            }
        }
        close ( $writeFree ) ;
        close ( $readFree ) ;
    }
}

$cmd = "perl clean_0_size_files.pl";
system ($cmd);

#end of the one readFile

sub dir {
    my ( $celldir , $cellname , $cellins , $cellposx , $cellposy , $refxsize , $refysize ) = @_ ;
    switch ( $celldir ) {
        case "N" { 
            print $writeFree $cellname. ("\t") .$cellins .( 
                "\t" ).( $cellposx ).( "\t" ).( $cellposy + $refysize ).(
                "\t" ).( $cellposx + $refxsize ).( "\t" ).( $cellposy + $refysize ).(
                "\t" ).( $cellposx + $refxsize ).( "\t" ).( $cellposy ).(
                "\t" ).( $cellposx ).( "\t" ).( $cellposy )
                . "\n" 
        } case "S" {
            print $writeFree $cellname. ("\t") .$cellins .( 
                "\t" ).( $cellposx ).( "\t" ).( $cellposy + $refysize ).(
                "\t" ).( $cellposx + $refxsize ).( "\t" ).( $cellposy + $refysize ).(
                "\t" ).( $cellposx + $refxsize ).( "\t" ).( $cellposy ).(
                "\t" ).( $cellposx ).( "\t" ).( $cellposy )
                . "\n" 
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
            print $writeFree $cellname. ("\t") .$cellins .( 
                "\t" ).( $cellposx ).( "\t" ).( $cellposy + $refysize ).(
                "\t" ).( $cellposx + $refxsize ).( "\t" ).( $cellposy + $refysize ).(
                "\t" ).( $cellposx + $refxsize ).( "\t" ).( $cellposy ).(
                "\t" ).( $cellposx ).( "\t" ).( $cellposy )
                . "\n" 
        } case "FN" {
            print $writeFree $cellname. ("\t") .$cellins .( 
                "\t" ).( $cellposx ).( "\t" ).( $cellposy + $refysize ).(
                "\t" ).( $cellposx + $refxsize ).( "\t" ).( $cellposy + $refysize ).(
                "\t" ).( $cellposx + $refxsize ).( "\t" ).( $cellposy ).(
                "\t" ).( $cellposx ).( "\t" ).( $cellposy )
                . "\n" 
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
        } 
    } #end switch
}


