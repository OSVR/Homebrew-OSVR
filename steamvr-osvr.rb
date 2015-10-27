class SteamvrOsvr < Formula
  desc "SteamVR-OSVR"
  homepage "https://github.com/OSVR/SteamVR-OSVR"
  head "https://github.com/OSVR/SteamVR-OSVR.git"

  depends_on "cmake" => :build

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end

  def caveats
    if self.installed? && File.exist?("#{opt_prefix}/drivers/driver_osvr.dylib")
      return <<-EOS.undent
        driver_osvr.dylib was installed to:
          #{opt_prefix}/drivers/driver_osvr.dylib

        You will want to symlink this driver to the SteamVR drivers location:
          mkdir -p "~/Library/Application Support/Steam/steamapps/common/SteamVR/drivers/osvr/bin/osx32"
          ln -s "#{opt_prefix}/drivers/driver_osvr.dylib" "~/Library/Application Support/Steam/SteamApps/common/SteamVR/drivers/osvr/bin/osx32"
        You may additionally want to modify steamvr.vrsettings to force-enable the osvr driver.
      EOS
    end
    nil
  end
end
