class SteamvrOsvr < Formula
  desc "SteamVR-OSVR"
  homepage "https://github.com/OSVR/SteamVR-OSVR"
  head "https://github.com/OSVR/SteamVR-OSVR.git"

  depends_on "osvr-core"

  depends_on "cmake" => :build

  option :universal

  def install
    args = std_cmake_args
    if build.universal?
      ENV.universal_binary
      args << "-DCMAKE_OSX_ARCHITECTURES=#{Hardware::CPU.universal_archs.as_cmake_arch_flags}"
    end
    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
    end
  end

  def caveats
    if self.installed? && File.exist?("#{opt_prefix}/drivers/osvr/bin/osx32/driver_osvr.dylib")
      return <<-EOS.undent
        driver_osvr.dylib was installed to:
          #{opt_prefix}/drivers/osvr/bin/osx32/driver_osvr.dylib

        You will want to symlink this driver to the SteamVR drivers location:
          mkdir -p "$HOME/Library/Application Support/Steam/steamapps/common/SteamVR/drivers/osvr/bin/osx32"
          ln -s "#{opt_prefix}/drivers/osvr/bin/osx32/driver_osvr.dylib" "$HOME/Library/Application Support/Steam/SteamApps/common/SteamVR/drivers/osvr/bin/osx32"
        You may additionally want to modify steamvr.vrsettings to force-enable the osvr driver.
      EOS
    end
    nil
  end
end
