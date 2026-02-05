FROM fedora:42

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
    stow \
    zsh \
    ncurses-term \
&&  dnf clean all

# Create a user with administrative privileges and zsh as default shell
RUN useradd --groups wheel --create-home --shell /bin/zsh admin \
&&  echo "%wheel ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers
USER admin
WORKDIR /home/admin

# Sync dotfiles
COPY --chown=admin . dotfiles
RUN cd dotfiles \
&&  stow --adopt */ \
&&  git restore */

# Install mise
RUN curl https://mise.run | sh 
ENV PATH="/home/admin/.local/bin:${PATH}"
RUN mise install
RUN mkdir ~/.zfunc && mise completions zsh > ~/.zfunc/_mise

# Install neovim plugins that don't require user credentials
RUN echo "export NO_ASKPASS=1" >> ~/.config/zsh/zshrc.d/90-user.zsh
RUN mise exec -- nvim --headless "+Lazy! install" +qa

# Set locale for tmux to render nerd fonts properly
RUN echo "export LANG=C.UTF-8" >> ~/.config/zsh/zshrc.d/90-user.zsh

# Set entry point and default command
USER root
ENTRYPOINT ["/home/admin/dotfiles/entrypoint"]
CMD ["zsh"]
