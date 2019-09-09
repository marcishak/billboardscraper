#! /usr/bin/perl 
### Finds the chart preformance for a given song from a given artist on a week by week basis

if(@ARGV == 3){
    $artist = $ARGV[0];
    $title = $ARGV[1];
    $year = $ARGV[2];
}else{
    die "$0 Usage: $0 artist title year;"
}
    print "week, rank\n";
    if(! -d "data/$year/"){
        die "year not pulled";
    }elsif (!  grep -f, glob '*.csv' ){
        die "csv not pulled"
    }
    @files = `ls data/$year/*.csv`;
    foreach $file(@files){
        open F, $file or die "$file couldnt be opened";
        foreach $line(<F>){
            if($line =~ /([0-9]+),\s+"[^,]*$artist[^,]*",\s+[^,]*"$title[^,]*"/){
                $rank = $1;
                $filename = $file =~ /\/.*\/(.*).csv$/;
                $date = $1;
                print "$date, $rank\n";
            }
        }
    }