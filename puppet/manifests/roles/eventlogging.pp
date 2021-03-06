# == Class: role::eventlogging
# This role sets up the EventLogging extension for MediaWiki such that
# events are validated against production schemas but logged locally.
class role::eventlogging {
    include role::mediawiki
    include role::geshi

    # For testing against, with tox
    include packages::python3_2

    mediawiki::extension { 'EventLogging':
        priority => $::LOAD_EARLY,
        settings => {
            wgEventLoggingBaseUri => '//localhost:8100/event.gif',
            wgEventLoggingFile    => '/vagrant/logs/eventlogging.log',
        }
    }
}
