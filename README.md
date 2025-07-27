# 🛠 Neovim Configuration Overview

This Neovim config provides a minimal, powerful setup using Telescope, Treesitter, LSP, and NvimTree, with Go, Lua, C, and C++ support.

---

##  Core Settings (`vim.opt`)

-  Indentation is 4 spaces.
-  A tab character is displayed as 4 spaces.
-  Converts tabs to spaces.
-  Uses system clipboard for copy/paste.
-  Shows line numbers.
-  Highlights the current line.
-  Always show the sign column.
-  Use rounded borders in floating windows.

---

## 🔍 Telescope: Fuzzy Finder

- `<leader>ff` — Find files.
- `<leader>fg` — Live grep (search text in files).
- `<leader>fb` — List open buffers.
- `<leader>fm` — Open man pages.
- `<leader>n` — Create a new file in a selected folder using a recursive directory picker.

---

## 🧠 LSP (Language Server Protocol)

LSP support for:
- **Go**
- **Lua**
- **C / C++**

### 🛠 LSP Keybindings

- `H` — Show hover info (docs/signatures).
- `gd` — Go to definition.
- `gD` — Go to declaration.
- `gi` — Go to implementation.
- `gr` — List references.
- `grn` — Rename symbol.
- `p` — Paste and auto-format the buffer.
- **On save** — Auto-format buffer via `BufWritePre` event.

---

## 🌲 NvimTree: File Explorer

- `<leader>l` — Toggle NvimTree on the right side of the buffer.
- Expands all folders automatically when opened.

---

## 🪵 Diagnostics

- `<leader>E` — Show diagnostic message in a floating window.
- `<leader>e` — Show diagnostics in the location list.

---

## ⚙️ Utility Keybindings

- `<leader><leader>` — Switch to the previous buffer.
- `<leader>h` — Show all keybindings (using `which-key`).
- `<leader>d` — Delete the current file and open a blank buffer.
- `<leader>r` — Rename the current file (asks for new filename).

---

## 💾 Autosave

Automatically writes (saves) the buffer when:
- Leaving insert mode
- Switching buffers
- Losing focus 

---
