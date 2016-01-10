class Libfunctionality < Formula
  desc "Minimal library for dynamically-loaded or statically-linked functionality modules."
  homepage "https://github.com/OSVR/libfunctionality"
  head "https://github.com/OSVR/libfunctionality.git"

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
end
