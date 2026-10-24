cask "extend-computer" do
  version "0.3.1"
  sha256 "f2cca5d6a28f9d3df8f591ecf8b70476d64415eb2891836ac7e2e0c7a5d8cd0a"

  url "https://github.com/DaniGuardiola/extend.computer/releases/download/v#{version}/extend.computer-#{version}-universal.dmg"
  name "extend.computer"
  desc "Share keyboard, mouse and displays between your devices"
  homepage "https://extend.computer/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :ventura

  app "extend.computer.app"

  uninstall quit: "computer.extend.desktop"

  # Pairings and device identity live here; zap removes them.
  zap trash: [
    "~/Library/Application Support/extend.computer",
    "~/Library/Caches/computer.extend.desktop",
    "~/Library/HTTPStorages/computer.extend.desktop",
    "~/Library/Preferences/computer.extend.desktop.plist",
    "~/Library/WebKit/computer.extend.desktop",
  ]
end
