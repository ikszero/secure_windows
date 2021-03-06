# This class manages:
# V-73689
# Windows Server 2016 must be configured to force users to log off when their allowed logon hours expire.
class secure_windows::stig::v73689 (
  Boolean $enforced = false,
) {
  if $enforced {
    local_security_policy { 'Network security: Force logoff when logon hours expire':
      ensure         => 'present',
      policy_setting => 'ForceLogoffWhenHourExpire',
      policy_type    => 'System Access',
      policy_value   => '1',
    }
  }
}
