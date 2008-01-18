use inc::Module::Install;

name 'Catalyst-Component-ACCEPT_CONTEXT';
all_from 'lib/Catalyst/Component/ACCEPT_CONTEXT.pm';

build_requires 'Catalyst::Runtime';
build_requires 'Test::WWW::Mechanize::Catalyst';
build_requires 'Test::More';
build_requires 'ok';

WriteAll();
