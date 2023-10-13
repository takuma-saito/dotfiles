export def ssh_wpcli [$name] {
    let wp_env = $"_($name)"
    let item = (cat wp-cli.yml | sd '^@' '_' | from yaml | get $wp_env | get ssh | parse '{host}:{port}')
    ^ssh $item.host -p $item.port
}

module ssh_hostname {
    def ssh_hostnames [] {
        ls ~/.ssh/**/* |
            where type == file and name =~ '(\.conf|config)$' |
            each {|$f|
                cat $f.name |
                    lines |
                    find 'Host ' |
                    parse 'Host {hostname}' |
                    $in.hostname | each { split row ' ' } | flatten
            } |
        flatten |
        uniq |
        sort
    }
    export extern "ssh" [
        subcommand?: string@ssh_hostnames
    ]
}

use ssh_hostname ssh
