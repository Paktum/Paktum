# 设计文档

## Why?

- **Task weaver** for LLM-powered agent is cool!
- **Collaboration** for massive human and agent is cool!
- **Trustworthy** without a centralized authority is cool!

But we need a kernel to make it happen.


## What?

Learn from history and existing application: 
- Chatapp: Slack, Zulip (chat with channel/thread)
- Editor/IDE: Emacs, Notion (collaborative editing)

> - Emacs: 一个lisp的解释器（interpreter）或者REPL (read-eval-print loop)，progarm==data
> - Notion: block-based编辑器，以及collaborative editing

- Emacs + Notion -> Collaborative Block-based interpreter
- Trustworthy: P2P, no centralized authority

**REPL(kernel) + Block(data structure, support collaborative editing) + P2P + UI = PAKTUM**

## How?
### Basic components

REPL: input->CRDT(include input setup), output->CRDT(include render setup)
Block: yjs
UI: simple web UI, blocksuite, monoeditor

### REPL
1. **read(easy)**: CRDT, json but still can be consider as string;
2. **eval (hard)**: like normal eval, but with complicated stack indicating users and conflict resolve progress;

```python
eval("print(1+1)") # raw input of a line

eval("""{'user1-0001': print(1+1), 'user2-0002': eval("a=3")}""", 
       {"print": print, "users":["user1", "user2"]}) # CRDT(block) input
```

3. **print (easy)**: multi-media, table, image, etc.
   
4. **loop (hard)**: supporting multi-user, multi-agent and multi-channel

### Block
just copy **yjs**, and add information about user/channel/type

Copy from CRDT
```json
{
       "user": "user1-0001",
       "channel": "channel1-0001",
       "type": "text",
       "content": "hello world"
       }
}
```
---

## UI
- 一个简单的编辑器UI，可以混合显示文本和视频，支持多用户编辑  ~~, 支持多用户聊天~~
- Bonus: 插件的加载功能
  - 加载新的CRDT类型，比如表格，图片，视频等
  - 加载新的输入组件
  - 加载新的渲染逻辑

## 预期完成的任务
### 基本任务：
1. 打开编辑器，创建编辑任务后，获取一个分享链接，类似`127.0.0.1:8080/user=fool&block=foo-l1&channel=bar`；
2. 在另一个浏览器Tab中打开，可以看到同样的编辑器，可以编辑同样的内容。如果设置了不同的用户名，则可以看到两个光标同时在编辑；
3. 加载一个input插件（在前端加载最好，如果不行，可以在后端REPL中输入`/input-plugin=table #bar@foo-l1`），可以在编辑器中输入表格，表格的内容可以被其他用户看到；
4. 加载一个output的插件，可以在表格中选择另外的一个视图，比如柱状图，可以在编辑器中看到柱状图的内容；

### Bonus任务：
插件与插件的协同编排: `/input-plugins=table,image #bar@foo-l1`，可以在编辑器中输入表格，表格的每个单元格可以是图片；

> `/input-plugins=table"`时，表格每列可选的类型只有单选/多选/文本/多行文本
> `/input-plugins=table,image`时，表格每列可选的类型增加了图片

## 使用的技术栈
推荐，但是不是必须

- REPL: Elixir
- Block: yjs
- UI: Svelte/Flutter/PyQt.
