#
# This class centralizes log formatting for the module.
#
# TODO:
# - Add unit testing
#
define secure_windows::log (
  Boolean $enabled = true,
  Enum['alert', 'crit', 'debug', 'emerg', 'err', 'info', 'notice', 'warning'] $threatlevel = 'warning',
) {

  if $enabled {
    # puppetserver.log
    case $threatlevel {
      'alert':   { alert("${facts['fqdn']}: ${title}") }    # always visible
      'crit':    { crit("${facts['fqdn']}: ${title}") }     # always visible
      'debug':   { debug("${facts['fqdn']}: ${title}") }    # visible only with -d or --debug
      'emerg':   { emerg("${facts['fqdn']}: ${title}") }    # always visible
      'err':     { err("${facts['fqdn']}: ${title}") }      # always visible
      'info':    { info("${facts['fqdn']}: ${title}") }     # visible only with -v or --verbose or -d or --debug
      'notice':  { notice("${facts['fqdn']}: ${title}") }   # always visible
      'warning': { warning("${facts['fqdn']}: ${title}") }  # always visible
      default:   { warning("${facts['fqdn']}: ${title}") }  # always visible
    }

    # puppet agent logging
    notify { "puppetagentlogger_${title}":
      withpath => false,
      message  => $title,
      loglevel => $threatlevel,
    }

  }

}
