FROM fedora:44

LABEL maintainer="Edward Ji <me@edwardji.dev>"

# Install documentation for packages
RUN sed -i '/^tsflags=nodocs/d' /etc/dnf/dnf.conf \
&&  dnf reinstall -y '*' \
&&  dnf install -y man man-pages

# Install packages
RUN dnf install -y \
    gawk \
    gcc \
    git \
    zsh \
    ncurses-term \
&&  dnf clean all

# Create a user with administrative privileges and zsh as default shell
RUN useradd --groups wheel --create-home --shell /bin/zsh admin \
&&  echo "%wheel ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers
USER admin
WORKDIR /home/admin

# Install mise
RUN curl https://mise.run | sh
ENV PATH="/home/admin/.local/bin:${PATH}"
ENV MISE_TRUSTED_CONFIG_PATHS=/home/admin/dotfiles

# Sync dotfiles
COPY --chown=admin . dotfiles
RUN cd dotfiles && mise dotfiles apply --force --yes

# Install tools from the deployed global mise config
RUN mise install
RUN mkdir ~/.zfunc && mise completions zsh > ~/.zfunc/_mise

# Install neovim plugins
RUN mise exec -- nvim --headless "+Lazy! install" +qa

# Set locale for tmux to render nerd fonts properly
RUN echo "export LANG=C.UTF-8" >> ~/.config/zsh/zshrc.d/90-user.zsh

CMD ["zsh"]
