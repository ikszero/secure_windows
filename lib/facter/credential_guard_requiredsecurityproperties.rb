# Custom fact displaying the state of Microsoft Defender Credential Guard property:
# RequiredSecurityProperties
#
Facter.add(:credential_guard_requiredsecurityproperties) do
  confine operatingsystem: :windows

  setcode do
    powershell = File.exist?("#{ENV['SYSTEMROOT']}\\system32\\windowspowershell\\v1.0\\powershell.exe") ? "#{ENV['SYSTEMROOT']}\\system32\\windowspowershell\\v1.0\\powershell.exe" : 'powershell.exe'
    command = 'Get-CimInstance -ClassName Win32_DeviceGuard -Namespace root\Microsoft\Windows\DeviceGuard | select RequiredSecurityProperties | FT -HideTableHeaders'

    requiredsecurityproperties = Facter::Core::Execution.exec(%(#{powershell} -command "#{command}"))

    case requiredsecurityproperties
    when %r{2, 3}
      'secure boot'
    when %r{2}
      'secure boot and dma protection'
    else
      'unconfigured'
    end
  end
end
