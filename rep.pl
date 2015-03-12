#!/usr/bin/perl

use File::Basename ;
#use integer ;
use Switch ;
use warnings ;

$directory = "txt\/" ;

opendir ( DIR , $directory )  or die "Directory $directory can not be opened!\n" ;
print "Directory $directory is opened successfully!\n" ;

while ( $file = readdir ( DIR ) ) {
    
    next if ($file =~ m/^\./);

    my $readFile ;

    open $readFile , ">" , $file or die " $file cannot be opened!\n" ;
    print "$file is opened successfully!\n" ;

    $readFile =~ s/AND2_X1/XOR2_X1/g;

    close ( $readFile ) ;

}

