#!/bin/bash

# 檢查 ~/.config/nvim 目錄是否存在
if [ ! -d "$HOME/.config/nvim" ]; then
    echo "目錄 ~/.config/nvim 不存在，正在建立..."
    mkdir -p "$HOME/.config/nvim"
    echo "目錄已建立。"
else
    echo "目錄 ~/.config/nvim 已存在。"
fi

# 複製 coc-settings.json 到 ~/.config/nvim/ 目錄下
if [ -f "coc-settings.json" ]; then
    cp "coc-settings.json" "$HOME/.config/nvim/"
    echo "coc-settings.json 已複製到 ~/.config/nvim/ 目錄下。"
else
    echo "找不到 coc-settings.json 文件。"
fi

