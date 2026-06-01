cask "photo-selector" do
  version "1.3.0"
  sha256 "c1a7bb8d865043c0cb3eca97a62205cc2fa9b818ef5390efa7eadbf418012cf6"

  url "https://github.com/vgupta98/photo-selector/releases/download/v#{version}/PhotoSelector-#{version}.dmg"
  name "Photo Selector"
  desc "Browse, favourite and export photos from a local folder"
  homepage "https://github.com/vgupta98/photo-selector"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :big_sur"

  app "PhotoSelector.app"

  zap trash: "~/Library/Caches/PhotoSelector"

  caveats <<~EOS
    #{token} is not signed with an Apple Developer ID or notarized, so on first
    launch macOS Gatekeeper will block it. After installing, clear the quarantine
    flag once:

      xattr -dr com.apple.quarantine "/Applications/PhotoSelector.app"

    or right-click the app in Finder and choose Open.
  EOS
end
