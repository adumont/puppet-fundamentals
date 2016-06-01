require 'facter'

Facter.add(:testalex) do
  setcode do
    Facter::Util::Resolution.exec("echo Alex")
  end
end
