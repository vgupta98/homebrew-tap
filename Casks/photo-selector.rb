cask "photo-selector" do
  version "1.5.1"
  sha256 "f1c204ddb118591de04bf3da941f9c7b874288e9df1189d0397a9abb0b5003b8"

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
