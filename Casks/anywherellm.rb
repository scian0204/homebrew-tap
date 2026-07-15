cask "anywherellm" do
  version "0.1.0"
  sha256 "f9d1679aca291b63f54c72e33a89fd0a60bdfcb6a6356837d8adc4fec72eb639"

  url "https://github.com/scian0204/AnywhereLLM/releases/download/v#{version}/AnywhereLLM-#{version}.zip"
  name "AnywhereLLM"
  desc "Use an LLM in any focused text field via a global hotkey, without stealing focus"
  homepage "https://github.com/scian0204/AnywhereLLM"

  depends_on macos: :sonoma

  app "AnywhereLLM.app"

  # 공증 없는 자가서명 앱 — 격리 속성이 남으면 Gatekeeper가 "손상된 앱"으로 차단.
  # Homebrew 6에서 --no-quarantine 플래그가 제거되어 설치 시 직접 제거한다.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/AnywhereLLM.app"]
  end

  caveats <<~EOS
    공증(notarization) 없이 자가서명된 앱입니다. 설치 과정에서 격리(quarantine)
    속성을 자동 제거합니다. 그래도 실행이 차단되면 수동으로:

      xattr -dr com.apple.quarantine /Applications/AnywhereLLM.app

    첫 실행 시 손쉬운 사용(Accessibility) 권한이 필요합니다.
  EOS

  zap trash: [
    "~/Library/Preferences/kr.scian0204.AnywhereLLM.plist",
  ]
end
