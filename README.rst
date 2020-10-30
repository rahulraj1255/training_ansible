pyenv installer
===============

This tool installs ``pyenv`` and friends. It is inspired by `rbenv-installer <https://github.com/fesplugas/rbenv-installer>`__.

Installation / Update / Uninstallation
--------------------------------------

Install:
----
.. code:: bash

    $ curl https://pyenv.run | bash
    
``pyenv.run`` redirects to the install script in this repository and the invocation above is equivalent to::

    $ curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

Restart your shell so the path changes take effect:

.. code:: bash

    $ exec $SHELL

You can now begin using pyenv.

If you need, ``export USE_GIT_URI`` to use ``git://`` instead of ``https://`` for git clone.

Update:
----
.. code:: bash

    $ pyenv update

Uninstall:
----

``pyenv`` is installed within ``$PYENV_ROOT``
(default: ``~/.pyenv``). To uninstall, just remove it:

.. code:: bash

    $ rm -fr ~/.pyenv
    
then remove these three lines from ``.bashrc``:

.. code:: bash

    export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"

and finally, restart your shell:

.. code:: bash

          $ exec $SHELL

          


Using pyenv-installer on Travis CI
----------------------------------

Travis itself uses pyenv and therefore ``PYENV_ROOT`` is set already. To make it work anyway the installation for pyenv-installer needs to look like this::

  [...]
  - unset PYENV_ROOT
  - curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
  - export PATH="$HOME/.pyenv/bin:$PATH"
  - pyenv install 3.5.2

Development and testing
-----------------------

The `project on github <https://github.com/pyenv/pyenv-installer>`__ contains
a setup for vagrant to test the installer inside a vagrant managed virtual image.

If you don't know vagrant yet: just `install the latest
package <https://www.vagrantup.com/downloads.html>`__, open a shell in
this project directory and say

::

    $ vagrant up
    $ vagrant ssh

Now you are inside the vagrant container and your prompt should like
something like ``vagrant@vagrant-ubuntu-trusty-64:~$``

The project (this repository) is mapped into the vagrant image at
/vagrant

.. code:: bash

    $ cd /vagrant
    $ python setup.py install
    $ echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.bashrc
    $ echo 'eval "$(pyenv init -)"' >> ~/.bashrc
    $ echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
    $ source ~/.bashrc

Pyenv should be installed and responding now.


Version History
---------------

20190111
~~~~~~~~

-  Remove experimental PyPi support and replace with a dummy package.

20150113
~~~~~~~~

-  Initial release on PyPi.

20130601
~~~~~~~~

-  Initial public release.


License
-------

MIT - see `License file <LICENSE>`_.
