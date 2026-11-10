cask "extend-computer" do
  version "0.4.0"
  sha256 "4a116ec90591eb215f9850936c341c72ad05bd8e71a0fd87efe43fd54f97d89a"

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
