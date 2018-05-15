#!/usr/bin/perl -w
#
use strict;

#my $URL = "https://github.com/mib1085/circleci-101/compare/d663e1fd9c43...0f613898e8c3";
#my $URL = "https://github.com/mib1085/circleci-101/compare/48d920a52161...d663e1fd9c43";
#my $URL = "https://github.com/mib1085/circleci-101/compare/fcb8cde83ec5...09e9bcf7ae77";
#my $URL = "https://github.com/mib1085/circleci-101/compare/219f8a72749e...580a9e9599d5";
my $URL = $ENV{'CIRCLE_COMPARE_URL'};

sub delete_fn {
  my $fn = $_[0];
  print "check_delete $fn\n";
  if ($fn =~ /^\w+\-[\w\-\/]+\/\w+/) {
    print "delete $fn\n";
  }
  print "\n";
}

sub deploy_fn {
  my $fn = $_[0];
  print "check_deploy $fn\n";
  if ($fn =~ /^\w+\-[\w\-\/]+\/\w+/) {
    print "deploy $fn\n";
  }
  print "\n";
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
      delete_fn($1);
    } elsif ($left =~ /^\// && $right =~ /^b\/(.*)/) {
      deploy_fn($1);
    } elsif ($left =~ /^a\// && $right =~ /^b\/(.*)/) {
      deploy_fn($1);
    }
  }
}

close CMD;
