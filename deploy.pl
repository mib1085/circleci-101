#!/usr/bin/perl -w
#
use strict;

#my $URL = "https://github.com/mib1085/circleci-101/compare/d663e1fd9c43...0f613898e8c3";
#my $URL = "https://github.com/mib1085/circleci-101/compare/48d920a52161...d663e1fd9c43";
#my $URL = "https://github.com/mib1085/circleci-101/compare/fcb8cde83ec5...09e9bcf7ae77";
#my $URL = "https://github.com/mib1085/circleci-101/compare/219f8a72749e...580a9e9599d5";
my $URL = $ENV{'CIRCLE_COMPARE_URL'};

sub del_fn {
  my $fn = $_[0];
  if ($fn =~ /^\w+\-[\w\-]+\/(\w+)\/\w+/) {
    print "deleting ${1}...\n";
  }
}

sub add_fn {
  my $fn = $_[0];
  if ($fn =~ /^\w+\-[\w\-]+\/(\w+)\/\w+/) {
    print "adding ${1}...\n";
  }
}

sub mod_fn {
  my $fn = $_[0];
  if ($fn =~ /^\w+\-[\w\-]+\/(\w+)\/\w+/) {
    print "updating ${1}...\n";
  }
}

$URL =~ /.*\/(.*)/;
my $COMMITS = $1;

open CMD, "git diff $COMMITS|";

my $left;
my $right;

while (<CMD>) {
  if (/^\-\-\- (.*)/) {
    $left = $1;
  } elsif (/^\+\+\+ (.*)/) {
    $right = $1;
    if ($right =~ /^\// && $left =~ /^a\/(.*)/) {
      del_fn($1);
    } elsif ($left =~ /^\// && $right =~ /^b\/(.*)/) {
      add_fn($1);
    } elsif ($left =~ /^a\// && $right =~ /^b\/(.*)/) {
      mod_fn($1);
    }
  }
}

close CMD;
