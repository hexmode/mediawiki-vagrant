# == Class: role::textextracts
# Configures TextExtracts, a MediaWiki extension which provides an
# API for getting text extracts of articles
class role::textextracts {
    include role::mediawiki

    mediawiki::extension { 'TextExtracts': }
}
