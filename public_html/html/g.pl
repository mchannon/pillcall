#!/usr/bin/perl

#e-mail generator

use DBI();
use Getopt::Long;
use Mail::Sendmail;
use CGI;



$versionRequired = 0;


%data_received = &Get_Data();
&No_SSI(*data_received);

foreach $key (keys(%data_received)) {
         $data_received{$key} =~ s/$ASCII_ten//ge;
        $data_received{$key} =~ s/$ASCII_thirteen/$space/ge;
}

my $dummy2 = $data_received{"name"};
my $dummy = $data_received{"email"};
my $emailfield = $data_received{"orangepeel"};
my $phoneID = $data_received{"p"};
my $appVersion = $data_received{"v"};
$email = $data_received{"umbrella"};
my $option = $data_received{"r"};
my $ip = $data_received{"i"};
my $xxb = $data_received{"b"};
my $xxc = $data_received{"c"};
my $message = $data_received{"message"};
my $phoneNumber = $data_received{"pn"};
my $nname = $data_received{"namo"};

chomp( $emailfield );
chomp( $phoneNumber );
chomp( $message );
chomp( $nname );

$ox = 'None Selected';

if ( $option eq "cc" ) {
  $ox = 'Credit Card Deposit';}

if ( $option eq "c2" ) {
  $ox = 'Check By Mail, $5 Minimum';}

if ( $option eq "cm" ) {
  $ox = 'Check By Mail, 99c Fee';}

if ( $option eq "dw" ) {
  $ox = 'Pay by Dwolla';}

if ( $dummy2 || $dummy )
{
  print "Status: 302 Moved\nLocation: http://getbent.com\n\n";
  exit; 
}

if ( index($emailfield,"@" ) == -1 )
{
  print "Status: 302 Moved\nLocation: http://getbent.com\n\n";
  exit; 
}

if (!( $nname || $message || $emailfield ))
{
  print "Status: 302 Moved\nLocation: http://google.com\n\n";
  exit;
}  

if ( ( ( $option eq "6" ) && ( ( ! $email ) || ( ! $message ) ||
     ( ! $nname ) || ( ! $phoneNumber ) ) ) )
{
  print "Status: 302 Moved\nLocation: http://db.listpop.net/contact.pl?"
   . "oops=1\n\n";
}

if ( ( ( $option eq "4" ) && ( ( ! $message ) ) ) )
{
  print "Status: 302 Moved\nLocation: http://db.listpop.net/current.pl?"
   . "oops=1\n\n";
}

if ( ( ( $option eq "2" ) && ( ( ! $message ) ||
     ( ! $nname ) || ( ! $phoneNumber ) ) ) )
{
  print "Status: 302 Moved\nLocation: http://db.listpop.net/contact.pl?"
   . "oops=1&ema=" . $email . "\n\n";
}


print "Content-type: text/html", "\n\n";        # MIME header.

my $dbh = DBI->connect("DBI:mysql:database=trans;host=localhost",
                         "root", "2getsome",
                         {'RaiseError' => 1});

if ( ! ( ( $option == '6' ) && ( ( ! $email ) || ( ! $message ) ||
     ( ! $nname ) || ( ! $phoneNumber ) ) ) )
