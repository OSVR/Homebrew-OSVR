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

  patch do
    url 'https://github.com/OSVR/OSVR-Core/commit/4eda17bb9197dc312e36fe5e7255219391d3ac4c.patch'
    sha256 'c5a87d0cd6425bcaad2d1f2fbc27684390133d85cd5aae7b028858dc83dc0ce3'
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
