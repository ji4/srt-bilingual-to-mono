# SRT Bilingual to Monolingual Converter

A shell script that extracts the first language from bilingual SRT subtitle files, converting them to monolingual subtitles.

## 🎯 Purpose

This tool is designed for bilingual SRT files where each subtitle entry contains two lines:
- First line: Primary language (e.g., Chinese, Japanese, Korean)
- Second line: Secondary language (e.g., English)

The script extracts only the first language line, creating clean monolingual subtitle files.

## ✨ Features

- 🔄 **Batch Processing**: Handle multiple SRT files at once
- 🌐 **Cross-platform**: Works with both Unix (`\n`) and Windows (`\r\n`) line endings
- 📁 **Organized Output**: Creates a dedicated folder for processed files
- 🛡️ **Error Handling**: Validates input files and provides clear feedback
- 🏷️ **Clear Naming**: Adds `_mono.srt` suffix to processed files

## 📋 Requirements

- Bash shell
- AWK (available on most Unix-like systems)

## 🚀 Usage

### Make the script executable
```bash
chmod +x srt-bilingual-to-mono.sh
```

### Process single file
```bash
./srt-bilingual-to-mono.sh video.srt
```

### Process multiple files
```bash
./srt-bilingual-to-mono.sh video1.srt video2.srt video3.srt
```

### Process all SRT files in current directory
```bash
./srt-bilingual-to-mono.sh *.srt
```

## 📊 Before and After Comparison

| **Before (Bilingual SRT)** | **After (Monolingual SRT)** |
|----------------------------|------------------------------|
| <br>1<br>00:00:05,000 --> 00:00:08,000<br>你好，世界！<br>Hello, World!<br><br>2<br>00:00:10,000 --> 00:00:13,000<br>這是一個測試字幕<br>This is a test subtitle<br><br>3<br>00:00:15,000 --> 00:00:18,000<br>歡迎使用這個工具<br>Welcome to use this tool<br><br>4<br>00:00:20,000 --> 00:00:23,000<br>希望對你有幫助<br>Hope this helps you<br> | <br>1<br>00:00:05,000 --> 00:00:08,000<br>你好，世界！<br><br>2<br>00:00:10,000 --> 00:00:13,000<br>這是一個測試字幕<br><br>3<br>00:00:15,000 --> 00:00:18,000<br>歡迎使用這個工具<br><br>4<br>00:00:20,000 --> 00:00:23,000<br>希望對你有幫助<br> |

## 📂 File Organization

```
your-project/
├── original-video.srt                   # Original bilingual file
├── srt-bilingual-to-mono.sh             # The converter script
└── monolingual_srt/                     # Auto-created output folder
    └── original-video_mono.srt          # Converted monolingual file
```

## 💡 Example Workflow

1. **Start with bilingual SRT files:**
   ```
   lecture-01.srt
   lecture-02.srt
   tutorial-video.srt
   ```

2. **Run the converter:**
   ```bash
   ./srt-bilingual-to-mono.sh *.srt
   ```

3. **Get organized output:**
   ```
   lecture-01.srt
   lecture-02.srt  
   tutorial-video.srt
   monolingual_srt/
   ├── lecture-01_mono.srt
   ├── lecture-02_mono.srt
   └── tutorial-video_mono.srt
   ```

## ⚙️ Technical Details

- **Input Format**: Standard SRT files with bilingual content
- **Output Format**: Standard SRT files with monolingual content
- **Line Ending Support**: Both Unix (`\n`) and Windows (`\r\n`)
- **Encoding**: Preserves original file encoding
- **Safety**: Never modifies original files

## 🛠️ Troubleshooting

### Empty output files?
- Ensure your SRT file follows the standard bilingual format
- Check that each subtitle entry has exactly two content lines
- Verify the file uses standard SRT timestamp format

### Script not executable?
```bash
chmod +x srt-bilingual-to-mono.sh
```

### Files not found?
- Check file paths and ensure SRT files exist
- Use quotes around filenames with spaces: `"my video.srt"`

## 🤝 Contributing

Feel free to submit issues, feature requests, or pull requests to improve this tool.

## 📄 License

This project is open source and available under the MIT License.

## 🙏 Acknowledgments

Created to help content creators and language learners work with bilingual subtitle files more efficiently.