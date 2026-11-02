cask "syzify" do
  arch arm: "aarch64", intel: "x64"

  version "0.13.1"
  sha256 arm:   "86f1bcd4f897aeafa6ad75766a2644be37e769e1bb8a11f103915305b442dede",
         intel: "3881c6281e005ffa041f634fcb543356d5e4c4f7e152de83311d7bd81cac6684"

  url "https://github.com/Stasyanz/syzify/releases/download/v#{version}/Syzify_#{version}_#{arch}.dmg"
  name "Syzify"
  desc "Private training log that keeps your activities on your computer"
  homepage "https://syzify.siliconbasement.com/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on :macos

  app "Syzify.app"

  # Syzify is not notarized by Apple yet, so macOS would call a quarantined copy
  # "damaged". This is the same step the website asks for after a manual download.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Syzify.app"]
  end

  # The vault holds the user's own activities and is never removed. Neither is
  # Application Support, whose only file records where a moved vault is.
  zap trash: [
    "~/Library/Caches/com.syzify.app",
    "~/Library/Preferences/com.syzify.app.plist",
    "~/Library/WebKit/com.syzify.app",
  ]

  caveats <<~EOS
    Syzify is not notarized by Apple. This cask removes the quarantine flag from
    the app so that it opens; you are trusting this tap and its GitHub releases.

    Syzify updates itself from inside the app.
  EOS
end
