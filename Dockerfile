FROM fedora:42

LABEL maintainer="Edward Ji <me@edwardji.dev>"

# Install documentation for packages
RUN sed -i '/^tsflags=nodocs/d' /etc/dnf/dnf.conf \
&&  dnf reinstall -y '*' \
&&  dnf install -y man man-pages

# Install packages
RUN dnf install -y \
    gawk \
    git \
    stow \
    zsh \
    tmux \
    fzf \
    neovim \
    zoxide \
    nodejs \
    ripgrep \
    fd-find \
&&  dnf clean all

# Create a user with administrative privileges and zsh as default shell
RUN useradd --groups wheel --create-home --shell /bin/zsh admin \
&&  echo "%wheel ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers
USER admin
WORKDIR /home/admin

# Install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# Sync dotfiles
COPY --chown=admin . dotfiles
RUN cd dotfiles \
&&  stow --adopt */ \
&&  git restore */

# Install neovim plugins that don't require user credentials
RUN echo "export NO_ASKPASS=1" >> ~/.config/zsh/zshrc.d/90-user.zsh
RUN nvim --headless "+Lazy! install" +qa

# Set locale for tmux to render nerd fonts properly
RUN echo "export LANG=C.UTF-8" >> ~/.config/zsh/zshrc.d/90-user.zsh

# Set entry point and default command
USER root
ENTRYPOINT ["/home/admin/dotfiles/entrypoint"]
CMD ["zsh"]
