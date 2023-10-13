export def-env cd_env [$dir] {
    cd $dir
    direnv export json | from json | default {} | load-env
}

$env.config.edit_mode = emacs
$env.config.show_banner = false
$env.config.buffer_editor = nvim
$env.config.rm = { always_trash: false }
$env.config.history = {
    max_size: 1000000 # Session has to be reloaded for this to take effect
    sync_on_enter: true # Enable to share history between multiple sessions, else you have to close the session to write history to file
    file_format: "plaintext" # "sqlite" or "plaintext"
}
$env.config.keybindings = ($env.config.keybindings | append {
    name: fuzzy_history
    modifier: control
    keycode: char_r
    mode: [emacs vi_insert]
    event: [{
        send: executehostcommand
        cmd: "commandline (history | each { |it| $it.command | str trim} | reverse | uniq | str join (char nl) | peco | decode utf-8 | str trim)"
      }
      { send: enter }
    ]
})
$env.config.hooks.env_change.PWD = [{ ||
    if (which direnv | is-empty) {
        return
    }
    direnv export json | from json | default {} | load-env
}] # TODO
$env.PATH = ([
     '/bin'
     '/sbin'
     '/usr/bin'
     '/usr/sbin'
     '/usr/libexec'
    '~/local/google-cloud-sdk/bin'
    '~/.cargo/bin'
     '~/.pyenv/shims'
     '~/bin'
     '/usr/local/bin'
     '/opt/homebrew/bin'
     '/usr/local/sbin'
     '/usr/local/libexec'
     '/opt/local/bin'
   ] | path expand -n) # TODO
$env.EDITOR = nvim
$env.ASDF_NU_DIR = (brew --prefix asdf | str trim | into string | path join 'libexec')
source ~/.config/nushell/zoxide.nu # TODO: zoxide init nushell | save -f ~/.config/nushell/zoxide.nu
source ~/.config/nushell/asdf.nu   # TODO: cp $"(brew --prefix asdf)/libexec/asdf.nu" ~/.config/nushell/asdf.nu
$env.SSH_AUTH_SOCK = (echo ~/.1password/agent.sock | path expand) # TODO: ln -sfn "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock" ~/.1password/agent.sock
source ~/.config/nushell/starship.nu # TODO: starship init nu | save -f ~/.config/nushell/starship.nu
