#!/bin/bash
# chezmoi run_once: 安装并启动 yabai + skhd

set -e

# 安装
if ! command -v yabai &>/dev/null; then
    brew install koekeishiya/formulae/yabai
fi

if ! command -v skhd &>/dev/null; then
    brew install koekeishiya/formulae/skhd
fi

# 注册并启动服务（launchd，登录自动启动）
yabai --start-service
skhd --start-service
