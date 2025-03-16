
![game_center.webp](docs%2Fscreen%2Fgame_center.webp)


> 注：本文会随着教程博客的发布而 **持续更新**。  
> 系列文章发布于掘金社区，可能会更新、修正，一切以 [掘金文章]() 版本为准。  

---

#### Flutter&Flame 游戏开发系列前言:

该系列是 **[张风捷特烈]** 的 Flame 游戏开发教程。Flutter 作为 **全平台** 的 **原生级**  渲染框架。官方对休闲游戏的宣传越来越多，以 Flame 游戏引擎为基础，Flutter 有游戏方向发展的前景。本系列教程旨在让更多的开发者了解 Flutter 游戏开发。

> 第一季：30 篇短文章，快速了解 Flame 基础。`[已完结] `   
> 第二季：从休闲游戏实战，进阶 Flutter&Flame 游戏开发。

两季知识是独立存在的，第二季 **不需要** 第一季作为基础。本系列教程源码地址在 [【toly1994328/toly_game】](https://github.com/toly1994328/toly_game)，系列文章列表可在[《文章总集》]() 或 [【github 项目首页】]() 查看。


---

####  第一季文章列表

这是一套 [张风捷特烈](https://juejin.cn/user/149189281194766/posts) 出品的 `Flutter&Flame` 系列教程，本系列源码于 [【toly_game】](https://github.com/toly1994328/toly_game)和 [【pinball】](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Ftoly1994328%2Fpinball) ，如果本系列对你有所帮助，希望点赞支持，本系列文章一览：

-   [【Flutter&Flame 游戏 - 壹】开启新世界的大门](https://juejin.cn/post/7101820057612713992)
-   [【Flutter&Flame 游戏 - 贰】操纵杆与角色移动](https://juejin.cn/post/7102192145380950053)
-   [【Flutter&Flame 游戏 - 叁】键盘事件与手势操作](https://juejin.cn/post/7102564285372432397)
-   [【Flutter&Flame 游戏 - 肆】精灵图片加载方式](https://juejin.cn/post/7102959875642097694)
-   [【Flutter&Flame 游戏 - 伍】Canvas 参上 | 角色的血条](https://juejin.cn/post/7103318091844730893)
-   [【Flutter&Flame 游戏 - 陆】暴击 Dash | 文字构件的使用](https://juejin.cn/post/7103690366536122399)
-   [【Flutter&Flame 游戏 - 柒】人随指动 | 动画点触与移动](https://juejin.cn/post/7104069806776647710)
-   [【Flutter&Flame 游戏 - 捌】装弹完毕 | 角色武器发射](https://juejin.cn/post/7104429099518525470)
-   [【Flutter&Flame 游戏 - 玖】探索构件 | Component 是什么](https://juejin.cn/post/7104799155721568293/)
-   [【Flutter&Flame 游戏 - 拾】探索构件 | Component 生命周期回调](https://juejin.cn/post/7105187089448501285)
-   [【Flutter&Flame 游戏 - 拾壹】探索构件 | Component 使用细节](https://juejin.cn/post/7105584277143699470/)
-   [【Flutter&Flame 游戏 - 拾贰】探索构件 | 角色管理](https://juejin.cn/post/7105928200760328223)
-   [【Flutter&Flame 游戏 - 拾叁】碰撞检测 | CollisionCallbacks](https://juejin.cn/post/7106294723077210143)
-   [【Flutter&Flame 游戏 - 拾肆】碰撞检测 | 之前代码优化](https://juejin.cn/post/7106677720272093191)
-   [【Flutter&Flame 游戏 - 拾伍】粒子系统 | ParticleSystemComponent](https://juejin.cn/post/7107404963781246990)
-   [【Flutter&Flame 游戏 - 拾陆】粒子系统 | 粒子的种类](https://juejin.cn/post/7107834982747340813)
-   [【Flutter&Flame 游戏 - 拾柒】构件特效 | 了解 Effect 体系](https://juejin.cn/post/7108170125479510030)
-   [【Flutter&Flame 游戏 - 拾捌】构件特效 | ComponentEffect 一族](https://juejin.cn/post/7108534574459650084)
-   [【Flutter&Flame 游戏 - 拾玖】构件特效 | 了解 EffectController 体系](https://juejin.cn/post/7108927950044528670)
-   [【Flutter&Flame 游戏 - 贰拾】构件特效 | 其他 EffectControler](https://juejin.cn/post/7109251245784711182)
-   [【Flutter&Flame 游戏 - 贰壹】视差组件 | ParallaxComponent](https://juejin.cn/post/7109697008138616840)
-   [【Flutter&Flame 游戏 - 贰贰】菜单、字体和浮层](https://juejin.cn/post/7109998453547073550)
-   [【Flutter&Flame 游戏 - 贰叁】 资源管理与国际化](https://juejin.cn/post/7110786997572730888)
-   [【Flutter&Flame 游戏 - 贰肆】pinball 源码分析 - 项目结构介绍](https://juejin.cn/post/7111143892950941704)
-   [【Flutter&Flame 游戏 - 贰伍】pinball 源码分析 - 资源加载与 Loading](https://juejin.cn/post/7111492756870004772)
-   [【Flutter&Flame 游戏 - 贰陆】pinball 源码分析 - 游戏主菜单界面](https://juejin.cn/post/7111862966516973575)
-   [【Flutter&Flame 游戏 - 贰柒】pinball 源码分析 - 角色选择与玩法面板](https://juejin.cn/post/7112232793916047374)
-   [【Flutter&Flame 游戏 - 贰捌】pinball 源码分析 - 游戏主场景的构成](https://juejin.cn/post/7112666683658993701)
-   [【Flutter&Flame 游戏 - 贰玖】pinball 源码分析 -  视口与相机](https://juejin.cn/post/7113733137947394055)


> 第一季完结，谢谢支持 ~

---

#### 第二季文章列表

-   [ Flutter&Flame游戏实践#01 | Trex-角色登场](https://juejin.cn/post/7341668771911876635)
-   [ Flutter&Flame游戏实践#02 | Trex-物理运动](https://juejin.cn/post/7342705422531641379)
-   [ Flutter&Flame游戏实践#03 | Trex-无限移动](https://juejin.cn/post/7344258231479681065)
-   [ Flutter&Flame游戏实践#04 | Trex-碰撞与场景](https://juejin.cn/post/7345356037405458458)
-   [ Flutter&Flame游戏实践#05 | 打砖块 - 基础功能](https://juejin.cn/post/7346113400647270439)
-   [ Flutter&Flame游戏实践#06 | 打砖块 - 世界与相机](https://juejin.cn/post/7346113400647270439)
-   [ Flutter&Flame游戏实践#07 | 打砖块 -功能菜单](https://juejin.cn/post/7348707728922476563)
-   [ Flutter&Flame游戏实践#08 | 打砖块 -关卡设计](https://juejin.cn/post/7350934543400861733)
-   [ Flutter&Flame游戏实践#09 | 打砖块 -道具设计](https://juejin.cn/post/7352751855485616162)
-   [ Flutter&Flame游戏实践#10 | 打砖块 -金币与商店](https://juejin.cn/post/7354308608043614244)
-   [ Flutter&Flame游戏实践#11 | 打砖块 -功能背包](https://juejin.cn/post/7356511140829331465)
-   [ Flutter&Flame游戏实践#12 | 打砖块 -粒子与打包应用](https://juejin.cn/post/7359919545275105321)
-   [ Flutter&Flame游戏实践#13 | 扫雷 - 界面交互](https://juejin.cn/post/7362203195051212863)
-   [ Flutter&Flame游戏实践#14 | 扫雷 - 逻辑实现](https://juejin.cn/post/7365705169009180724)
-   [ Flutter&Flame游戏实践#15 | 生命游戏 - 演绎启动](https://juejin.cn/post/7388338139633565747)
-   [ Flutter&Flame游戏实践#16 | 生命游戏 - 编辑与交互](https://juejin.cn/post/7393688446038507554)
-   [ Flutter&Flame游戏实践#17 | 生命游戏 - 二维无限标尺](https://juejin.cn/post/7396252674239053860)
-   [ Flutter&Flame游戏实践#18 | 生命游戏 - 无限空间！](https://juejin.cn/post/7399982698847076393) 
-   [ Flutter&Flame游戏实践#19 | 生命游戏 - 数据存储](https://juejin.cn/post/7401315308005965864) 
-   [ Flutter&Flame游戏实践#20 | 贪吃蛇 - 核心逻辑](https://juejin.cn/post/7402781955078176818) 
-   [ Flutter&Flame游戏实践#21 | 贪吃蛇 - 双人对战](https://juejin.cn/post/7404036819107479571) 


未完待续 ~ 
