# image2 游戏素材提示词

**User:** Anonymous  
**Created:** 5/21/2026 13:39:05  
**Updated:** 5/21/2026 13:39:58  
**Exported:** 5/29/2026 15:10:13  
**Link:** [https://chatgpt.com/g/g-p-6a0726e9c8d481919ecf0cf10ca9305b-farmgame/c/6a0e9a74-9dbc-83eb-bc4a-bdf2fe19009a](https://chatgpt.com/g/g-p-6a0726e9c8d481919ecf0cf10ca9305b-farmgame/c/6a0e9a74-9dbc-83eb-bc4a-bdf2fe19009a)  

## Prompt:
5/21/2026, 1:38:58 PM

我想使用image2在这里生成游戏素材图片，我该如何做？如何写提示词

## Response:
5/21/2026, 1:39:04 PM

> **Searching how to use image generation models**
>
> [OpenAI | Research & Deployment](https://openai.com/)
> [OpenAI](https://en.wikipedia.org/wiki/OpenAI)
> [GPT Image 1.5 Prompt Guide: Master OpenAI's Latest Model](https://www.creati.studio/blog/gpt-image-1-5-prompt-guide/)
> [ULTIMATE GPT IMAGE 1.5 TUTORIAL: 15 PROMPT ...](https://www.youtube.com/watch?v=QT1nMo-QMDQ)
> [Prompting - Resource](https://academy.openai.com/public/clubs/work-users-ynjqu/resources/prompting)
> [Image prompt engineering techniques - Microsoft Foundry](https://learn.microsoft.com/en-us/azure/foundry/openai/concepts/gpt-4-v-prompt-engineering)
> [OpenAI](https://www.linkedin.com/company/openai)
> [OpenAI's updated image generator can now pull information from the web](https://www.theverge.com/ai-artificial-intelligence/916166/openai-chatgpt-images-2)
> [OpenAI Beefs Up ChatGPT's Image Generation Model](https://www.wired.com/story/openai-beefs-up-chatgpts-image-generation-model)
> [OpenAI just made it harder to turn your pics into Studio Ghibli-style images](https://www.businessinsider.com/openai-chatgpt-studio-ghibli-style-images-generation-grok-claude-genai-2025-3)
> [A Prompt Log Analysis of Text-to-Image Generation Systems](https://arxiv.org/abs/2303.04587)
>
> **Searching for official OpenAI citation on image 2.0**
>
> [Introducing ChatGPT Images 2.0 | OpenAI](https://openai.com/index/introducing-chatgpt-images-2-0/)
>
> **Clarifying pixel art constraints for tile generation**
>
> If AI can't generate precise pixel sheets, I’ll start with a 512x512 concept, then manually refine it. The perspective needs to be 2D top-down or 3/4 top-down, without complex backgrounds or shadows. I'll use bright, clean pixel art with limited colors, no text or photorealism. For Godot, tiles will be 16x16 or 32x32, with 1px padding.
>
> Thought for 19s

我会按你现在这个 Godot/像素农场项目来讲，不讲泛泛的 AI 画图。重点是：怎么把需求拆成可生成的素材、提示词怎么写、哪些信息必须固定住。

可以。你这里说的 **image2**，可以理解成在 ChatGPT 里直接让图像模型生成素材。它现在适合做：**像素风概念图、物品图标、单个场景物件、UI 草图、tileset 初稿、角色设定表**。但要注意：它对 **严格 16×16 像素级可直接进 Godot 的成品** 不一定稳定，所以最好流程是：

**先让它生成风格统一的素材图 → 你确认方向 → 再让我帮你拆成 Godot 用的 atlas / 图标规范 / TileSet 配置计划。**

OpenAI 官方也把 ChatGPT Images 2.0 定位为支持更强的图像控制、文字渲染、多语言、像素风等多种视觉风格的图像生成能力。([OpenAI](https://openai.com/index/introducing-chatgpt-images-2-0/))

---

## 你现在最适合这样写提示词

核心格式：

```text
生成一张用于 Godot 2D top-down 农场游戏的像素风游戏素材。

素材内容：
[具体物体]

用途：
[地图物件 / TileSet / UI 图标 / 背包物品图标 / 角色精灵]

画面规格：
[透明背景 / 单个物体居中 / 16x16像素风 / 适合放大到64x64使用]

视角：
2D top-down，类似农场 RPG 地图素材，不要横版视角，不要3D透视。

风格：
明快但带有崩溃未来文明感，现代中国东北小城/新车站废墟气质，色彩清晰，轮廓明确，适合游戏内识别。

限制：
不要文字，不要UI边框，不要复杂背景，不要写实照片，不要3D渲染，不要模糊，不要过多细节。

输出：
PNG风格，透明背景，像素艺术，边缘干净。
```

---

## 针对你项目的固定提示词前缀

以后你每次生成素材，可以先复制这一段：

```text
生成用于 Godot 4 的 2D top-down 像素风农场游戏素材。游戏基础美术按 16x16 像素设计，在引擎中放大到 64x64 使用。风格是明快、清晰、可读性强的像素艺术，但世界观是崩溃后的未来中国东北小城：现代设施废弃、局部损坏、带一点温暖的废墟重建感。不要写实，不要3D，不要复杂背景，不要文字。透明背景，单个素材居中，轮廓清楚。
```

然后后面加具体内容。

---

## 例子 1：生成水池 / 水泵素材

```text
生成用于 Godot 4 的 2D top-down 像素风农场游戏地图物件。

内容：
一个废弃维护水池，池子连接一根破损的下水管。水池目前是满水状态，水面略脏但有反光，旁边有生锈金属边框和破裂水泥。破损下水管从池子下方伸出，管口有裂缝，但不要太恐怖。

规格：
单个地图物件，透明背景，适合占用 2x2 个 16x16 tile，也就是最终在 Godot 中约 128x128 显示。

视角：
2D top-down / 轻微俯视，适合农场 RPG 地图。

风格：
明快像素风，清晰轮廓，和星露谷式地图素材一样易读，但不要直接模仿星露谷。带有崩溃未来文明、现代中国小城废墟感。

限制：
不要人物，不要文字，不要UI，不要大背景，不要3D，不要写实，不要过度细节。
```

---

## 例子 2：生成背包物品图标

```text
生成一个 Godot 农场游戏用的背包物品图标。

物品：
破损的水泵零件，一个小型生锈金属泵芯，带一点蓝色旧漆和铜管。

规格：
像素风图标，透明背景，单个物品居中，适合 16x16 或 32x32 图标使用，放大后仍然清晰。

风格：
明快、清楚、轮廓明确，略带废弃未来中国工业设施感。

限制：
不要文字，不要边框，不要背景，不要阴影太重，不要写实，不要3D。
```

---

## 例子 3：生成 TileSet atlas 初稿

这个要谨慎，因为 AI 不一定能严格切格。但可以这样写：

```text
生成一张 Godot 2D top-down 农场游戏用的像素风 TileSet atlas 初稿。

规格：
16x16 tile，8列4行，共32个小格。每个格子必须是独立 tile，边界清晰，正交俯视，不要透视。透明背景或纯色背景。

内容包括：
1-4：普通泥土地块，带轻微变化
5-8：可耕作土地，干土、湿土、翻土、播种土
9-12：石砖路面，破损现代广场砖风格
13-16：水泥地面，裂缝、污渍、旧工业地面
17-20：草地，杂草，枯草，碎石草地
21-24：浅水边缘、水面、脏水、水管口
25-28：废弃金属地板、格栅、管线、警示条
29-32：边缘装饰，小碎石、裂缝、杂物、青苔

风格：
明快像素风，清晰可读，适合 Godot TileMapLayer 使用。崩溃未来文明，中国东北现代小城废墟感。

限制：
不要文字，不要数字，不要UI，不要人物，不要3D，不要写实照片，不要强透视。
```

但我建议 **TileSet 不要一次生成太多**。更稳的是：

```text
只生成 4 个 16x16 石砖路 tile 变体，横向排列，边界清楚，适合拼接。
```

---

## 例子 4：生成同风格变体

当你已经有一张满意的图，可以上传图片，然后说：

```text
参考这张图片的像素风格、色彩、线条粗细和俯视角度，生成同一套游戏素材中的“满水状态版本”。

只改变水池状态：
水池从堵塞/干涸状态改为满水状态，水面略脏但有反光。

保持不变：
整体结构、画风、比例、透明背景、像素风、破损下水管位置。

不要改变：
不要增加人物，不要增加大背景，不要改变视角，不要变成写实或3D。
```

这种写法比“帮我改满水”稳定很多，因为你明确告诉它 **哪些能改，哪些不能改**。

---

## 我建议你项目里的素材生成顺序

先别急着大规模做 atlas。你现在最好按这个顺序：

1. **地图基础 tile**：泥土、草地、石砖、水泥、裂缝、水边。  
2. **核心场景物件**：水池、水泵、破管道、废弃电箱、公交站、车站入口。  
3. **背包图标**：工具、种子、零件、材料。  
4. **UI 素材**：背包格子、热键栏、物品选中框。  
5. **角色/NPC**：最后做，因为角色需要动画帧和统一比例。

---

## 最重要的一句话

你以后可以直接这样发给我：

```text
用 image2 生成一个 [素材名]，用于我们的 Godot 农场游戏。按 16x16 像素风设计，Godot 里放大到 64x64，2D top-down，明快但有崩溃未来中国东北小城废墟感，透明背景，单个素材居中。不要3D，不要写实，不要文字。
```

比如：

```text
用 image2 生成一个破损下水管物件，用于我们的 Godot 农场游戏。按 16x16 像素风设计，Godot 里放大到 64x64，2D top-down，明快但有崩溃未来中国东北小城废墟感，透明背景，单个素材居中。不要3D，不要写实，不要文字。
```

这样我就可以直接帮你生成。

---

**Sources:**

- [Introducing ChatGPT Images 2.0 | OpenAI](https://openai.com/index/introducing-chatgpt-images-2-0/)



---
Powered by [ChatGPT Exporter](https://www.chatgptexporter.com)