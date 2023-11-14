
list = false

local filter = {
  traverse = 'topdown',

  Note = function (n)
    if list then
      n = pandoc.Span({ pandoc.Superscript(pandoc.Str ", "), n }, {class = "footnote-ref-wrapper"})
    end
    list = true
    return n,
      false -- stop traversal hereThe traversal order of filters can be selected by setting the key traverse to either 'topdown' or 'typewise'; the default is 'typewise'.
  end,

  Para, Str, Space = function (i)
    list = false
    return i
  end
}
return {filter}
