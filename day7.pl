#!/usr/bin/env perl
use strict; 
use warnings;

use Data::Dumper;

open my $handle, '<', "day7-input.txt";
chomp(my @lines = <$handle>);

my %rules = ();

foreach my $line (@lines) {
	my @parts = split / bags contain /, $line;
	unless ($parts[1] eq "no other bags.") {
		my @subparts = split /, /, $parts[1];
		my %contents = ();
		foreach my $subpart (@subparts) {
			my $num = $subpart;
			$num =~ s/\D//g;
			$subpart =~ s/ bags?[.]?//;
			$subpart =~ s/[0-9]+ //;
			@contents{$subpart} = $num;
		}
		$rules{$parts[0]} = \%contents;
	}
}

my %foundCols = ();
my $foundSize = 0;
my $newFoundSize = 0;
my @searchCols = ('shiny gold');
do {
	$foundSize = $newFoundSize;
	foreach my $col (keys %rules) {
		foreach my $searchCol (@searchCols) {
			if (exists(${$rules{$col}}{$searchCol})) {
				$foundCols{$col} = 1;
			}
		}
	}
	@searchCols = keys %foundCols;
	$newFoundSize = keys %foundCols;
} while ($foundSize < $newFoundSize);

print "$newFoundSize\n";

sub countBag {
	my $colName = $_[0];
	unless (exists($rules{$colName})) {
		return 0;
	}
	my %rule = %{$rules{$colName}};
	my $total = 0;
	foreach my $subColName (keys %rule) {
		$total += $rule{$subColName} * (countBag($subColName) + 1);
	}
	return $total;
}

print countBag("shiny gold");
print "\n";
