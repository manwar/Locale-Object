package Locale::Object::DB::Schemata

use strict;
use warnings::register;
use vars qw($VERSION);

$VERSION = "0.31";

# DO NOT LEAVE IT IS NOT REAL

sub new
{
  return "This module contains documentation only. Please use Locale::Object::DB.";
}

1;

__END__

=head1 NAME

Locale::Object::DB::Schemata - schema documentation for the Locale::Object database

=head1 VERSION

0.31

=head1 DESCRIPTION

This module documents the database used by the L<Locale::Object> modules.

=head1 THE DATABASE

The database of locale information used by the Locale::Object modules uses L<DBD::SQLite>, and contains several tables.

=head2 the 'country' table

    CREATE TABLE country (
        code_alpha2           char(2),
        code_alpha3           char(3),
        code_numeric          smallint,
        name                  char(100),
        dialing_code          smallint,
        utc_offset_main       char(5),
        utc_offsets_all       char(50),
        PRIMARY KEY           (code_alpha2)
    );

=over 4

* C<code_alpha2> , C<code_alpha3>, C<code_numeric> and C<name> are data from ISO 3166 - see L<http://ftp.ics.uci.edu/pub/ietf/http/related/iso3166.txt>.

* C<dialing_code> is an International Direct Dialing code - see L<http://kropla.com/dialcode.htm>.

* C<utc_offset_main> is the time offset of the time zone of the country's capital from UTC, expressed decimally in hours. C<utc_offsets_all> is a comma-separated list of offsets for all time zones that the country falls across, listed from west to east. If there is only one value this will match C<utc_offset_main>.

=back

=head2 the 'currency' table

    CREATE TABLE currency (
        country_code   char(2),
        name           char(100),
        code           char(3),
        code_numeric   smallint,
        symbol         char(20),
        subunit        char(100),
        subunit_amount smallint,
        PRIMARY KEY  (country_code)
    );

=over 4

* C<country_code> contains ISO 3166 two-letter country codes, as in the previous table.

* C<name> and C<code> contain ISO 4217 three-letter codes and names for world currencies - see L<http://fx.sauder.ubc.ca/iso4217.html>.

* C<symbol>, C<subunit> and C<subunit_amount> contain currency symbols, subunits (such as cents) and the amounts of subunits that comprise a single currency unit (such as 100 [cents in a dollar]). This data was sourced from L<http://fx.sauder.ubc.ca/currency_table.html>.

=back

=head2 the 'continent' table
    
    CREATE TABLE continent (
        country_code char(2),
        name         char(13),
        PRIMARY KEY  (country_code)
    );

=over 4

* C<country_code> contains ISO 3166 two-letter codes again, and C<name> contains associated continent names (Africa, Asia, Europe, North America, Oceania and South America). Sourced from L<http://www.worldatlas.com/cntycont.htm>.

=back

=head2 the 'language' table
    
    CREATE TABLE language (
        code_alpha2  char(2),
        code_alpha3  char(3),
        name         char(100),
        PRIMARY KEY  (code_alpha2)
    );

=over 4

* C<code_alpha2> contains 2-letter ISO 639-1 language codes. See  L<http://www.loc.gov/standards/iso639-2/englangn.html>.

* C<code_alpha3> contains 3-letter ISO 639-2. There two parts of ISO 639-2, B (for 'bibliographic') and T (for 'terminology'), which differ in 23 instances out of the full list of 464 codes. For simplicity, this module uses the ISO 639-2/T versions. For more information, see the URL above and also L<http://www.loc.gov/standards/iso639-2/develop.html>.

* C<name> contains the standard names of languages in English as defined by ISO 639.

=back

=head2 the 'language_mappings' table

    CREATE TABLE language_mappings (
        id           char(4),
        country      char(2),
        language     char(3),
        official     boolean,
        PRIMARY KEY (id)
    );
    
An example section of this table:

    ID   COUNTRY  LANGUAGE  OFFICIAL
    at_0   at       ger      true
    at_1   at       slv      false
    at_2   at       hrv      false
    at_3   at       hun      false

What this tells us is that in Austria, four languages are spoken: German, Slovenian, Croatian (Hrvatska) and Hungarian, and that only German is an official language of Austria. The mappings are ranked in order of prevalence of language, official languages first, followed by non-official. Please note that this is approximate at best. 

My original source for the language-country mappings was L<http://www.infoplease.com/ipa/A0855611.html>. However, there is no clear origin for this list, which occurs in several places on the Web, and it required some serious rationalization before data was able to be usefully extracted for it.
 
In addition to the preceding, the following sources were invaluable:

=over 4

* L<http://www.nationmaster.com/>

* L<http://www.ethnologue.com/>

* L<http://www.wikipedia.org/>

=back

=head1 AUTHOR

Earle Martin <EMARTIN@cpan.org>

=over 4 

=item L<http://purl.oclc.org/net/earlemartin/>

=back

=head1 CREDITS

See the credits for L<Locale::Object>.

=head1 LEGAL

Copyright 2003 Fotango Ltd. All rights reserved. L<http://opensource.fotango.com/>

This module is released under the same license as Perl itself, and is provided on an "as is" basis. The author and Fotango Ltd make no warranties of any kind, either expressed or implied, as to the accuracy and/or utility of any results obtained from its use. However, if you do find something wrong with the results, please let the author know. Thanks.

=cut
