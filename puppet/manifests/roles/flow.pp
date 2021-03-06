# == Class: role::flow
# Configures Flow, a MediaWiki discussion system.
class role::flow {
    include role::mediawiki
    include role::parsoid
    include role::mantle

    mediawiki::extension { 'Flow':
        needs_update => true,
        settings     => template('flow-config.php.erb'),
        priority     => $::LOAD_LAST,  # load *after* Mantle and Echo
    }
}
