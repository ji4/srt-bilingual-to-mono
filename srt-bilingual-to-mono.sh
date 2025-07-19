#!/bin/bash
# srt-bilingual-to-mono.sh
# Extract first language line from bilingual SRT subtitle files
# Converts bilingual SRT (Chinese/English) to monolingual SRT (Chinese only)
# Author: Claude AI
# Version: 1.0

# Check if input parameters are provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <SRT_file1> [SRT_file2] ..."
    echo "Function: Extract first language from bilingual SRT subtitles"
    echo "Example: $0 file1.srt file2.srt"
    echo "Example: $0 *.srt"
    echo ""
    echo "用法: $0 <SRT檔案1> [SRT檔案2] ..."
    echo "功能: 從雙語SRT字幕中提取第一語言（通常為中文）"
    exit 1
fi

# 處理每個輸入檔案
for input_file in "$@"; do
    # 檢查檔案是否存在
    if [ ! -f "$input_file" ]; then
        echo "錯誤: 檔案 '$input_file' 不存在"
        continue
    fi
    
    # 獲取檔案目錄和檔名
    file_dir=$(dirname "$input_file")
    file_name=$(basename "$input_file" .srt)
    
    # Create output directory for monolingual subtitles
    output_dir="${file_dir}/monolingual_srt"
    mkdir -p "$output_dir"
    
    # Set output file path (marked as monolingual version)  
    output_file="${output_dir}/${file_name}_mono.srt"
    
    echo "Processing: $input_file"
    echo "Output to: $output_file"
    
    # Process SRT file (handle both Unix and Windows line endings)
    awk '
    BEGIN {
        subtitle_num = ""
        timestamp = ""
        chinese_line = ""
        in_subtitle = 0
        line_count = 0
    }
    
    {
        # Remove carriage return characters for Windows compatibility
        gsub(/\r/, "")
    }
    
    # Process subtitle number
    /^[0-9]+$/ {
        # If there was previous subtitle content, output it first
        if (subtitle_num != "" && timestamp != "" && chinese_line != "") {
            print subtitle_num
            print timestamp
            print chinese_line
            print ""
        }
        
        subtitle_num = $0
        timestamp = ""
        chinese_line = ""
        in_subtitle = 1
        line_count = 0
        next
    }
    
    # Process timestamp
    /^[0-9]{2}:[0-9]{2}:[0-9]{2},[0-9]{3} --> [0-9]{2}:[0-9]{2}:[0-9]{2},[0-9]{3}$/ {
        timestamp = $0
        line_count = 0
        next
    }
    
    # Process empty lines
    /^$/ {
        if (in_subtitle && subtitle_num != "" && timestamp != "" && chinese_line != "") {
            print subtitle_num
            print timestamp
            print chinese_line
            print ""
        }
        subtitle_num = ""
        timestamp = ""
        chinese_line = ""
        in_subtitle = 0
        line_count = 0
        next
    }
    
    # Process subtitle content
    {
        if (in_subtitle && subtitle_num != "" && timestamp != "" && NF > 0) {
            line_count++
            # Only keep the first line (Chinese)
            if (line_count == 1) {
                chinese_line = $0
            }
        }
    }
    
    END {
        # Process the last subtitle group
        if (subtitle_num != "" && timestamp != "" && chinese_line != "") {
            print subtitle_num
            print timestamp
            print chinese_line
        }
    }
    ' "$input_file" > "$output_file"
    
    echo "Completed: $output_file"
    echo "------------------------"
done

echo "All files processed successfully!"