-- https://github.com/jgm/pandoc-website/pull/50
-- Adds anchor links to headings with IDs.
function Header (h)
  if h.identifier ~= '' then
    -- an empty link to this header
    local anchor_link = pandoc.Link(
	  h.content,           -- content
      '#' .. h.identifier, -- href
      '',                  -- title
      {class = 'anchor', ['aria-hidden'] = 'true'} -- attributes
    )
    h.content = pandoc.List:new()
	h.content:insert(1, anchor_link)
    return h
  end
end
