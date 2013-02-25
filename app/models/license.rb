class License < ActiveRecord::Base
  attr_accessible :current_version, :homepage, :license, :name, :previous_license, :previous_version

  def self.load_from_gemfile(root_path)
    old_gemfile = ENV['BUNDLE_GEMFILE']
    gemfile     = ENV['BUNDLE_GEMFILE'] = File.join(root_path, "Gemfile")
    lockfile    = File.join(root_path, "Gemfile.lock")
    definitions = Bundler::Definition.build(gemfile, lockfile, nil)
    definitions.resolve_remotely!

    definitions.specs.each do |spec|
      license = License.find_or_initialize_by_name(spec.name)
      license.homepage = spec.homepage if spec.homepage
      if license.current_version != spec.version.to_s
        license.previous_version = license.current_version.dup if license.current_version
        license.previous_license = license.license.dup if license.license
        license.current_version = spec.version.to_s
        license.license         = spec.license
      end
      license.updated_at = Time.now
      license.save
    end
    ENV['BUNDLE_GEMFILE'] = old_gemfile
  end

end
