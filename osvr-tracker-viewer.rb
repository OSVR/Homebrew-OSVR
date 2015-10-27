class OsvrTrackerViewer < Formula
  homepage "https://github.com/OSVR/OSVR-Tracker-Viewer"
  head "https://github.com/OSVR/OSVR-Tracker-Viewer.git"

  depends_on "cmake" => :build
  depends_on "osvr-core"
  depends_on "open-scene-graph"

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end

end
