# == Class: crm::drush
#
# Drush commandline Drupal manipulation
#
class crm::drush( $root ) {
    include ::crm
    include packages::drush

    $bare_cmd = "drush -y --root=${root}"
    $cmd = "sudo -u www-data ${bare_cmd}"
}
