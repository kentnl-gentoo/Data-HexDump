# -*- mode: Perl -*-

##########################################################################
#
#   HexDump.pm  -  A Simple Hexadecial Dumper
#
# version : 0.01
# Copyright (c) 1998, 1999, Fabien Tassin <fta@oleane.net>
##########################################################################
# ABSOLUTELY NO WARRANTY WITH THIS PACKAGE. USE IT AT YOUR OWN RISKS.
##########################################################################

package Data::HexDump;

use strict;
use vars qw(@ISA $VERSION @EXPORT);
use Exporter;
@ISA = ('Exporter');
$VERSION = 0.01;
@EXPORT = qw(HexDump);

sub HexDump ($) {
  my $val = shift;
  $val = "" unless defined $val;
  my $out;
  my ($i, $j, $l);
  $out = "          ";
  $l = "";
  for ($i = 0; $i < 16; $i++) {
    $out .= sprintf "%02X", $i;
    $out .= " " if $i < 15;
    $out .= "- " if $i == 7;
    $l .= sprintf "%X", $i;
  }
  $i = $j = 0;
  $out .= sprintf "  $l\n\n%08X  ", $j * 16;
  $l = "";
  while (my $v = substr $val, 0, 1, '') {
    $out .= sprintf "%02X", ord $v;
    $out .= " " if $i < 15;
    $out .= "- " if $i == 7 && length $val;
    $i++;
    $l .= $v =~ m/^[\w\d \/\*\$\%\!;,\?&\#{\[\|\`\\\@\]\)\(\-\+=]$/o ?
		    $v : ".";
    if ($i == 16) {
      $i = 0;
      $j++;
      $out .= "  " . $l;
      $l = "";
      $out .= "\n";
      $out .= sprintf "%08X  ", $j * 16 if length $val;
    }
  }
  if ($i || (!$i && !$j)) {
    $out .= " " x (3 * (17 - $i) - 2 * ($i > 8));
    $out .= "$l\n";
  }
  $out;
}

1;

=head1 NAME

Data::HexDump - A Simple Hexadecial Dumper

=head1 SYNOPSIS

  use Data::HexDump;

  my $buf = "foo\0bar";
  print HexDump $buf;

=head1 DESCRIPTION

Dump in hexadecimal the content of a scalar. The result is returned in a
string. Each line of the result consists of the offset in the
source in the leftmost column of each line, followed by one or more
columns of data from the source in hexadecimal. The rightmost column
of each line shows the printable characters (all others are shown
as single dots).

=head1 COPYRIGHT

Copyright (c) 1998-1999 Fabien Tassin. All rights reserved.
This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=head1 AUTHOR

Fabien Tassin E<lt>fta@oleane.netE<gt>

=head1 VERSION

0.01 - Initial release (July 1999)

=head1 SEE ALSO

perl(1)

=cut
