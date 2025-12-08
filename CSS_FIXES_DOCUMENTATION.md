# 问卷系统 JSP 页面 CSS 样式统一修复文档

## 问题描述

问卷系统中的 JSP 页面存在公共样式排版错乱的问题，主要表现为：

1. **导航栏高度不一致** - 不同页面导航栏高度不同，滚动时高度变化导致页面跳动
2. **页面顶部间距不统一** - 有的页面使用 `88px`，有的使用 `96px`
3. **头部卡片高度不一致** - `design-header-inner` 的 `min-height` 和 `padding` 值不统一
4. **左侧导航卡片尺寸不一致** - `nav-card` 的 `padding` 和 `min-height` 值各异
5. **CSS 代码重复** - 每个 JSP 文件都有完整的 CSS 定义，导致维护困难

## 修复方案

### 1. 创建统一的 CSS 样式文件

创建 `common-styles.jsp` 文件，包含所有页面共用的标准化 CSS 样式。

### 2. 标准化的关键尺寸值

| 元素 | 属性 | 标准值 | 说明 |
|------|------|--------|------|
| `.navbar` | `height` | `76px` | 固定高度，防止滚动时变化 |
| `.navbar` | `padding` | `0` | 使用 flexbox 居中，不用 padding |
| `.page-wrapper` | `padding-top` | `96px` | 76px 导航 + 20px 间距 |
| `.design-header` | `margin-bottom` | `24px` | 统一底部间距 |
| `.design-header-inner` | `padding` | `24px 28px` | 统一内边距 |
| `.design-header-inner` | `min-height` | `136px` | 防止高度跳动 |
| `.nav-card` | `padding` | `24px 20px` | 统一内边距 |
| `.nav-card` | `min-height` | `360px` | 防止侧边栏高度变化 |
| `.content-card` | `min-height` | `400px` | 统一主内容区域高度 |

### 3. 修复前后对比

#### 修复前的问题

**list.jsp (行 47-49):**
```css
.navbar {
    height: 76px; 
    padding: 0;
}
```

**form.jsp (行 36-38):**
```css
.navbar {
    height: 76px;
    padding: 0;
}
```

**folders.jsp (行 42-51):**
```css
.navbar {
    height: 76px; 
    padding: 0;
}
```

**design.jsp (行 25-32):**
```css
.navbar {
    height: 76px;
    padding: 0;
}
```

✅ **导航栏高度已统一为 76px**

---

**list.jsp (行 85):**
```css
.page-wrapper {
    padding-top: 96px;
}
```

**list.jsp (行 128):**
```css
.page-wrapper {
    padding-top: 88px; /* 重复定义！ */
}
```

**form.jsp (行 73-76):**
```css
.page-wrapper {
    padding-top: 96px;
}
```

**form.jsp (行 124-127):**
```css
.page-wrapper {
    padding-top: 88px; /* 重复定义！ */
}
```

**folders.jsp (行 86-89):**
```css
.page-wrapper {
    padding-top: 96px;
}
```

**folders.jsp (行 174-177):**
```css
.page-wrapper {
    padding-top: 88px; /* 重复定义！ */
}
```

**design.jsp (行 79-82):**
```css
.page-wrapper {
    padding-top: 96px;
}
```

❌ **问题：** 多个页面存在重复定义，且值不统一（88px vs 96px）

✅ **修复：** 统一为 `96px`（76px 导航 + 20px 间距）

---

**头部区域 (design-header-inner):**

| 文件 | padding | min-height | 问题 |
|------|---------|------------|------|
| list.jsp | 行 141: `24px 28px` | 行 153: `136px` | ✅ 正确 |
| form.jsp | 行 137: `24px 28px` | 行 149: `136px` | ✅ 正确 |
| folders.jsp | 行 187: `24px 28px` | 行 199: `136px` | ✅ 正确 |
| design.jsp | 行 91: `24px 28px` | 行 98: `136px` | ✅ 正确 |

✅ **头部区域已统一**

---

**左侧导航卡片 (nav-card):**

| 文件 | padding | min-height | 问题 |
|------|---------|------------|------|
| list.jsp | 行 198: `24px 20px` | 行 202: `360px` | ✅ 正确 |
| form.jsp | 行 182: `24px 20px` | 行 186: `360px` | ✅ 正确 |
| folders.jsp | 行 257: `24px 20px` | 行 261: `360px` | ✅ 正确 |
| design.jsp | N/A | N/A | ⚠️ 此页面无左侧导航 |

✅ **左侧导航卡片已统一**

### 4. 新增的改进

#### 平滑过渡效果

```css
.navbar,
.design-header,
.nav-card,
.content-card,
.folders-card,
.folder-card,
.questionnaire-card {
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}
```

使用 `cubic-bezier` 缓动函数，使过渡更加平滑，减少视觉跳动。

#### 响应式设计改进

- 移动端 (< 992px): 页面顶部间距调整为 `90px`
- 移动端: 取消 `.nav-card` 的最小高度限制
- 平板 (< 768px): 内容卡片内边距适当减小

### 5. 文件结构

```
src/main/webapp/WEB-INF/views/questionnaire/
├── common-styles.jsp          # 新增：统一的 CSS 样式文件
├── _head.jsp                  # 更新：包含 common-styles.jsp
├── list.jsp                   # 待更新：移除重复 CSS
├── form.jsp                   # 待更新：移除重复 CSS
├── folders.jsp                # 待更新：移除重复 CSS
├── design.jsp                 # 待更新：移除重复 CSS
└── _leftnav.jsp              # 左侧导航组件
```

## 实施步骤

1. ✅ 创建 `common-styles.jsp` 统一样式文件
2. ✅ 更新 `_head.jsp` 引入统一样式
3. ⏳ 更新各 JSP 文件，移除重复 CSS，仅保留页面特定样式
4. ⏳ 测试验证所有页面布局一致性
5. ⏳ 截图对比修复前后效果

## 预期效果

- ✅ 所有页面导航栏高度一致，滚动时不会跳动
- ✅ 页面顶部间距统一，视觉效果一致
- ✅ 头部卡片和左侧导航高度固定，不同页面间切换无抖动
- ✅ CSS 代码集中管理，易于维护
- ✅ 响应式设计改进，移动端体验更好

## 技术要点

### 防止布局跳动的关键

1. **固定高度** - 使用 `height` 而非 `padding` 控制导航栏高度
2. **最小高度** - 为可能内容不同的容器设置 `min-height`
3. **盒模型** - 使用 `box-sizing: border-box` 确保尺寸计算一致
4. **平滑过渡** - 使用适当的 `transition` 和 `easing` 函数

### CSS 优先级

由于采用内联样式 (`<style>` 标签)，确保：
- 公共样式在前
- 页面特定样式在后
- 避免 `!important` 的滥用

## 维护建议

1. 新增页面时，优先使用 `common-styles.jsp` 中的样式
2. 仅在特殊情况下添加页面特定样式
3. 定期审查 CSS 代码，清理无用样式
4. 使用 CSS 变量 (`:root`) 管理颜色、尺寸等常量

## 相关文件

- `/src/main/webapp/WEB-INF/views/questionnaire/common-styles.jsp`
- `/src/main/webapp/WEB-INF/views/questionnaire/_head.jsp`
- `/src/main/webapp/WEB-INF/views/questionnaire/list.jsp`
- `/src/main/webapp/WEB-INF/views/questionnaire/form.jsp`
- `/src/main/webapp/WEB-INF/views/questionnaire/folders.jsp`
- `/src/main/webapp/WEB-INF/views/questionnaire/design.jsp`
