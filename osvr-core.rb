class OsvrCore < Formula
  desc "OSVR Core Libraries"
  homepage "http://www.osvr.org"
  head "https://github.com/OSVR/OSVR-Core.git"

  depends_on "cmake" => :build
  depends_on "opencv"
  depends_on "libfunctionality"
  depends_on "boost"
  depends_on :python
  depends_on "libusb"

  option :universal

  def install
    args = std_cmake_args
    if build.universal?
      ENV.universal_binary
      args << "-DCMAKE_OSX_ARCHITECTURES=#{Hardware::CPU.universal_archs.as_cmake_arch_flags}"
    end

    # work around https://github.com/OSVR/OSVR-Core/issues/321
    cd "vendor/vrpn/submodules/hidapi" do
      system "git reset --hard c7f35c3a462aa5eec16d6e2e521e121aa7734bf9"
      system "git remote set-url origin https://github.com/signal11/hidapi.git"
      system "git fetch origin"
      system "git checkout d17db57b9d4354752e0af42f5f33007a42ef2906"
    end

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
    end
  end
end
