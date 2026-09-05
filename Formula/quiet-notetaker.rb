class QuietNotetaker < Formula
  desc "Record, transcribe and write up your meetings, all on your own Mac"
  homepage "https://github.com/vgupta98/quiet-notetaker"
  url "https://github.com/vgupta98/quiet-notetaker/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "70ee6d74a8f72ceecb89b8bfa1bbec233fe48ece6db774c6e7774085882926bf"
  license "MIT"
  head "https://github.com/vgupta98/quiet-notetaker.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  # ScreenCaptureKit's microphone capture and the per-process Core Audio calls
  # both need a recent macOS. The Swift targets build for 15.0.
  depends_on macos: :sequoia
  depends_on "ffmpeg"
  depends_on "whisper-cpp"

  def install
    system "make", "build"
    libexec.install Dir["*"]
    (bin/"qn").write_env_script libexec/"qn", PATH: "#{HOMEBREW_PREFIX}/bin:$PATH"
  end

  def caveats
    <<~EOS
      Two things are still needed, and neither can be installed for you.

      1. The models, about 600 MB. They go in your home directory, not in the
         Cellar, so an upgrade never fetches them again:

           qn setup

      2. The Claude CLI, which writes the notes. It is not in Homebrew:

           https://claude.com/claude-code

      Then grant Microphone and Screen Recording permission to the terminal you
      run qn from, in System Settings > Privacy & Security. Screen Recording is
      how macOS lets any app hear the other people in a call, and without it a
      meeting is never detected.

      Check everything with:

        qn doctor

      To let Claude search your meetings:

        claude mcp add quiet-notetaker -- python3 #{libexec}/mcp/server.py
    EOS
  end

  test do
    # `qn` with no arguments prints its own command list and exits 0.
    assert_match "qn watch", shell_output("#{bin}/qn")

    # The watcher's own checks: the state machine, the window rules and the
    # event format, none of which need a microphone or a meeting.
    assert_match "all checks passed", shell_output("#{libexec}/build/watcher --self-test")

    # doctor exits non-zero here, because the models and the Claude CLI are
    # absent in a sandbox. What matters is that it reports rather than crashes.
    output = shell_output("#{bin}/qn doctor 2>&1", 1)
    assert_match "speech model", output
  end
end
