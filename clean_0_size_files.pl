use File::Basename ;
use File::stat;
#use integer ;
use Switch ;
use warnings ;

$readDir     = $ARGV[0];
# read directory
opendir ( DIR , $readDir ) || die "Given directory is not readable!\n";
while ( $readFile = readdir ( DIR ) ) {
    next if ($readFile =~ m/^\./ || $readFile =~ m/^README\.md/ );
    $fileName = $readDir.'/'. $readFile ;
    $size = stat ( $fileName ) -> size ;
    if ( $size eq 0 ) {
        $cmd    = "rm ". $fileName ;
        system ( $cmd );
        print $fileName ," has been removed!\n" ;
    }

}
close (DIR) ;
