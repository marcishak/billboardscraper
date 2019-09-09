#! /usr/bin/perl 


### Gets the total number of weeks or points for an artist
###  Needs slimData.pl
### Usage example -> silmData.pl 2018 -w | songCount.pl

foreach $line (<STDIN>){
   if($line =~ /^[0-9]+\s+\| ([0-9]+)\s+\| (.*) -(.*)$/){
       $artists{$2} += $1;
   }
}
foreach my $name (sort { $artists{$a} <=> $artists{$b} or $a cmp $b } keys %artists) {
    printf "%-8s %s\n", $name, $artists{$name};
}