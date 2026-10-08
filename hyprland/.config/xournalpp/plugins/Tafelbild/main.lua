-- Appends the screenshot taken by `class-tools snap` as a new page, sized to the
-- screenshot, so it can be annotated. class-tools triggers it with the shortcut.
-- The page is always added at the end of the document, which can also be a PDF.

local WIDTH = 1120 -- pt, the page width of the boards made by class-tools

local function snapPath()
  return (os.getenv("XDG_RUNTIME_DIR") or "/tmp") .. "/class-snap.png"
end

-- Width and height from the IHDR chunk of a PNG file.
local function pngSize(path)
  local file = io.open(path, "rb")
  if not file then
    return nil
  end
  local header = file:read(24)
  file:close()
  if not header or #header < 24 or header:sub(2, 4) ~= "PNG" then
    return nil
  end
  local function u32(offset)
    local a, b, c, d = header:byte(offset, offset + 3)
    return ((a * 256 + b) * 256 + c) * 256 + d
  end
  return u32(17), u32(21)
end

function initUi()
  app.registerUi({
    menu = "Bildschirmfoto als neue Seite",
    callback = "insertSnap",
    accelerator = "<Control><Alt><Shift>b",
  })
end

function insertSnap()
  local path = snapPath()
  local width, height = pngSize(path)
  if not width then
    return
  end

  app.setCurrentPage(#app.getDocumentStructure().pages)
  app.activateAction("new-page-after")

  -- Whole points: addImages only takes integer sizes.
  local pageHeight = math.floor(WIDTH * height / width + 0.5)
  app.setPageSize(WIDTH, pageHeight)
  app.changeCurrentPageBackground("plain")
  app.addImages({
    images = { { path = path, x = 0, y = 0, maxWidth = WIDTH, maxHeight = pageHeight } },
    allowUndoRedoAction = "grouped",
  })
  app.clearSelection()
  app.scrollToPage(app.getDocumentStructure().currentPage)
  -- Used up: pressing the shortcut again by accident inserts nothing.
  os.remove(path)
end
