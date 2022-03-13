# Dev Ansible Playbook

This playbook installs and configures most of the software I use on my Mac and Linux boxes for web and software development

This is a work in progress, and is mostly a means for me to document my current setup. I'll be evolving this set of playbooks over time.

This repository has been forked from [geerlingguy's mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook)

## Installation

  1. Make sure you have git and [ansible installed](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-and-upgrading-ansible-with-pip).
  2. Clone this repository to your local drive.
  3. Run `cp vars/secrets.yml.dist vars/secrets.yml` and fill the latter with your credentials.
  4. If you are running on Macos:
    - Accept the xcode license by running `sudo xcodebuild -license`
    - Ensure you have python, homebrew and mas in your PATH, eg:
      ```
      # Use '/usr/local' for Intel Macs and '/opt/homebrew' for Apple Silicon Macs.
      # And check the versions python and mas versions are the ones you are going to install: the ones listed here are just an example.
      echo 'export PATH=/opt/homebrew/bin:${PATH}' >> ${HOME}/.zshrc
      echo 'export PATH=/opt/homebrew/sbin:${PATH}' >> ~/.zshrc
      echo 'export PATH=/opt/homebrew/Cellar/mas/1.8.6/bin:${PATH}' >> ${HOME}/.zshrc
      echo 'export PATH=${HOME}/Library/Python/3.8/bin:${PATH}' >> ${HOME}/.zshrc
      ```
    - Fix homebrew Cellar ownership by running `sudo chown -R $(whoami) /opt/homebrew/Cellar`
  5. Run `ansible-galaxy install -r requirements.yml` inside this directory to install required Ansible roles.
  6. Run `ansible-playbook main.yml -i inventory -K` inside this directory. Enter your account password when prompted.

### Notes

- Most OS come with `git` already installed, but it's best to check beforehand.
- I recommend using `pip` as installation method as it comes with Python and it allows you to install any version available without too much trouble.

### Running a specific set of tagged tasks

You can filter which part of the provisioning process to run by specifying a set of tags using `ansible-playbook`'s `--tags` flag. The tags available are `dotfiles`, `apt` and `extra-packages`.

    ansible-playbook main.yml -i inventory -K --tags "dotfiles,apt"

## Overriding Defaults

Not everyone's development environment and preferred software configuration is the same.

You can override any of the defaults configured in the `vars` folder by creating a `config.yml` file and setting the overrides in that file. For example, you can customize the installed packages and apps with something like:

    apt_installed_packages:
      - cowsay
      - git
      - go

    git_packages:
      - repo: https://github.com/unixorn/git-extra-commands.git
        dest: "{{ zsh_location }}/plugins/git-extra-commands"

    asdf_plugins:
      - name: golang
        versions: ["1.18.0"]
        global: "1.18.0"

    composer_packages:
      - name: hirak/prestissimo
      - name: drush/drush
        version: '^8.1'

    gem_packages:
      - name: bundler
        state: latest

    npm_packages:
      - name: webpack

    pip_packages:
      - name: mkdocs

Any variable can be overridden in `config.yml`; see the supporting roles' documentation for a complete list of available variables.

### Manual Operations

While I will constatly try to automate more things in this repository, some operations will still need to be done manually, and some will vary depending on the Operating System you are on. I will likely track them using github issues in the future, but for now, here we are:

#### Common

- [ ] Install browsers extensions installation (1password, jsonviewer)
- [ ] Install Visual Studio Code extensions and configs

#### Macos

- [ ] Setup the environment for ansible to be able to run(ie: install python, mas and ansible, and add them to the path)

#### Arch Linux

- [ ] Add keymaps improvements to get closer to macos experience
- [ ] Dump the configs (gnome theming, system keymaps, terminal keymaps) and add them to the playbook
- [ ] Add lockfile to avoid reruns of the non idempotent commands
- [ ] Hunt down tasks that are always marked as changed

### Other potential features

- [ ] Add automated testing
- [ ] Add support for RPM-based distros
