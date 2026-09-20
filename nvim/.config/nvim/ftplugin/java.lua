local root_markers = {
  'package.bluej',
  'settings.gradle',
  'settings.gradle.kts',
  'pom.xml',
  'build.gradle',
  'mvnw',
  'gradlew',
  'build.gradle',
  'build.gradle.kts',
  '.git',
}

local function find_root()
  return vim.fs.dirname(vim.fs.find(root_markers, { upward = true })[1])
end

-- Determine if 'package.bluej' exists in the root directory
local root_dir = find_root()
local has_bluej_package = vim.fs.find('package.bluej', { path = root_dir, upward = false })[1] ~= nil

-- if create different project configurations for different root_dirs
local project = {
  sourcePaths = has_bluej_package and { '.' } or nil,
  referencedLibraries = {
    '+libs/**/*.jar',
  },
}

-- root_dir: scratch-for-java
if root_dir == vim.fn.expand '~/Sources/openpatch/scratch-for-java' then
  project.sourcePaths = { 'src', 'examples/java', 'examples/reference' }
  project.referencedLibraries = {
    'libs/**/*.jar',
  }
end

local config = {
  cmd = { '/usr/bin/jdtls' },
  root_dir = root_dir,
  settings = {
    java = {
      configuration = {
        runtimes = {
          {
            name = 'JavaSE-25',
            path = '/home/mike/.sdkman/candidates/java/25-tem',
            default = true,
          },
          {
            name = 'JavaSE-21',
            path = '/home/mike/.sdkman/candidates/java/21-tem',
          },
          {
            name = 'JavaSE-17',
            path = '/home/mike/.sdkman/candidates/java/17.0.13-tem',
          },
        },
      },
      project = project,
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
    },
  },
}
require('jdtls').start_or_attach(config)

vim.keymap.set('n', '<leader>ao', function()
  local file = vim.api.nvim_buf_get_name(0)
  if file == '' then
    vim.notify('Save the Java file before running it', vim.log.levels.WARN)
    return
  end

  vim.cmd.update()
  local package
  for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
    package = line:match('^%s*package%s+([%w_.]+)%s*;')
    if package then
      break
    end
  end

  local class = vim.fn.fnamemodify(file, ':t:r')
  local main_class = package and (package .. '.' .. class) or class

  vim.cmd('botright 12new')
  vim.fn.jobstart({ '/home/mike/.local/dbin/jrun', main_class }, {
    term = true,
    cwd = root_dir,
  })
  vim.cmd.startinsert()
end, { buffer = true, desc = 'Run Java file' })
