local ls = require 'luasnip'
local s = ls.snippet
local i = ls.insert_node
local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep

return {
  s(
    'ifassign',
    fmt(
      [[
if {} := {}; {} != {} {{
  {}
}}
]],
      {
        i(1, 'var_name'),
        i(2, 'var_value'),
        rep(1),
        i(3, 'expected_value'),
        i(4, 'action'),
      }
    )
  ),
}
