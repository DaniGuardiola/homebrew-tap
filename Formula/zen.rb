class Zen < Formula
  desc "Companion for zen.dio.la: a quiet conversation with a Madhyamaka monk"
  homepage "https://zen.dio.la"
  url "https://github.com/DaniGuardiola/zen.dio.la/releases/download/v0.2.0/zen-0.2.0-darwin-arm64.tar.gz"
  sha256 "7bf6a79cb7a557fa0bbe9b0f59ab8eb6c0219bcd630ae2c8658f19a8786efeb7"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos
  depends_on "uv" # builds the local voice environment on first use

  def install
    libexec.install "zen-companion", "web", "speech"
    (bin/"zen").write <<~SH
      #!/bin/sh
      export ZEN_WEB_DIR="#{libexec}/web"
      export ZEN_SPEECH_DIR="#{libexec}/speech"
      exec "#{libexec}/zen-companion" "$@"
    SH
  end

  service do
    run [opt_bin/"zen"]
    keep_alive true
    environment_variables PATH: "#{HOMEBREW_PREFIX}/bin:/usr/bin:/bin:#{Dir.home}/.local/bin"
    log_path var/"log/zen.log"
    error_log_path var/"log/zen.log"
  end

  def caveats
    <<~EOS
      Start the companion, then open https://zen.dio.la
        brew services start daniguardiola/tap/zen

      The monk speaks through Claude Code: install it and sign in first.
      Voice models (~1 GB) download the first time you turn voice on.
    EOS
  end

  test do
    port = free_port
    pid = spawn({ "ZEN_PORT" => port.to_s, "ZEN_DATA_DIR" => testpath.to_s }, bin/"zen")
    sleep 2
    assert_match "\"app\":\"zen\"", shell_output("curl -s http://127.0.0.1:#{port}/health")
  ensure
    Process.kill("TERM", pid)
  end
end
