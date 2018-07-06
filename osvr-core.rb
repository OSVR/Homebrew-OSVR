class OsvrCore < Formula
  desc "OSVR Core Libraries"
  homepage "http://www.osvr.org"
  head "https://github.com/OSVR/OSVR-Core.git"

  depends_on "cmake" => :build
  depends_on "homebrew/science/opencv"
  depends_on "libfunctionality"
  depends_on "boost"
  depends_on "jsoncpp"
  depends_on "python@2" => :build
  depends_on "libusb"

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
end
