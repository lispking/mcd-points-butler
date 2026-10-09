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

## 内置 MCP（可选）

包内 `.mcp.json.optional` 声明了麦当劳官方 MCP（`https://mcp.mcd.cn`，Bearer Token 鉴权），并带有 Token 凭证表单（`x-workbuddy.auth.type: "token"`），用户连接时填入 Token 即可，凭证仅存本机。

启用方式（二选一）：

1. **随包发布启用**：将 `.mcp.json.optional` 重命名为 `.mcp.json` 后打包上传。用户召唤专家时会弹出连接引导卡片。
2. **手动配置**（推荐先验证）：不动包结构，按仓库根 README「方式一」在 WorkBuddy 连接器中手动配置 `mcd-mcp`，效果相同。

> 为什么默认不启用：早期实测 WorkBuddy 会话中声明 MCP 依赖偶发「工具未挂载 / 专家卡在等待连接」，故默认以手动配置为兜底，内置声明作为增强项。若平台行为已修复可直接采用方式 1。

## 打包

```bash
cd scripts && ./pack.sh
```

产物：`expert/mcd-points-butler.zip`（以同名文件夹为根，不含 `.DS_Store`）。

上传：WorkBuddy 开放平台 → 专家 → 提交 zip。
