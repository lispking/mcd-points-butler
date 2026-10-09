# 麦管家 mcd-points-butler（专家包）

WorkBuddy 专家包：麦当劳积分与优惠券资产管理。目录结构与打包说明如下。

## 结构

```
mcd-points-butler/
├── .codebuddy-plugin/plugin.json   # 核心配置（categoryId: 07-SalesCommerce）
├── agents/mcd-points-butler.md     # 麦管家系统提示词（决策内核）
├── skills/mcd-points-assets/       # 捆绑技能：5 大资产剧本编排
├── avatars/expert.png              # 头像 512×512
├── .mcp.json.optional              # 内置 MCP 声明（可选启用，见下）
└── README.md
```

## 内置 MCP（随包默认启用）

包内 `.mcp.json.optional` 声明了麦当劳官方 MCP（`https://mcp.mcd.cn`，Bearer Token 鉴权），并带有 Token 凭证表单（`x-workbuddy.auth.type: "token"`）。`scripts/pack.sh` 打包时会把它复制为 `.mcp.json` 一并发布，用户安装后召唤专家即弹出连接引导卡片，填入 Token 即可，凭证仅存本机。

Token 注入方式为 `Authorization: Bearer ${MCD_MCP_TOKEN}`，依赖平台按凭证表单注入同名变量。若注入失败（表现为 401、工具未挂载或卡在等待连接），按仓库根 README「方式二」在 WorkBuddy 连接器中手动配置 `mcd-mcp` 作为兜底，效果相同；如需发布纯手动配置版，让包内不生成 `.mcp.json` 即可（`.mcp.json.optional` 不要删，它是备用声明）。

## 打包

```bash
cd scripts && ./pack.sh
```

产物：`expert/mcd-points-butler.zip`（以同名文件夹为根，不含 `.DS_Store`）。

上传：WorkBuddy 开放平台 → 专家 → 提交 zip。
