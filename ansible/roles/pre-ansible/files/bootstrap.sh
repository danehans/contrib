#/bin/bash

set -e

BOOTSTRAP_SCRIPT_DIR=${BOOTSTRAP_SCRIPT_DIR:-/opt/bin}
PYPY_VERSION=2.4.0

if [[ -e ${BOOTSTRAP_SCRIPT_DIR}/.bootstrapped ]]; then
  exit 0
fi

mkdir -p ${BOOTSTRAP_SCRIPT_DIR}

if [[ -e /tmp/pypy-$PYPY_VERSION-linux64.tar.bz2 ]]; then
  tar -xjf /tmp/pypy-$PYPY_VERSION-linux64.tar.bz2
  rm -rf /tmp/pypy-$PYPY_VERSION-linux64.tar.bz2
else
  wget -O /tmp/pypy-$PYPY_VERSION-linux64.tar.bz2 https://bitbucket.org/pypy/pypy/downloads/pypy-$PYPY_VERSION-linux64.tar.bz2
  tar -xjf /tmp/pypy-$PYPY_VERSION-linux64.tar.bz2 -C /tmp
fi

mv -n /tmp/pypy-$PYPY_VERSION-linux64 ${BOOTSTRAP_SCRIPT_DIR}/pypy

## library fixup
mkdir -p ${BOOTSTRAP_SCRIPT_DIR}/pypy/lib
ln -snf /lib64/libncurses.so.5.9 ${BOOTSTRAP_SCRIPT_DIR}/pypy/lib/libtinfo.so.5

cat > ${BOOTSTRAP_SCRIPT_DIR}/python <<EOF
#!/bin/bash
LD_LIBRARY_PATH=${BOOTSTRAP_SCRIPT_DIR}/pypy/lib:$LD_LIBRARY_PATH exec ${BOOTSTRAP_SCRIPT_DIR}/pypy/bin/pypy "\$@"
EOF

chmod +x ${BOOTSTRAP_SCRIPT_DIR}/python
${BOOTSTRAP_SCRIPT_DIR}/python --version

touch ${BOOTSTRAP_SCRIPT_DIR}/.bootstrapped
