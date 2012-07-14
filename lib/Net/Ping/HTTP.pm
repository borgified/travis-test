package Net::Ping::HTTP;

=head1 NAME

Net::Ping::HTTP - An interface for determining whether an HTTP
server is listening

=head1 SYNOPSIS

my $pinger = new Net::Ping::HTTP;
my $rc = $pinger->ping('http://localhost');

my $pinger = new Net::Ping::HTTP(
                               TIMEOUT => 15,
                               PROXY => 'http://someproxy.net',
                              );
my $rc = $pinger->ping('http://www.ibm.com');

=head1 DESCRIPTION

Net::Ping::HTTP is a simple interface on top of LWP::UserAgent
that lets you ping a Web server to see if it is responding to HTTP
requests.  This would make it suitable for monitoring Web applications.

=head1 AUTHOR

Sean Dague <sldague@us.ibm.com>

=head1 SEE ALSO

L<perl>, <LWP::UserAgent>

=cut

use strict;
use LWP::UserAgent;
use HTTP::Request;
use vars qw($VERSION);

$VERSION = '0.02';

sub new {
    my $class = shift;
    my %this = (
              PROXY => undef,
              TIMEOUT => 10,
              @_,
              );
  
    my $ua = new LWP::UserAgent;
    $this{UA} = $ua;
    $this{UA}->timeout($this{TIMEOUT});
    if($this{PROXY}) {
        $this{UA}->proxy('http',$this{PROXY});
    }

    return bless \%this, $class;
}

sub ping {
    my ($this, $url) = @_;
  
    my $request = new HTTP::Request('HEAD',"$url");
    my $response = $this->{UA}->request($request);
  
    return $response->code();
}

1;
