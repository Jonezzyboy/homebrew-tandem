cask "tandem" do
  version "0.2.0"
  sha256 "c6ce445f9681d2534a5bc271210cba33bb5ac99047b32d8665427843094a50ca"

  url "https://github.com/Jonezzyboy/tandem/releases/download/v#{version}/Tandem_v#{version}_macos_universal.zip"
  name "Tandem"
  desc "Worktrees, merge order and linked PRs for one change across many repos"
  homepage "https://github.com/Jonezzyboy/tandem"

  depends_on formula: "gh"
  depends_on :macos

  app "Tandem.app"

  # Ad-hoc signed rather than notarised, so Gatekeeper blocks first launch
  # otherwise. Drop once the build carries a Developer ID signature.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/Tandem.app"],
        writable_paths: ["Tandem.app"],
        writable_base:  :appdir
  end

  # Changes and worktrees under ~/code/.tandem are the user's work, so zap
  # leaves them alone.
  zap trash: [
    "~/Library/Caches/com.alanjones.tandem",
    "~/Library/HTTPStorages/com.alanjones.tandem",
    "~/Library/Saved Application State/com.alanjones.tandem.savedState",
    "~/Library/WebKit/com.alanjones.tandem",
  ]
end
