cask "rhenium" do
  version "1.7.0"
  sha256 "7c4c0ad59542dbe51839a3ece3d7fa1d4291c6f40b78466765f4262eaf05a921"

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