#if ( 1 )
{

# is the app version current enough?
if ( $appVersion >= $versionRequired )
{

if ( $option == '1' ) {
    &Analytic( 16, $email, $ENV{REMOTE_ADDR}, $lon, $lat );
%mail = (
         from => 'unknown@mattchannon.com',
#         to => 'listpop@gmail.com',
         to => 'matt@loitery.com',
#         to => 'support@listpop.net',
         subject => 'Listpop Website: Cancel',
         'content-type' => 'text/html; charset="iso-8859-1"',
); }
if ( $option == '2' ) {
    &Analytic( 17, $email, $ENV{REMOTE_ADDR}, $lon, $lat );
%mail = (
         from => 'unknown@listpop.net',
#         to => 'listpop@gmail.com',
         to => 'matt@loitery.com',
#         to => 'support@listpop.net',
         subject => 'Listpop Business: Contact',
         'content-type' => 'text/html; charset="iso-8859-1"',
); }
if ( $option == '3' ) {
    &Analytic( 18, $email, $ENV{REMOTE_ADDR}, $lon, $lat );
%mail = (
         from => 'unknown@listpop.net',
#         to => 'listpop@gmail.com',
         to => 'matt@loitery.com',
#         to => 'support@listpop.net',
         subject => 'Listpop Phone: Contact',
         'content-type' => 'text/html; charset="iso-8859-1"',
); }
if ( $option == '4' ) {
    &Analytic( 19, $email, $ENV{REMOTE_ADDR}, $lon, $lat );
%mail = (
         from => 'unknown@mattchannon.com',
#         to => 'listpop@gmail.com',
         to => 'jordyn@pillcall.com',
#         to => 'support@listpop.net',
         subject => 'PillCall.com: Mail',
         'content-type' => 'text/html; charset="iso-8859-1"',
); }
if ( $option == '5' ) {
    &Analytic( 20, $email, $ENV{REMOTE_ADDR}, $lon, $lat );
%mail = (
         from => 'unknown@listpop.net',
#         to => 'listpop@gmail.com',
         to => 'matt@loitery.com',
#         to => 'support@listpop.net',
         subject => 'Listpop: Forgot Login',
         'content-type' => 'text/html; charset="iso-8859-1"',
); }
if ( $option == '6' ) {
    &Analytic( 21, $email, $ENV{REMOTE_ADDR}, $lon, $lat );
%mail = (
         from => 'unknown@listpop.net',
#         to => 'listpop@gmail.com',
         to => 'matt@loitery.com',
#         to => 'support@listpop.net',
         subject => 'Listpop Website: Contact',
         'content-type' => 'text/html; charset="iso-8859-1"',
); }


#<!--$mail{from} = $ip . '@listpop.net';-->

$mail{from} = 'internet@mattchannon.com';
$mail{to} = 'mattchannon@gmail.com';
$mail{body} = "E-mail: " . $emailfield . "\n\nMessage: " . $message . 
    "\n\nName: " . $nname . "\n\nUmbrella: " . $email;

sendmail(%mail) || print "Error: $Mail::Sendmail::error\n";

if ( $option == 1 )
{
print "Sorry to see you go.  Someone will contact you immediately.";
}
else
{
print "Message sent!";
#print "Sorry, this feature doesn't work.  Mail me at info .at. loitery.com."#Message sent!";
}
}
else
{
print "VER";
}

}
else
{
print "MALF";
print $email;
print "<br>";
print $message;
print "<br>";
print $nname;
print "<br>";
print $option;
print "<br>";
print $phoneNumber;
}


sub Analytic {
        my ($what, $which, $who, $whereX, $whereY) = @_;

	my $dba = DBI->connect("DBI:mysql:database=trans;host=localhost",
                         "root", "2getsome",
                         {'RaiseError' => 1});
        $whenn = time;

        $dba->do( "INSERT INTO ana (what, which, who, whenn, whereX, whereY )
        values (\"$what\", \"$which\", \"$who\", \"$whenn\", \"$whereX\",
                \"$whereY\")" );

            $dba->commit();
            $dba->disconnect;
        }



sub Get_Data {
        local (%user_data, $input_string, $nv_pair,
                @nv_pairs, $name, $value);

        if ( $ENV{'REQUEST_METHOD'} eq "POST" )
        {
                read(STDIN,$input_string,$ENV{'CONTENT_LENGTH'});
        }
        else {
                $input_string = $ENV{'QUERY_STRING'};
        }

        $input_string =~ s/\+/ /g;

        @nv_pairs = split(/&/, $input_string);

        foreach $nv_pair (@nv_pairs) {
               ($name, $value) = split(/=/, $nv_pair);
                $name =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C",hex($1))/ge;
                $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C",hex($1))/ge;
                if (defined($user_data{$name})) {
                        $user_data{$name} .= ":" . $value; }
                else {
                        $user_data{$name} = $value;
                }
        }
        return %user_data;
}

sub No_SSI {
         local (*data) = @_;
         foreach $key (sort keys(%data)) {
                $data{$key} =~ s/<!--(.|\n)*-->//g;
        }
}
