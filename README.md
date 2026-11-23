# Catch the Stars

《Catch the Stars》是一款单人 2D 接星小游戏。用 30 秒接住尽可能多的星星，每颗星星得 1 分。时间结束后可以查看得分并重开。

## 游玩

- **电脑浏览器**　点击 **Start Game**，用 `←` / `→` 移动。
- **手机浏览器**　建议横屏，点击 **Start Game**，按住游戏画面底部左侧或右侧的箭头移动。松开即停止。
- 回合结束后点 **Play Again** 重开。网页版在首次点击 **Start Game** 后播放背景音乐。

本地预览使用 HTTP 服务器提供 `web/`。例如，已安装 Python 3 时，在项目根目录执行 `python -m http.server 8000 --bind 127.0.0.1 --directory web`，再访问 `http://127.0.0.1:8000/`。浏览器需要 WebAssembly 和 WebGL 2.0。

## Godot 工程与导出

用 **Godot 4.7.2 stable** 导入 `project.godot`，等待资源导入后按 `F5`。项目使用 GDScript、GL Compatibility 渲染、SVG 和 WAV。

重新导出时，安装相同版本的导出模板，从 Godot 编辑器选择 **Project → Export → Web → Export Project**，关闭 **Export With Debug**，输出到 `web/index.html`。也可从项目根目录执行以下命令。Web 预设禁用了线程，所有生成文件需要一起发布并保留原文件名。

```sh
godot --headless --import
godot --headless --export-release Web web/index.html
```

## GitHub Pages

1. 创建一个空的公开仓库 `catch-the-stars`，推送本地 `main`。也可以推送原始结项标签 `archive-2026-11-22`。
2. 在仓库 **Settings → Pages → Build and deployment → Source** 选择 **GitHub Actions**。
3. 在 **Actions → Deploy game to GitHub Pages → Run workflow** 选择 `main`。成功后从部署记录打开公开地址，默认格式为 `https://<GitHub 用户名>.github.io/catch-the-stars/`。

工作流只部署 `web/`。HTML 用相对路径加载 JS、WASM、PCK 和音频脚本，以支持 GitHub Pages 的仓库子路径。

## 版本与文件

| 路径或标签 | 内容 |
| --- | --- |
| `archive-2026-11-22`、`PROJECT_CLOSEOUT.md` | 原始结项快照和当时的验收记录 |
| `main.tscn`、`main.gd` | 菜单、计时计分、结算和音频 |
| `player.tscn`、`player_body.gd`、`star.tscn`、`star.gd` | 角色移动与星星碰撞 |
| `touch_controls.gd` | 触屏按钮布局与绘制 |
| `assets/audio/`、根目录的 SVG | 原有音频和美术资源 |
| `export_presets.cfg`、`web/`、`.github/workflows/pages.yml` | Web 导出预设、静态发布文件及 Pages 工作流 |

Web 适配增加了触屏操作、16:9 等比显示、手势后启动网页音频和 Pages 发布配置。宽屏或竖屏窗口会保留黑边。分数只保留在当局，v0.2 美术未接入。
