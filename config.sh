# Define custom utilities
# Test for OSX with [ -n "$IS_OSX" ]

function pre_build {
    # Any stuff that you need to do before you start building the wheels
    # Runs in the root directory of this repository.
    :
}

function run_tests {
    # The function is called from an empty temporary directory.
    # Get absolute path to the pre-compiled wheel
    wheelhouse=$(abspath ../wheelhouse)
    wheel=`ls ${wheelhouse}/compreffor*.whl | head -n 1`
    if [ ! -e "${wheel}" ]; then
        echo "error: can't find wheel in ${wheelhouse} folder" 1>&2
        exit 1
    fi

    # select tox environment based on the current python version
    # E.g.: '2.7' -> 'py27-cov'
    TOXENV="py${MB_PYTHON_VERSION//\./}"

    # Runs tests on installed wheel
    tox --installpkg $wheel -e $TOXENV
}
