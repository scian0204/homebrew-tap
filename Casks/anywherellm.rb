cask "anywherellm" do
  version "0.6.0"
  sha256 "87b8ca398048ac66b5217bd6790850493c892d92a37a09417a0a822bf01d3231"

  url "https://github.com/scian0204/AnywhereLLM/releases/download/v#{version}/AnywhereLLM-#{version}-macos.zip"
  name "AnywhereLLM"
  desc "Use an LLM in any focused text field via a global hotkey, without stealing focus"
  homepage "https://github.com/scian0204/AnywhereLLM"

  # 앱에 자체 업데이터(in-app self-update)가 있다. 자체 업데이트로 앱이 새 버전이 돼도
  # brew 리시트는 설치 시점 버전에 머물러, brew outdated가 실제로는 최신인 앱을
  # "구버전"으로 오탐한다. auto_updates true로 버전 관리를 앱에 위임 — brew는 최초
  # 설치만 담당하고, plain `brew outdated`/`brew upgrade`는 이 cask를 건드리지 않는다
  # (신규 설치 사용자는 여전히 최신 version/sha256으로 받는다).
  auto_updates true

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
