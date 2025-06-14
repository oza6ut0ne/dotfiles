local wezterm = require 'wezterm'

local module = {}

function docker_list()
  local docker_list = {}
  local success, stdout, stderr = wezterm.run_child_process {
    'docker',
    'container',
    'ls',
    '--format',
    '{{.ID}}:{{.Names}} - {{.Image}}',
  }
  for _, line in ipairs(wezterm.split_by_newlines(stdout)) do
    local id, name = line:match '(.-):(.+)'
    if id and name then
      docker_list[id] = name
    end
  end
  return docker_list
end

function make_docker_label_func(id, name)
  return function(domain_name)
    local success, stdout, stderr = wezterm.run_child_process {
      'docker',
      'inspect',
      '--format',
      '{{.State.Running}}',
      id,
    }
    local running = stdout == 'true\n'
    local color = running and 'Green' or 'Red'
    return wezterm.format {
      { Foreground = { AnsiColor = color } },
      { Text = name },
    }
  end
end

function make_docker_fixup_func(id)
  return function(cmd)
    cmd.args = cmd.args or { '/bin/sh' }
    local wrapped = {
      'docker',
      'exec',
      '-it',
      id,
    }
    for _, arg in ipairs(cmd.args) do
      table.insert(wrapped, arg)
    end

    cmd.args = wrapped
    return cmd
  end
end

function compute_exec_domains()
  local exec_domains = {}
  for id, name in pairs(docker_list()) do
    table.insert(
      exec_domains,
      wezterm.exec_domain(
        'docker:' .. id,
        make_docker_fixup_func(id),
        make_docker_label_func(id, name)
      )
    )
  end
  return exec_domains
end

function module.apply(config)
  config.unix_domains = {
    {
      name = 'localdomain',
    },
  }

  local exec_domains_ok, exec_domains = pcall(compute_exec_domains)
  if exec_domains_ok then
    config.exec_domains = exec_domains
  end

  config.mux_enable_ssh_agent = false;
end

return module
