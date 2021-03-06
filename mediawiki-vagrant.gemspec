$:.push File.expand_path('../lib', __FILE__)

require 'mediawiki-vagrant/version'

Gem::Specification.new do |s|
    s.name = 'mediawiki-vagrant'
    s.summary = 'A portable MediaWiki development environment.'
    s.description = (<<-end_).split.join(' ')
        MediaWiki-Vagrant is a portable MediaWiki development environment. It
        consists of a set of configuration scripts that automate the creation
        of a virtual machine that runs MediaWiki.
    end_

    s.platform = Gem::Platform::RUBY
    s.authors = ['Ori Livneh']
    s.email = ['ori@wikimedia.org']
    s.homepage = 'https://github.com/wikimedia/mediawiki-vagrant'
    s.licenses = ['MIT']

    s.files = Dir['{lib}/**/*'] + ['LICENSE', 'Gemfile', 'README.md']
    s.version = MediaWikiVagrant::VERSION

    s.require_paths = ['lib']
end
