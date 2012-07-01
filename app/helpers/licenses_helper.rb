module LicensesHelper
  def link_to_license(license)
    homepage = license.homepage || "https://google.com/?q=ruby%20#{license.name}"
    name     = license.homepage ? license.name : "#{license.name} (Google)"
    link_to name, homepage, :target => :blank
  end
end
