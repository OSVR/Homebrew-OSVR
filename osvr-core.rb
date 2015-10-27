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

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end
end
