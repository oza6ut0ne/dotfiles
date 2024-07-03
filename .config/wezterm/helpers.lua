local module = {}

function module.append_to_table(t1, t2)
  for i=1, #t2 do
    t1[#t1+1] = t2[i]
  end
  return t1
end

function module.file_exists(name)
  local f = io.open(name, 'r')
  return f ~= nil and io.close(f)
end

return module
