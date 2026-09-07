# ============================================================
#  Thomas Was Alone 中英双语汉化补丁 - 安装脚本
#  由「安装汉化补丁.bat」调用,请勿单独删除本文件
# ============================================================
$ErrorActionPreference = 'Stop'
try { $host.UI.RawUI.WindowTitle = 'Thomas Was Alone Chinese Patch - Install' } catch { }

$patchData = Join-Path $PSScriptRoot 'ThomasWasAlone_Data'
if (-not (Test-Path $patchData)) {
    Write-Host ''
    Write-Host '[错误] 补丁目录中未找到 ThomasWasAlone_Data 文件夹,补丁文件不完整。' -ForegroundColor Red
    Read-Host '按回车键退出'
    exit 1
}

function Find-GameDir {
    $libs = @()
    try {
        $steam = (Get-ItemProperty 'HKCU:\Software\Valve\Steam' -ErrorAction Stop).SteamPath
        $libs += $steam
        $vdf = Join-Path $steam 'steamapps\libraryfolders.vdf'
        if (Test-Path $vdf) {
            foreach ($line in (Get-Content $vdf)) {
                if ($line -match '"path"\s+"(.+?)"') {
                    $libs += ($Matches[1] -replace '\\\\', '\')
                }
            }
        }
    } catch { }
    foreach ($lib in $libs) {
        $dir = Join-Path $lib 'steamapps\common\thomaswasalone'
        if (Test-Path (Join-Path $dir 'ThomasWasAlone.exe')) { return $dir }
    }
    return $null
}

Write-Host ''
Write-Host '================================================' -ForegroundColor Cyan
Write-Host '    Thomas Was Alone 中英双语汉化补丁 - 安装' -ForegroundColor Cyan
Write-Host '================================================' -ForegroundColor Cyan

# ---- 1. 定位游戏目录 ----
$gameDir = Find-GameDir
if ($gameDir) {
    Write-Host ''
    Write-Host "已自动检测到游戏目录:" -ForegroundColor Green
    Write-Host "  $gameDir"
    $ans = Read-Host '使用该目录安装汉化? (直接回车=是 / 输入 n=手动指定其他目录)'
    if ($ans -match '^[nN]') { $gameDir = $null }
}
while (-not $gameDir) {
    Write-Host ''
    $inp = Read-Host '请输入游戏根目录(包含 ThomasWasAlone.exe 的文件夹,可直接拖拽进来后回车)'
    $inp = $inp.Trim().Trim('"')
    if ($inp -and (Test-Path (Join-Path $inp 'ThomasWasAlone.exe'))) {
        $gameDir = $inp
    } else {
        Write-Host '  [!] 该目录下没有找到 ThomasWasAlone.exe,请重新输入。' -ForegroundColor Yellow
    }
}

$dataDir = Join-Path $gameDir 'ThomasWasAlone_Data'
if (-not (Test-Path $dataDir)) {
    Write-Host ''
    Write-Host '[错误] 游戏目录中缺少 ThomasWasAlone_Data 文件夹,请确认选择的是游戏根目录。' -ForegroundColor Red
    Read-Host '按回车键退出'
    exit 1
}

# ---- 2. 备份原版文件 ----
$backupDir = Join-Path $dataDir '_原版备份'
if (Test-Path $backupDir) {
    Write-Host ''
    Write-Host '检测到已有原版备份,跳过备份步骤(不会用汉化文件覆盖原版备份)。'
} else {
    $n = 0
    foreach ($f in (Get-ChildItem -Path $patchData -Recurse -File)) {
        $rel = $f.FullName.Substring($patchData.Length).TrimStart('\')
        $src = Join-Path $dataDir $rel
        if (Test-Path $src) {
            $dst = Join-Path $backupDir $rel
            New-Item -ItemType Directory -Path (Split-Path $dst -Parent) -Force | Out-Null
            Copy-Item -Path $src -Destination $dst -Force
            $n++
        }
    }
    Write-Host ''
    Write-Host "已备份 $n 个原版文件到: $backupDir" -ForegroundColor Green
}

# ---- 3. 写入汉化文件 ----
$n = 0
$failed = @()
foreach ($f in (Get-ChildItem -Path $patchData -Recurse -File)) {
    $rel = $f.FullName.Substring($patchData.Length).TrimStart('\')
    $dst = Join-Path $dataDir $rel
    $dstDir = Split-Path $dst -Parent
    if (-not (Test-Path $dstDir)) {
        New-Item -ItemType Directory -Path $dstDir -Force | Out-Null
    }
    try {
        Copy-Item -Path $f.FullName -Destination $dst -Force
        $n++
    } catch {
        $failed += $rel
    }
}

Write-Host ''
if ($failed.Count -eq 0) {
    Write-Host "已成功写入全部 $n 个汉化文件。" -ForegroundColor Green
} else {
    Write-Host "已写入 $n 个文件,但 $($failed.Count) 个文件写入失败(游戏可能正在运行,或被杀毒软件拦截):" -ForegroundColor Yellow
    $failed | ForEach-Object { Write-Host "  $_" -ForegroundColor Yellow }
    Write-Host '请关闭游戏后重新运行安装脚本。' -ForegroundColor Yellow
}

Write-Host ''
Write-Host '================================================' -ForegroundColor Green
Write-Host '                 汉化安装完成!' -ForegroundColor Green
Write-Host '================================================' -ForegroundColor Green
Write-Host ''
Write-Host '  现在启动游戏即可体验中英双语内容。'
Write-Host '  如需还原英文原版,请运行「卸载汉化补丁.bat」。'
Write-Host ''
Read-Host '按回车键退出'
exit 0
