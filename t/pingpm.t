use Test;

BEGIN {plan tests => 5};


eval { require Net::Ping::HTTP; return 1;};
ok($@,'');
croak() if $@;  # If Net::Ping::HTTP didn't load... bail hard now


my $pinger = new Net::Ping::HTTP();

ok($pinger->{TIMEOUT},10);
ok(ref($pinger->{UA}),"LWP::UserAgent");
ok($pinger->{TIMEOUT},$pinger->{UA}->timeout());

my $count = 0;

# eval this code in case ps is not a happy camper on this platform
eval {
  my @process = `ps -ef`; 
  $count = grep /apache2/, @process;
  my $rc = $pinger->ping("http://localhost");
  if ($rc >= 500) {
      croak();
  }
};

skip(!$count,$@,'');

