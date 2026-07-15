cask "anywherellm" do
  version "0.1.0"
  sha256 "f9d1679aca291b63f54c72e33a89fd0a60bdfcb6a6356837d8adc4fec72eb639"

  url "https://github.com/scian0204/AnywhereLLM/releases/download/v#{version}/AnywhereLLM-#{version}.zip"
  name "AnywhereLLM"
  desc "Use an LLM in any focused text field via a global hotkey, without stealing focus"
  homepage "https://github.com/scian0204/AnywhereLLM"

  depends_on macos: ">= :sonoma"

  app "AnywhereLLM.app"

  caveats <<~EOS
    공증(notarization) 없이 자가서명된 앱입니다. 격리 속성이 붙으면 macOS가
    "손상된 앱"으로 차단하므로 --no-quarantine 플래그로 설치하세요:

      brew install --cask --no-quarantine scian0204/tap/anywherellm

    이미 설치해서 차단됐다면:

      xattr -dr com.apple.quarantine /Applications/AnywhereLLM.app

    첫 실행 시 손쉬운 사용(Accessibility) 권한이 필요합니다.
  EOS

  zap trash: [
    "~/Library/Preferences/kr.scian0204.AnywhereLLM.plist",
  ]
end
