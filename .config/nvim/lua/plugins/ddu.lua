local bind = vim.keymap.set
local silent = { silent = true, noremap = true }
local silentBuf = { noremap = true, silent = true, buffer = true }

return {
  {
    'Shougo/ddu.vim',

    dependencies = {
      'vim-denops/denops.vim',

      ------------
      -- filter --
      ------------

      -- column
      'Shougo/ddu-column-filename',
      'ryota2357/ddu-column-icon_filename',

      -- converter
      'uga-rosa/ddu-filter-converter_devicon',

      -- matcher
      'Shougo/ddu-filter-matcher_substring',
      'Shougo/ddu-filter-matcher_ignore_files',

      -- sorter
      'Shougo/ddu-filter-sorter_alpha',


      ------------
      -- kind   --
      ------------
      'Shougo/ddu-kind-file',
      'Shougo/ddu-kind-word',

      ------------
      -- source --
      ------------
      'Shougo/ddu-source-file_rec',
      {
        'kuuote/ddu-source-mr',
        dependencies = { 'lambdalisue/vim-mr' },

      },
      'Shougo/ddu-source-buffer',
      'Shougo/ddu-source-register',

      'Shougo/ddu-source-action',
      'Shougo/junkfile.vim',

      ------------
      -- ui     --
      ------------
      'Shougo/ddu-ui-ff',
    },

    init = function()
      bind('n', 'ss', [[<Cmd>call ddu#start(#{name:'file_recursive'})<CR>]], silent)
      bind('n', 'sw', [[<Cmd>call ddu#start(#{name:'file_recursive_all'})<CR>]], silent)
      bind(
        'n',
        'sd',
        function()
          local buf_dir = vim.fn.expand('%:p:h')
          vim.fn['ddu#start']({
            name = 'file_recursive',
            sourceOptions = {
              file_rec = {
                path = buf_dir,
              },
            },
          })
        end,
        silent
      )

      bind('n', 'sr', [[<Cmd>call ddu#start(#{name:'file_mru'})<CR>]], silent)
      bind('n', 'sf', [[<Cmd>call ddu#start(#{name:'file_mrd'})<CR>]], silent)
      bind('n', 'sg', [[<Cmd>call ddu#start(#{name:'file_mrg'})<CR>]], silent)

      bind('n', 'sb', [[<Cmd>call ddu#start(#{name:'file_buffer'})<CR>]], silent)

      bind('n', 'sj', [[<Cmd>call ddu#start(#{name:'junkfile'})<CR>]], silent)
      bind('n', 'sk', [[<Cmd>call junkfile#open('%Y-%m-%d-%H%M%S.'->strftime())<CR>]])

      bind('n', 'sc', [[<Cmd>call ddu#start(#{name:'register'})<CR>]], silent)
    end,

    config = function()
      vim.fn['ddu#custom#patch_global']({
        filterParams = {
          matcher_ignore_files = {
            ignoreGlobs = { '.git/', 'vendor/', 'node_modules/', '.DS_Store' },
          },
        },

        kindOptions = {
          file = {
            defaultAction = 'open',
          },

          word = {
            defaultAction = 'append',
          },

          action = {
            defaultAction = 'do',
          },
        },

        sourceOptions = {
          _ = {
            ignoreCase = true,
            smartCase = true,
          },

          file_rec = {
            converters = {
              'converter_devicon',
            },

            matchers = {
              'matcher_substring',
              'matcher_ignore_files',
            },

            sorters = {
              'sorter_alpha',
            },
          },

          mr = {
            converters = {
              'converter_devicon',
            },

            matchers = {
              'matcher_substring',
            },
          },

          buffer = {
            converters = {
              'converter_devicon',
            },

            matchers = {
              'matcher_substring',
            },
          },

          junkfile = {
            converters = {
              'converter_devicon',
            },
          },

          register = {
            matchers = {
              'matcher_substring',
            },
          },

          action = {
          },
        },

        sourceParams = {
          file_rec = {
            chunkSize = 5000,
          },
        },

        ui = 'ff',
      })

      vim.fn['ddu#custom#patch_local']('file_recursive', {
        sources = {
          {
            name = { 'file_rec' },

            params = {
              ignoredDirectories = { '.git', 'vendor', 'node_modules' },
            },
          },
        },
      })

      vim.fn['ddu#custom#patch_local']('file_recursive_all', {
        sources = {
          {
            name = { 'file_rec' },
          },
        },
      })


      vim.fn['ddu#custom#patch_local']('file_mru', {

        sources = {
          {
            name = { 'mr' },
            params = {
              kind = 'mru',
            },
          },
        },
      })

      vim.fn['ddu#custom#patch_local']('file_mrd', {
        sources = {
          {
            name = { 'mr' },
            params = {
              kind = 'mrd',
            },
          },
        },
      })

      vim.fn['ddu#custom#patch_local']('file_mrg', {
        sources = {
          {
            name = { 'mr' },
            params = {
              kind = 'mrr',
            },
          },
        },
      })

      vim.fn['ddu#custom#patch_local']('file_buffer', {
        sources = {
          {
            name = { 'buffer' },
          },
        },
      })

      vim.fn['ddu#custom#patch_local']('junkfile', {
        sources = {
          {
            name = { 'junkfile' },
          },
        },
      })

      vim.fn['ddu#custom#patch_local']('register', {
        sources = {
          {
            name = { 'register' },
          },
        },
      })

      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'ddu-ff',

        callback = function()
          bind('n', '<C-j>', [[<Cmd>q<CR>]], silentBuf)

          bind('n', 'i', [[<Cmd>call ddu#ui#do_action('openFilterWindow')<CR>]], silentBuf)
          bind('n', 'o', [[<Cmd>call ddu#ui#do_action('chooseAction')<CR>]], silentBuf)

          bind('n', '<CR>', function()
            if vim.fn['ddu#ui#get_item']().isTree == true then
              vim.cmd('call ddu#ui#do_action("expandItem", { "mode": "toggle" })')
            else
              vim.cmd('call ddu#ui#do_action("itemAction")')
            end
          end, silentBuf)
        end,
      })
    end,
  },
}
