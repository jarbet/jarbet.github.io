-- Lua filter that behaves like `--citeproc`, then renumbers bibliography
-- entries sequentially (1, 2, 3, ...) regardless of citeproc version.
-- Needed because newer citeproc versions reverse-number descending-sorted
-- bibliographies (e.g. 31, 30, ... 1) while older versions number them 1, 2, ... 31.
function Pandoc(doc)
  local result = pandoc.utils.citeproc(doc)
  local n = 0

  return result:walk({
    Div = function(div)
      if div.classes:includes("csl-entry") then
        n = n + 1
        local target = tostring(n)
        local replaced = false
        return div:walk({
          Str = function(s)
            if not replaced and s.text:match("^%d+%.?$") then
              replaced = true
              -- Preserve trailing "." if original had it
              if s.text:match("%.$") then
                return pandoc.Str(target .. ".")
              else
                return pandoc.Str(target)
              end
            end
          end
        })
      end
    end
  })
end