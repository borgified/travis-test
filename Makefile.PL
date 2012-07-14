use ExtUtils::MakeMaker;
WriteMakefile(
    'NAME'              => 'Net::Ping::HTTP',
    'VERSION_FROM'      => 'lib/Net/Ping/HTTP.pm', # finds $VERSION
	'PREREQ_PM' => {
		LWP::UserAgent	=> 6.03,
		HTTP::Request	=> 6.00,
	},
);
