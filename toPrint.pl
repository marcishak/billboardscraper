#! /usr/bin/perl -w
# open F, '<', $ARGV[0] or die "couldn't open file";
# @lines = <F>;
# close F;
# foreach $line(@lines){
#     $line =~ s/=>/:/g;
# }
# open F, '>', $ARGV[0] or die "couldn't open file";
# foreach $thing(@lines){
#     print F $thing;
# }
# close F;

foreach $line(<STDIN>){
    $line =~ s/\$VAR1 = //g;
    $line =~ s/=>/:/g;
    print $line;
}
