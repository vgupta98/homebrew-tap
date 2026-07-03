cask "rhenium" do
  version "1.8.0"
  sha256 "f73b4174cde5dc353b098886616602ed8c04a7cdc40ff300e70b9f94cace6ef4"

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
