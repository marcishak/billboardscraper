#! /usr/bin/perl

### Finds the year's preformance for varios songs
### Points work out to be on an inverse scale ie no 1 gets 100 points, 2 -> 99, etc...

# if(@ARGV != 1){
#     die "$0 Usage: use year";
# }
# $year = $ARGV[0];
# @list = `ls data/$year/*.csv`;
# $file = $list[15];
# print $file;
# open F, "$file" or die "shit went wrong";
# @lines = <F>;
# foreach $line(@lines){
#     if($line =~ /^(.*), "(.*)", "(.*)"$/){
#         # if($1 eq "rank"){
#         #     continue;
#         # }
#        $rank = $1;
#        $artist = $2;
#        $title  =$3;
#        $blah{$artist}{$title} = $rank;
#     }
# }
# for $family ( keys %blah ) {
#     print "$family: ";
#     for $role ( keys %{ $blah{$family} } ) {
#          print "$role=$blah{$family}{$role} ";
#     }
#     print "\n";
# }
# close F;

if(@ARGV != 2){
    die "$0 Usage: year, (-w weeks or -p points)";
}
$year = $ARGV[0];
@list = `ls data/$year/*.csv`;
foreach $file (@list){
    # $file = $list[15];
    # print $file;
    open F, "$file" or die "shit went wrong";
    @lines = <F>;
    foreach $line(@lines){
        if($line =~ /^(.*), "(.*)", "(.*)"$/){
            # if($1 eq "rank"){
            #     continue;
            # }
            if($ARGV[1] eq "-p"){
                $rank = 100-$1+1;
            }elsif($ARGV[1] eq "-w"){
                $rank = 1;
            }else{
                die "-w(eeks) or -p(oints)";
            }
            
            $artist = $2;
            $title  =$3;
            $blah{$artist}{$title} += $rank;
        }
    }
    close F;

}

$i=0;
for $family ( keys %blah ) {
    
    foreach my $name (sort { $blah{$family}{$a} <=> $blah{$family}{$b} } keys $blah{$family}) {
        $list[$i] = sprintf "%-4s | %s - %s", $blah{$family}{$name}, $family, $name;
        $i++;
    }
    # print "\n";
}
@sortedlist= sort {$b <=> $a} @list;
$j=0;
$number = $j+ 1;
foreach $row(@sortedlist){
    $list[$j] = sprintf "%-3s | %-s\n", $number, $row;
    $j++;
    $number++;
}
print @list;


