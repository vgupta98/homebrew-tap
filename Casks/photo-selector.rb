cask "photo-selector" do
  version "1.5.0"
  sha256 "d7cc5498f8f1425239d3ca86b43139c8605c6f2a2157a070e145c3e4e7326a49"

  url "https://github.com/vgupta98/photo-selector/releases/download/v#{version}/Rhenium-#{version}.dmg"
  name "Rhenium"
  desc "Browse, favourite and export photos from a local folder"
  homepage "https://github.com/vgupta98/photo-selector"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :big_sur

  app "Rhenium.app"

  zap trash: "~/Library/Caches/PhotoSelector"

  caveats <<~EOS
    #{token} is not signed with an Apple Developer ID or notarized, so on first
    launch macOS Gatekeeper will block it. After installing, clear the quarantine
    flag once:

      xattr -dr com.apple.quarantine "/Applications/Rhenium.app"

    or right-click the app in Finder and choose Open.
  EOS
end
