#! /usr/bin/perl -w

### Scrapes the billboard website for chart data
### TODO: Better error messages smh

## to decode html entites into regular chars
use HTML::Entities;

$url = "$ARGV[0]";
open F, "wget -q -O- https://www.billboard.com/charts/hot-100/$url|" or die "Invalid Date\n";
$i =0;
$oldartist = "";
$oldtitle = "";
$newartist = "";
$newtitle = "";
while ($line = <F>) {
   if($line =~ /<div class=\"chart-number-one__title\">(.+)<\/div>/){
        $newtitle =  $1;
        # print $newtitle;
    }
    if($line =~ /<div class="chart-number-one__artist">/){
        $line = <F>;
        if($line =~ /<a href="\/music\/.*">/){
            $line = <F>;
            chomp $line;
            $newartist = $line;
            # print $newartist;
        }else{
            chomp $line;
            $newartist = $line;
        }

    }
    if($line =~ /<div class="chart-list-item .*" data-rank=".*" data-artist="(.*)" data-title="(.*)" data-has-content=".*">/){
    # print $line;
    #    print "$1 - ";
    #    print "$2\n";
       $newartist = $1;
       $newtitle = $2;
    }
    if($newartist ne ""){
        if($newartist ne $oldartist || $newtitle ne $oldtitle){
            $blah = {};
            $blah->{rank} = $i+1;
            $blah->{artist} = decode_entities($newartist);
            $blah->{artist} =~ s/"/\\"/g;
            $blah->{title} = decode_entities($newtitle);
            $blah->{title} =~ s/"/\\"/g;
            push @list, $blah;
            $oldartist = $newartist;
            $oldtitle = $newtitle;
            $i++;
        }
    }
   
}
if(@list != 100){
    print $url;
    print @list;
    # print $blah;
    die "scrape went wrong\n";
}
if(@ARGV == 2){
    if($ARGV[1] eq "-c"){
        printCSV(@list);
    }elsif($ARGV[1] eq "-j"){
        printJson(@list);
    }else{
        print STDERR "-c for csv flag, -j for json flag\n"
    }
}else {
    printJson(@list);
}

# prints as json
sub printJson {
    my @countdown = @_;
    print "[\n";
    print "    {\n";
    for $href ( @countdown ) {
        print "        \"rank\": $href->{rank},\n";
        print "        \"artist\": \"$href->{artist}\",\n";
        print "        \"title\": \"$href->{title}\"\n";
        if($href->{rank} != 100){
            print "    },";
            print " {\n";
        }else{
            print "    }";
        }

    }
    print "\n]";
}
#prints as csv
sub printCSV {
    my @countdown = @_;
    print "rank, artist, title\n";
    for $href(@countdown){
        print "$href->{rank}, \"$href->{artist}\", \"$href->{title}\"\n";
    }
}
