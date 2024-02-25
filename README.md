# README.md

## Example folder structure

```
dotfiles/
├── common/
│   ├── gitconfig
│   ├── vimrc
│   └── tmux.conf
├── mac/
│   ├── Brewfile
│   ├── bashrc_mac
│   └── mac_specific_script.sh
├── unix/
│   ├── apt_sources.list
│   ├── bashrc_unix
│   └── unix_specific_script.sh
├── .bashrc
├── .zshrc
├── bootstrap.sh
├── playbook.yml
├── requirements.yml
└── README.md
```


## Testing in Docker

To build the Docker image:

    docker build -t dotfiles-test .

To run the Docker image as a login shell:

    docker run -it dotfiles-test --login
