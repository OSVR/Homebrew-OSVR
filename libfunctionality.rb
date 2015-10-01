class Libfunctionality < Formula
  desc "A minimal library for dynamically-loaded or statically-linked functionality modules."
  homepage "https://github.com/OSVR/libfunctionality"
  head "https://github.com/OSVR/libfunctionality.git"

  depends_on "cmake" => :build

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end

end
