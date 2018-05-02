#! usr/bin/perl

use POSIX qw(strftime);
use Data::Dumper;
use lib ("");
use JSON::PP qw(decode_json);
my $run=0;
my $file_check=0;
while (1)
{
  $run ++;
  print "This is Run: $run.. \n";
#Variable Declaration;
my $env=0;
my $url;
my $data;
my $json;
my @datentime;
my $filename;
my $fh=Queue_report;

#Curl the API data
$url = `curl --negotiate -u: -H \"Content-Type: application\/json\" -GET http:\/\/guedlpa15ne04.devfg.rbc.com\:8088\/ws\/v1\/cluster\/scheduler 2> \/dev/null`;
if ($url =~ standby)
{
print "Trying the next one";
$url = `curl --negotiate -u: -H \"Content-Type: application\/json\" -GET http:\/\/guedlpa15nf03.devfg.rbc.com\:8088\/ws\/v1\/cluster\/scheduler 2> \/dev/null`;
}

#Convert EPOCH to Local time
my $date=$json->{scheduler}->{schedulerInfo}->{health}->{lastrun};
$date= scalar $date/1000;
$date=strftime('%d/%m/%Y %H:%M', localtime($date));
@datentime = split(' ',$date);

# File Creation if it does not Exist

$datentime[0] =~ tr/\//_/;
$filename = "csv/$datentime[0]_queuereport.csv";
if (-f $filename)
{
print "File $filename Exists \n";
} else
{
print "File Does not Exist... Creating One \n";
open $fh, '>>', "$filename";
print $fh "DAY,TIME,QUEUE-NAME,MINIMUM-THRESHOLD,USED-CAPACITY,MAXIMUM-THRESHOLD";
close $fh;
}

# Open Filhandle
open $fh,'>>', "$filename";

#Loop Through Environment
for ($env=0;$env<3;$env++)
{
my $base_tag=$json->{scheduler}->{schedulerInfo}->{queue}->{queue};
my $env_tag=$base_tag->{$env};
print_json($env_tag, \@datentime,$fh);

my $transit=0;
for($transit_tag=0;$transit<25;$transit++)
{
my $transit_tag=$env_tag->{queues}->{queue}->{$transit};
if (defined($transit_tag->{queueNAme}))
{
print_json($transit_tag,\@datentime,$fh);
}
else
{
last;
}
my $project=0;
for($project=0;$project<25;$project++)
{
my $project_tag=$transit_tag->{queues}->{queue}->{$project};
if (defined($project_tag->{queueName}))
{
print_json($project_tag,\@datentime,$fh);
}
else
{
last;
}
}
}
}
close $fh;
print "Sleeping for 5 seconds \n";
sleep(5);

} #End of While loop

sub print_json()
{
# PArse Variable
$root_tag = $_[0];
my @datentime = @{$_[1]};
my $fh=$_[2];

#Print Output
$output="$datentime[0]\,$datentime[1]\,$root_tag->{queueName}\,$root_tag->{absoluteCapacity}\,$root_tag->{absoluteUsedCapacity}\,$root_tag->{absoluteMaxCapacity}\n";
print $fh, $output;
}
