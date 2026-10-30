cask "syzify" do
  arch arm: "aarch64", intel: "x64"

  version "0.12.0"
  sha256 arm:   "1f2dd73027e1329a9b69e78f33a18b8285666931e89b3a1339f6b8f6e90b9416",
         intel: "597f5d702d1ffd15d928827ab5e3b5bf970af041e2550eec9d43d8fdead68556"

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
