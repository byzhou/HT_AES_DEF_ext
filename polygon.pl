#!/usr/bin/perl

use File::Basename ;
use integer ;
use warnings ;

$lefpre     = "lef\/" ;
$lefsuf     = "\.lef" ;
$lefcell    = $lefpre ;
$lefname    = $lefpre ;

$output     = "des\_ALLCELL.txt" ;
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
    print $writeFile $lefcell . "\t" ;

    #write info the cell
    while ( <$readFile> ) {
        if ( /POLYGON*/ ) {
            #print $writeFile "$&\t" ;
            #matching a floating number [-+]?([0-9]*\.[0-9]+|[0-9]+)
            
            $XorY       = 0 ;
            $count      = 0 ;
            my @Xval ;
            my @Yval ;
            
            #put x y coordinates into the array
            while ( /[-+]?([0-9]*\.[0-9]+|[0-9]+)/g ) {
                if ( $XorY ) {
                    $XorY           = 0 ;
                    $Yval[$count]   = $& ;
                } else {
                    $XorY           = 1 ;
                    $Xval[$count]   = $& ;
                }
                $count ++ ;
            }

            print $Xval[0] . "\t" . $Yval[0] . "\n" ;
            
            #make poly to rect
            my @alprint ;
            for ( my $i = 0 ; $i < $count ; $i = $i + 2 ) {
                
                $already        = 0 ;
                for ( my $k = 0 ; $k < @alprint ; $k ++ ) {
                    if ( $alprint[$k] == $i ) {
                        $already        = 1;
                    }
                }

                if ( $already == 0 ) {

                    print $Xval[$i] . "\t" . $Yval[$i] . "\t" .
                            $Xval[$i + 1] . "\t" . $Yval[$i + 1] . "\t" ;
                    @alprint        = push @alprint , ( $i ) ;
                    @alprint        = push @alprint , ( $i + 1 ) ;

                    for ( my $j = $i ; $j < $count ; $j ++ ) {
                        
                        $already        = 0 ;
                        for ( my $k = 0 ; $k < @alprint ; $k ++ ) {
                            if ( $alprint[$k] == $j ) {
                                $already        = 1;
                            }
                        }

                        if ( $already == 0 ) { 

                            if ( $Xval[$i] eq $Xval[$i + 1] ) {
                                if ( $Yval[$i] eq $Yval[$j] ) {
                                    print $Xval[$j] . "\t" . $Yval[$j] . "\t" ;
                                    @alprint        = push @alprint , $j ;
                                }
                                if ( $Yval[$i + 1] eq $Yval[$j] ) {
                                    print $Xval[$j] . "\t" . $Yval[$j] . "\t" ;
                                    @alprint        = push @alprint , $j ;
                                }
                            } else {
                                if ( $Yval[$i] eq $Yval[$i + 1] ) {
                                    if ( $Xval[$i] eq $Xval[$j] ) {
                                        print $Xval[$j] . "\t" . $Yval[$j] . "\t" ;
                                        @alprint        = push @alprint , $j ;
                                    }
                                    if ( $Xval[$i + 1] eq $Xval[$j] ) {
                                        print $Xval[$j] . "\t" . $Yval[$j] . "\t" ;
                                        @alprint        = push @alprint , $j ;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    #end of the one readFile
    print $writeFile "\n" ;

    close ( $readFile ) ;
}
close ( $writeFile ) ;

