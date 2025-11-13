# Zsh Rapid Install

一键安装 Zsh + Oh My Zsh + Powerlevel10k 主题和常用插件。

## 支持的系统

- Ubuntu / Debian
- macOS

## 功能特性

- 自动检测操作系统并使用对应的包管理器
- 安装 Zsh 和 Oh My Zsh
- 安装三个最佳插件：
  - `zsh-autosuggestions` - 命令自动建议
  - `zsh-syntax-highlighting` - 语法高亮
  - `zsh-completions` - 额外的命令补全
- 安装并配置 Powerlevel10k 主题
- 自动备份配置文件
- 完整的错误处理

## 快速开始

### 方法 1: 一键执行（推荐）

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/yourusername/zsh_rapid_install/main/install.sh)
```

### 方法 2: 克隆后执行

```bash
# 克隆仓库
git clone https://github.com/yourusername/zsh_rapid_install.git
cd zsh_rapid_install

# 添加执行权限
chmod +x install.sh

# 运行安装脚本
./install.sh
```

### 方法 3: 手动执行命令

如果你想手动执行命令，可以参考 `zsh rapid install.txt` 文件中的命令。

## 安装后

1. 重启终端或运行 `exec zsh`
2. Powerlevel10k 配置向导会自动启动
3. 按照提示自定义你的命令行样式

## 字体推荐

为了获得最佳显示效果，建议安装 Meslo Nerd Font：

[下载 Meslo Nerd Font](https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k)

## 备份文件

脚本会在修改配置前自动创建备份：
- `.zshrc.backup.YYYYMMDD_HHMMSS`

## 故障排除

### macOS 上 Homebrew 未安装

脚本会自动检测并安装 Homebrew。

### 权限问题

如果遇到权限问题，确保以正确的用户身份运行脚本（不要使用 root）。

### 插件已存在

脚本会检测已安装的组件并跳过，不会重复安装。

## 卸载

如果需要卸载，可以运行：

```bash
# 恢复备份的配置
cp ~/.zshrc.backup.YYYYMMDD_HHMMSS ~/.zshrc

# 删除 Oh My Zsh
rm -rf ~/.oh-my-zsh

# 恢复默认 shell (bash)
chsh -s /bin/bash
```

## License

MIT