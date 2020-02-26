#############################
Dubs Vim |em_dash| ToggleWrap
#############################

.. |em_dash| unicode:: 0x2014 .. em dash

About This Plugin
=================

ToggleWrap is a Vim plugin to make working
with and without text wrapping more pleasant.

This plugin was inspired by
`code by Harold Giménez
<http://awesomeful.net/posts/57-small-collection-of-useful-vim-tricks>`__.
See also his
`vimrc on github
<http://github.com/hgimenez/vimfiles/blob/c07ac584cbc477a0619c435df26a590a88c3e5a2/vimrc#L72-122>`__.

Install Plugin
==============

Installation is easy using the packages feature (see ``:help packages``).

To install the package so that it will automatically load on Vim startup,
use a ``start`` directory, e.g.,

.. code-block:: bash

    mkdir -p ~/.vim/pack/landonb/start
    cd ~/.vim/pack/landonb/start

If you want to test the package first, make it optional instead
(see ``:help pack-add``):

.. code-block:: bash

    mkdir -p ~/.vim/pack/landonb/opt
    cd ~/.vim/pack/landonb/opt

Clone the project to the desired path:

.. code-block:: bash

    git clone https://github.com/landonb/dubs_toggle_textwrap.git

If you installed to the optional path, tell Vim to load the package:

.. code-block:: vim

   :packadd! dubs_toggle_textwrap

Just once, tell Vim to build the online help:

.. code-block:: vim

   :Helptags

Then whenever you want to reference the help from Vim, run:

.. code-block:: vim

   :help dubs-toggle-textwrap

Usage
=====

Type ``\w`` to toggle line wrapping on and off,
rather than using ``set wrap`` and ``set nowrap``.

In addition to being the same command for
either operation, the ``\w`` toggler configures
cursor navigation to traverse visual boundaries
when wrapping, otherwise, when not wrapping,
navigation is set to traverse only logical
boundaries.

Why ":set wrap" Isn't Enough
============================

The ``wrap`` option does exactly what it says --
it visually wraps text that otherwise would
extend past the right edge of a window.

However, setting ``wrap`` doesn't change the
behavior of the navigation keys, so you might
notice something -- using ``<Up>``, ``<Down>``,
``<Home>``, and ``<End>`` keys applies to the
logical text line, not to the visual line.

E.g., suppose a long line is wrapped and now
spans four visual lines in a window; if you
put the cursor at the start of the line of
text and then press ``<Down>``, rather than moving
the cursor down by one visual line, the
cursor instead jumps four visuals lines down
to the next actual line in the document (i.e.,
past the next newline it finds).

Another e.g., if you press ``<Home>``, the cursor
jumps to the logical start of the line, which
may be on a visual line above the current one.

Fortunately, Vim supports visual line
navigation as well as logical line navigation.
So now, when in wrap mode, we remap ``<Up>`` and
``<Down>`` to move the cursor by one visual line
rather than by one logical line, and ``<Home>``
and ``<End>`` move the cursor to the start and end
of the current visual line, respectively.

Key Mappings
============

=================================  ==================================  ==============================================================================
 Key Mapping                        Description                         Notes
=================================  ==================================  ==============================================================================
 ``\w``                             Toggle Word Wrapping                Enables and disables visual word wrapping,
                                                                        and fixes associated settings.
=================================  ==================================  ==============================================================================

