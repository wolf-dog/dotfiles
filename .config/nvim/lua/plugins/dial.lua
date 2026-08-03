local bind = vim.keymap.set

bind('n', '<C-a>', function() require('dial.map').manipulate('increment', 'normal') end)
bind('n', '<C-x>', function() require('dial.map').manipulate('decrement', 'normal') end)
bind('n', 'g<C-a>', function() require('dial.map').manipulate('increment', 'gnormal') end)
bind('n', 'g<C-x>', function() require('dial.map').manipulate('decrement', 'gnormal') end)
bind('v', '<C-a>', function() require('dial.map').manipulate('increment', 'visual') end)
bind('v', '<C-x>', function() require('dial.map').manipulate('decrement', 'visual') end)
bind('v', 'g<C-a>', function() require('dial.map').manipulate('increment', 'gvisual') end)
bind('v', 'g<C-x>', function() require('dial.map').manipulate('decrement', 'gvisual') end)
