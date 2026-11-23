# Catch the Stars

《Catch the Stars》是一款单人 2D 接星小游戏。用左右方向键移动角色，在 30 秒内接住从上方落下的星星，每接住一颗得 1 分。项目已于 2026 年 11 月 22 日结项归档。

## 运行方式

1. 用 Godot 4.7 系列编辑器导入本目录的 `project.godot`。归档验收使用 Windows 上的 Godot 4.7.2 stable。
2. 等待素材导入完成，按 `F5` 运行项目。
3. 点击 **Start Game** 开始，用 `←` / `→` 移动。倒计时结束后查看得分，点击 **Play Again** 重开。

## 功能与技术栈

- 开始菜单、左右移动及边界限制、星星随机生成和下落、碰撞收集、粒子反馈、实时计分、30 秒倒计时、结算与重开。
- 循环背景音乐，以及按钮、收集和结算音效。
- Godot 4、GDScript、GL Compatibility 渲染、SVG 图像和 WAV 音频。

## 文件结构

| 路径 | 用途 |
| --- | --- |
| `project.godot` | 项目配置和入口 |
| `main.tscn`、`main.gd` | 主场景、界面、回合流程和音频触发 |
| `player.tscn`、`player_body.gd` | 角色场景、移动和边界限制 |
| `star.tscn`、`star.gd` | 星星场景、下落和碰撞 |
| `background.gd`、根目录的 `*.svg` | 运行时绘制的背景、角色与星星图像、项目图标 |
| `assets/audio/` | 背景音乐和音效 |
| `player.gd` | 保留的早期角色脚本，当前场景未引用 |
| `PROJECT_CLOSEOUT.md` | 验收结果与归档记录 |

## 已知限制

- 单人键盘玩法，分数仅保留在当局。
- 归档版使用当前场景中的现有美术，v0.2 美术未接入。
- 本次归档提供 Godot 源码工程。Windows Release 未导出。
