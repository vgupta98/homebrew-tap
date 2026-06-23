cask "rhenium" do
  version "1.6.0"
  sha256 "e5cea6df337ca0da3fb52f8e2ea28841790d2376ccef56bb99331857ac51b7d4"

  url "https://github.com/vgupta98/rhenium/releases/download/v#{version}/Rhenium-#{version}.dmg"
  name "Rhenium"
  desc "Browse, favourite and export photos from a local folder"
  homepage "https://github.com/vgupta98/rhenium"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :big_sur

  app "Rhenium.app"

  zap trash: "~/Library/Caches/Rhenium"

  caveats <<~EOS
    #{token} is not signed with an Apple Developer ID or notarized, so on first
    launch macOS Gatekeeper will block it. After installing, clear the quarantine
    flag once:

      xattr -dr com.apple.quarantine "/Applications/Rhenium.app"

    or right-click the app in Finder and choose Open.
  EOS
end
