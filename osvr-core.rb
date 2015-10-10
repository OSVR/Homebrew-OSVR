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
  
  # two patches for SDL framework
  patch do
    url "https://github.com/d235j/OSVR-Core/commit/188c8738cad6cf65db658998a1d064ce29409378.diff"
    sha256 "d531c12b51b51797772a8c7e9172b645e349a69526fac6dbe6ad2ea392b53239"
  end
  patch do
    url "https://github.com/d235j/OSVR-Core/commit/bd0139d4077f5a4cc59c7a7d9cf302109543476c.diff"
    sha256 "58a61d2f1f14e9107a70dd6f3b4c7a1887e28a78bad8c2ced39e8804d951d494"
  end

  def install
    args = std_cmake_args
    if MacOS.prefer_64_bit?
      args << "-DCMAKE_OSX_ARCHITECTURES=#{Hardware::CPU.arch_64_bit}"
    elsif build.universal?
      args << "-DCMAKE_OSX_ARCHITECTURES=#{Hardware::CPU.universal_archs.as_cmake_arch_flags}"
    else
      args << "-DCMAKE_OSX_ARCHITECTURES=#{Hardware::CPU.arch_32_bit}"
    end

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
    end
  end
end
