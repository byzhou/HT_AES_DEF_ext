#!/usr/bin/perl

use File::Basename ;
use integer ;
use warnings ;
use strict ;

my $lefpre     = "lef\/" ;
my $lefsuf     = "\.lef" ;
my $lefcell    = $lefpre ;
my $lefname    = $lefpre ;
my $readFile ;
my $writeFile ;
my $XorY ;

my $output     = "des\_ALLCELL.txt" ;

#write to file
open $writeFile , "+>" , $output or die "$output is not available!\n" ; 
print $output . " has been successfully opened!\n" ;

#open directory
opendir ( DIR , $lefpre ) or die "$lefpre is not available!\n" ;
print $lefpre . " has been successfully opened!\n" ;
close ( DIR ) ;

#cellname creation
while ( $lefcell = readdir ( DIR ) ) {
    
    #define cellname
    $lefname    = $lefcell . $lefsuf ; 
    print $lefname . "\n" ;

    #read file
#    open $readFile , "<" , $lefname or die "$lefname is not available!\n" ;
#    print $lefname . " has been successfully opened!\n" ;
#
#    #write the name of the cell
#    print $writeFile $lefname . "\n" ;
#
#    #write info the cell
#    while ( <$readFile> ) {
#        if ( /SIZE*/ ) {
#            print $writeFile "$&\n" ;
#            #matching a floating number [-+]?([0-9]*\.[0-9]+|[0-9]+)
#            while ( /[-+]?([0-9]*\.[0-9]+|[0-9]+)/g ) {
#                if ( $XorY == 0 ) {
#                    print $writeFile "X $&\t" ;
#                    $XorY   = 1 ;
#                } else {
#                    print $writeFile "Y $&\n" ;
#                    $XorY   = 0 ;
#                }
#            }
#        }
#    }
#
#    #end of the one readFile
#    close ( $readFile ) ;
#    print $writeFile "\n" ;
}

close ( $writeFile ) ;

