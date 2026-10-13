[中文](README.md) · **English**

# Thomas Was Alone — Chinese/English Bilingual Localization Patch
<p align="center">
  <b>Thomas Was Alone — Steam PC · Full Chinese/English bilingual localization</b><br>
  One-click install · Automatic backup of originals · One-click restore · No effect on saves or achievements
</p>

>  **Game Steam store page**: [Thomas Was Alone - Steam](https://store.steampowered.com/app/220780/Thomas_Was_Alone/) (AppID: `220780`)

---

## Overview
**Thomas Was Alone** is a minimalist platform-puzzle game developed by **Mike Bithell** and released in 2012. A handful of differently shaped blocks tell a small story about friendship and self-identity, narrated with dry, understated British wit. The game is excellent, but its entirely English narration and interface are a barrier for many players.

This repository provides a **complete Chinese/English bilingual localization patch** for the Steam PC version of the game:

| Localization scope | Details |
| --- | --- |
| Narration subtitles | Narration subtitles for every level, shown as Chinese alongside the English original |
| Chapter quotes | The opening quote of each chapter, in bilingual form |
| UI and menus | All interface text: main menu, level select, options, pause menu, and more |
| Credits | Job titles translated; personal names kept in English |
| Hard-coded text | Fixes 10 strings hard-coded in the program (skip prompt, `--LOCKED--`, window/fullscreen options, etc.) |
| Chinese font | The patch has a Chinese font **embedded** — no system font installation required |

**Scope**: All 317 strings are translated, 231 of them hand-polished (tighter phrasing, Chinese punctuation, preserving the original's dry humour).

## Game version information
| Item | Info |
| --- | --- |
| Game title | Thomas Was Alone |
| Steam store page | [store.steampowered.com/app/220780](https://store.steampowered.com/app/220780/Thomas_Was_Alone/) |
| Steam AppID | 220780 |
| Supported patch version | Steam build **309510** (the patch was built and fully tested against this version) |
| Engine | Unity 4.5.1f3 (Mono runtime) |
| Platform | Windows (PC) |
| Official update status | No official updates since its 2012 release; the version this patch targets should in principle remain valid indefinitely |

> This patch was built and fully tested against the Steam Windows version in the table above; versions from other stores (GOG / Epic, etc.) have not been tested (see the FAQ below).

## Features
- **Bilingual side by side**: Subtitles and quotes show the Chinese translation and the English original at the same time, so you can compare and savour the source text
- **One-click install**: The installer locates the Steam game directory automatically — no need to find the path by hand
- **Automatic backup**: On first install, every replaced original file is backed up automatically, ready to restore at any time
- **Clean uninstall**: One click restores the original English version with no leftovers
- **Safe, with no side effects**: Only text and font resource files are replaced; game logic is untouched, and saves, achievements, and Steam Cloud saves are unaffected

## Installation
### Requirements
- Windows 7 SP1 or later (the installer uses the built-in PowerShell)
- The **Steam** version of Thomas Was Alone (versions from other stores are untested)
- No prerequisite patches or runtimes required

### Option 1: One-click script (recommended)
1. **Download the patch**: open the [**Releases**](../../releases) page on the right of this repo and download the latest `ThomasWasAlone-CN-Patch-vX.X.X.zip`;
2. **Extract**: unzip the archive to any location;
3. **Run**: double-click `安装汉化补丁.bat`;
4. **Confirm the directory**: the script auto-detects the Steam game directory and shows the path — just press **Enter** to confirm. If it isn't detected, enter the game's root directory when prompted (or drag the folder into the window and press Enter);
5. **Done**: when you see `汉化安装完成!`, it worked — **launch the game** and enjoy the Chinese!

>  On first install, the script automatically backs up every replaced original file into `ThomasWasAlone_Data\_原版备份`. This backup is what the uninstall restores from — do not delete it manually.

### Option 2: Manual file replacement
1. Download and extract the patch (as above);
2. Open the Steam client → right-click **Thomas Was Alone** in your library → **Manage** → **Browse local files** to open the game's root directory;
3. **Copy** the patch's entire `ThomasWasAlone_Data` folder into the game's root directory;
4. When Windows warns that the destination already contains a folder with the same name, choose **"Replace the files in the destination"** (this only overwrites 129 text/font resource files and deletes nothing else);
5. Launch the game.

>  Before installing manually, it's a good idea to copy the game's `ThomasWasAlone_Data` folder somewhere else as a backup.

## Uninstall
Either method works:

- **Script restore**: double-click `卸载汉化补丁.bat` in the patch folder; the script restores every original file from `_原版备份`;
- **Steam verify**: in your Steam library, right-click the game → Properties → Installed Files → **Verify integrity of game files**. Steam will restore all modified files to the official originals.

## FAQ
<details>
<summary><b>The game is still in English after installing?</b></summary>

- Make sure the `ThomasWasAlone_Data` folder was copied into the **game root directory** (the same folder as `ThomasWasAlone.exe`);
- If you installed manually, make sure you chose "Replace the files in the destination" in the replacement prompt;
- Make sure the game isn't set to read-only by Steam and that it is the Steam version (this patch only supports the Steam version).
</details>

<details>
<summary><b>Subtitles show boxes / missing glyphs?</b></summary>

The patch has a complete Chinese font embedded, so glyphs should not be missing under normal conditions. If they are, make sure you downloaded the complete Release archive (don't download only individual files from the repo); if the problem persists, report it under [Issues](../../issues).
</details>

<details>
<summary><b>Does it affect saves and achievements?</b></summary>

No. The patch only replaces text and font resource files; it does not touch any game logic, save data, or the achievement system.
</details>

<details>
<summary><b>Does it support GOG / Epic or other store versions?</b></summary>

This patch was built and tested for the **Steam version**; versions from other stores are untested. If the asset structure is the same it should in principle work, but back up first and try at your own risk — no guarantee is given.
</details>

<details>
<summary><b>The game starts fullscreen — how do I switch to windowed mode?</b></summary>

In the main menu, choose OPTIONS → WINDOW MODE to toggle between windowed and fullscreen (that option has been localized too).
</details>

<details>
<summary><b>Will the patch stop working if the game updates?</b></summary>

Thomas Was Alone has had no official updates since its 2012 release (the current Steam build is 309510). This patch is built on that version and should in principle remain valid indefinitely. If a future official update breaks compatibility, feel free to open an Issue and I'll adapt it as soon as I can.
</details>

## Translation notes
- **Format**: Level subtitles and chapter quotes use a "Chinese translation ↵ English original" bilingual layout; menus and interface text use "Chinese + space + English"; credits translate job titles while keeping personal names in English;
- **Style**: The original narration is written in calm, restrained British dry humour. The translation is polished and localized on top of a faithful rendering of the meaning, preserving much of the original's flavour;
- **Font solution**: The game's native fonts contain no Han characters, so the patch redirects the UI font to an embedded **Microsoft DengXian font subset**, packaged inside the patch and usable offline.
- **Reference text**: The complete bilingual text of all 333 strings is collected in [孤独的托马斯_汉化文本对照.txt](./孤独的托马斯_汉化文本对照.txt) in the repository root, ordered by game progression, with each string's in-game location and write format documented.

## 📂 Directory structure
```text
thomas-was-alone-cn/
├── 安装汉化补丁.bat                 # One-click install entry point (double-click to run)
├── 卸载汉化补丁.bat                 # One-click restore-to-English entry point (double-click to run)
├── install.ps1                      # Install logic (auto-detect / backup / write)
├── uninstall.ps1                    # Uninstall logic (restore from backup)
├── 孤独的托马斯_汉化文本对照.txt      # Full bilingual text of all translations (for reference / proofreading)
├── README.md                        # This file
└── ThomasWasAlone_Data/             # Localization resource files (mirrors the game directory structure)
    ├── mainData                     # Main menu text
    ├── level0 ~ level126            # Level subtitles and quotes (124 levels containing text)
    ├── sharedassets0.assets         # Chinese font
    ├── sharedassets1.assets         # Chinese font
    ├── sharedassets6.assets         # Pause menu text
    └── Managed/
        └── Assembly-UnityScript.dll # Hard-coded UI text fixes
```

## Changelog
### v1.0.0 (2026-09-08)
- First public release;
- Full localization of all 317 strings (narration subtitles / chapter quotes / menus and UI / credits);
- Fixed 10 hard-coded English strings inside the program;
- Embedded Chinese font (Microsoft DengXian subset);
- One-click install / uninstall scripts with automatic backup of the original files.

## Disclaimer
- This patch is a **fan-made localization**, provided for learning and exchange only, and is not affiliated with the game's official parties (Mike Bithell, etc.);
- The patch's assets are modified from the retail game's assets; all related copyrights belong to the original rights holders. **Please buy the game to support it** ([Steam store page](https://store.steampowered.com/app/220780/Thomas_Was_Alone/));
- Commercial use of this patch is strictly prohibited; when reposting, credit this repository's address;
- Any consequences of using this patch are borne by the user (the patch only replaces resource files, so the risk is very low).
