cask "igor-computer" do
  version "0.3.0"
  sha256 "3a1793695812de172db88e2a319555593feae0c80cb53b7b17f268765ea7a31a"

  url "https://github.com/DaniGuardiola/igor.computer/releases/download/v#{version}/igor.computer-#{version}-arm64.dmg"
  name "igor.computer"
  desc "Persistent computer for AI agents, with human takeover over MCP"
  homepage "https://github.com/DaniGuardiola/igor.computer"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on formula: "docker"
  depends_on formula: "docker-buildx"
  depends_on formula: "lima"
  depends_on formula: "qemu"
  depends_on macos: :ventura

  app "igor.computer.app"

  uninstall launchctl: "ai.igor.computer.server",
            quit:      "ai.igor.computer"

  # Computers and their data (Lima VMs, Docker volumes, state) are never removed here.
  zap trash: [
    "~/Library/Application Support/igor.computer/server",
    "~/Library/Logs/igor.computer",
    "~/Library/Preferences/ai.igor.computer.plist",
  ]
end
