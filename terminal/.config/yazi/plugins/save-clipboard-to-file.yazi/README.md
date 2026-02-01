# save-clipboard-to-file.yazi

[Yazi](https://github.com/sxyazi/yazi) plugin to paste clipboard content to file.

## Preview

- Relative file name:

  ![image](https://github.com/user-attachments/assets/ea49a15f-63e6-47d0-af3d-d534d892e57e)

- Overwrite confirm dialog:

  ![image](https://github.com/user-attachments/assets/a953b8f6-a7ff-4f2a-b549-3387e120ee86)

- Relavetive path:

  ![image](https://github.com/user-attachments/assets/56e981eb-cf33-4485-9521-19dc7853a264)

## Features

- Paste clipboard content to file. You can input file name or relative path.
- Ask to overwrite file if it exists

## Requirements

- [yazi >= 25.5.31](https://github.com/sxyazi/yazi)

## Installation

```sh
ya pkg add boydaihungst/save-clipboard-to-file
```

## Usage

### Key binding

Add this to your `keymap.toml`:

```toml
[mgr]
  prepend_keymap = [
    { on = [ "p", "c" ], run = "plugin save-clipboard-to-file", desc = "Paste clipboard content to file and hover after created" },
    #{ on = [ "p", "c" ], run = "plugin save-clipboard-to-file -- --no-hover", desc = "Paste clipboard content to file without hover after created" },

  ]
```

### Configuration (Optional)

This setup is the default configuration. You don't need to call `setup()` if you don't want to change the default configuration.
Any options not specified will use the default value.

Add this to your `init.lua`:

```lua
require("save-clipboard-to-file"):setup({
  -- Position of input file name or path dialog
	input_position = { "center", w = 70 },
	-- Position of overwrite confirm dialog
	overwrite_confirm_position = { "center", w = 70, h = 10 },
	-- Hide notify
	hide_notify = false,
})
```
