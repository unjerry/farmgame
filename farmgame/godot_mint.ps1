$output = "godot_project_export.txt"

# 清空旧导出
if (Test-Path $output) {
    Remove-Item $output
}

# 需要导出正文内容的文本文件类型
$textExtensions = @(
    "*.godot",
    "*.gd",
    "*.tscn",
    "*.tres",
    "*.gdshader",
    "*.shader",
    "*.json",
    "*.cfg",
    "*.ini",
    "*.txt",
    "*.md",
    "*.csv",
    "*.theme"
)

"===== Godot Project Export =====" | Out-File $output -Encoding utf8
"Exported At: $(Get-Date)" | Out-File $output -Append -Encoding utf8
"" | Out-File $output -Append -Encoding utf8

# 先导出 project.godot
if (Test-Path "project.godot") {
    "===== project.godot =====" | Out-File $output -Append -Encoding utf8
    Get-Content "project.godot" -Raw | Out-File $output -Append -Encoding utf8
    "" | Out-File $output -Append -Encoding utf8
}

# 导出文本源码/场景/资源
Get-ChildItem . -Recurse -File -Include $textExtensions |
    Where-Object {
        $_.FullName -notmatch "\\\.godot\\" -and
        $_.FullName -notmatch "\\\.import\\" -and
        $_.Name -ne $output -and
        $_.Name -ne "project.godot"
    } |
    Sort-Object FullName |
    ForEach-Object {
        "===== $($_.FullName) =====" | Out-File $output -Append -Encoding utf8
        Get-Content $_.FullName -Raw | Out-File $output -Append -Encoding utf8
        "" | Out-File $output -Append -Encoding utf8
    }

# 导出资源文件列表，不导出二进制内容
"===== Asset Files =====" | Out-File $output -Append -Encoding utf8

$assetExtensions = @(
    "*.png",
    "*.jpg",
    "*.jpeg",
    "*.webp",
    "*.svg",
    "*.ogg",
    "*.wav",
    "*.mp3",
    "*.ttf",
    "*.otf",
    "*.aseprite",
    "*.kra"
)

Get-ChildItem . -Recurse -File -Include $assetExtensions |
    Where-Object {
        $_.FullName -notmatch "\\\.godot\\" -and
        $_.FullName -notmatch "\\\.import\\"
    } |
    Sort-Object FullName |
    ForEach-Object {
        $_.FullName | Out-File $output -Append -Encoding utf8
    }

"Export complete: $output"