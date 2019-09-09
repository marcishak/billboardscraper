#! /usr/bin/perl -w

### Scrapes an entire year's worth of billboard charts
### needs scrapebillboard.pl
### works according to billboards system ie not an actual calender year

if(@ARGV != 2){
    print STDERR "$0 Usage: $0 year -format (-c or -j)\n";
    die;
}
$format = $ARGV[1];

if($format eq "-j"){
    $ending = "json"
}elsif($format eq "-c"){
    $ending = "csv"
}else{
    die "$0: Please use a valid format\n"
}
# print $format;
$year = $ARGV[0];
$first = "$year-01-01";
$decyear = $year -1;
$dec = "$decyear-12-01";
$date = `date -d"$first"`;
if(! -d "data"){
    `mkdir data`; 
}
if(! -d "data/$year"){
    `mkdir data/$year`;
}

# print $date;
while($date =~ /^((?!(Sat)).)*$/gi){
    # print $date;
    $date = `date -d"$date +1day"`;
}
# print $date; 
$date = `date -d"$date" +'%Y-%m-%d'`;
chomp $date;
# $date = `date -d"Sat Jan 6 2018" +'%Y-%m-%d'`;
# print $date; 
$currentdate = `date +%Y-%m-%d`;
chomp $currentdate;
while($date =~ /$year-/){
    # chomp $date;
    $path = "data/$year/$date.$ending";

    print "$date\n";
    `./scrapebillboard.pl "$date" "$format" >"$path"`;
    open F, '<', "$path";
    @lines = <F>;
    close F;
    if(@lines == 1){
        `rm "$path"`;
    }
    if(@lines == 4 && $ending eq "json"){
        `rm "$path"`;
    }
    $date = `date -d"$date+7days" +'%Y-%m-%d'`;
    chomp $date;
    if($date =~ /$year-12/){
        last;
    }
    if($date gt $currentdate){
        print("Can't find chart past current Date\n");
        # print("$path\n");
        last;
    }
}
$date = `date -d"$dec"`;
while($date =~ /^((?!(Sat)).)*$/gi){
    # print $date;
    $date = `date -d"$date +1day"`;
}
$date = `date -d"$date" +'%Y-%m-%d'`;

while($date =~ /$decyear-/){
    chomp $date;
    $path = "data/$year/$date.$ending";

    # print "$date\n";
    `./scrapebillboard.pl "$date" "$format" >"$path"`;
    open F, '<', "$path";
    @lines = <F>;
    close F;
    if(@lines == 1){
        `rm "$path"`;
    }
    if(@lines == 4 && $ending eq "json"){
        `rm "$path"`;
    }
    $date = `date -d"$date+7days" +'%Y-%m-%d'`;
}


