# type: ignore[import]
from copy import deepcopy

from IPython.utils.PyColorize import linux_theme, theme_table

c = get_config()  # noqa: F821

# Do not display a banner upon starting IPython
c.TerminalIPythonApp.display_banner = False

# No new line at the start of the prompt
c.InteractiveShell.separate_in = ''

# Do not automatically set the terminal title
c.TerminalInteractiveShell.term_title = False

# Use vi for editing
c.TerminalInteractiveShell.editing_mode = 'vi'
c.TerminalInteractiveShell.emacs_bindings_in_vi_insert_mode = False
c.TerminalInteractiveShell.modal_cursor = False
c.TerminalInteractiveShell.timeoutlen = 0.25

# Change color scheme
theme_name = 'catppuccin-mocha'

c.TerminalInteractiveShell.true_color = True
try:
    from pygments.styles import get_style_by_name
    get_style_by_name(theme_name)
    theme = deepcopy(linux_theme)
    theme.base = theme_name
    theme_table[theme_name] = theme
    c.TerminalInteractiveShell.colors = theme_name
except Exception:
    pass
