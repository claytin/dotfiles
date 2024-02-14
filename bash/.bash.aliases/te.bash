export EDITOR=$(which nvim vim vi nano | head -1)

te() {
    # Calls the default (t)ext (e)ditor
    $EDITOR $@
}
