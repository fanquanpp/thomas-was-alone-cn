# ============================================================
#  Thomas Was Alone 汉化补丁 - 卸载脚本(还原英文原版)
#  由「卸载汉化补丁.bat」调用
# ============================================================
$ErrorActionPreference = 'Stop'
try { $host.UI.RawUI.WindowTitle = 'Thomas Was Alone Chinese Patch - Uninstall' } catch { }

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
Write-Host '    Thomas Was Alone 汉化补丁 - 卸载/还原英文' -ForegroundColor Cyan
Write-Host '================================================' -ForegroundColor Cyan

# ---- 1. 定位游戏目录 ----
$gameDir = Find-GameDir
if ($gameDir) {
    Write-Host ''
    Write-Host "已自动检测到游戏目录:" -ForegroundColor Green
    Write-Host "  $gameDir"
    $ans = Read-Host '使用该目录卸载汉化? (直接回车=是 / 输入 n=手动指定其他目录)'
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

# ---- 2. 从备份还原 ----
$backupDir = Join-Path (Join-Path $gameDir 'ThomasWasAlone_Data') '_原版备份'
if (-not (Test-Path $backupDir)) {
    Write-Host ''
    Write-Host '未找到自动备份文件夹(_原版备份)。' -ForegroundColor Yellow
    Write-Host '如果你是手动替换安装的,请在 Steam 中右键游戏 → 属性 → 已安装文件 →'
    Write-Host '「验证游戏文件的完整性」,Steam 会自动还原所有被修改的文件。'
    Write-Host ''
    Read-Host '按回车键退出'
    exit 1
}

$n = 0
$failed = @()
foreach ($f in (Get-ChildItem -Path $backupDir -Recurse -File)) {
    $rel = $f.FullName.Substring($backupDir.Length).TrimStart('\')
    $dst = Join-Path (Join-Path $gameDir 'ThomasWasAlone_Data') $rel
    try {
        Copy-Item -Path $f.FullName -Destination $dst -Force
        $n++
    } catch {
        $failed += $rel
    }
}

Write-Host ''
if ($failed.Count -eq 0) {
    Write-Host "已成功还原 $n 个原版文件,游戏已恢复为英文原版。" -ForegroundColor Green
} else {
    Write-Host "还原了 $n 个文件,但 $($failed.Count) 个文件失败(游戏可能正在运行):" -ForegroundColor Yellow
    $failed | ForEach-Object { Write-Host "  $_" -ForegroundColor Yellow }
}

$ans = Read-Host '是否删除备份文件夹以彻底清理? (输入 y=删除 / 直接回车=保留)'
if ($ans -match '^[yY]') {
    Remove-Item -Path $backupDir -Recurse -Force
    Write-Host '备份文件夹已删除。' -ForegroundColor Green
}

Write-Host ''
Write-Host '卸载完成!感谢使用本汉化补丁。' -ForegroundColor Green
Write-Host ''
Read-Host '按回车键退出'
exit 0
