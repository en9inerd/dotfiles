# Save this as ~/.nvm_lazyload.zsh

export NVM_DIR="$HOME/.nvm"

typeset -ga __lazyLoadLabels=(nvm node npm npx pnpm yarn pnpx bun bunx)

__load_nvm() {
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
}

__nvm_wrapper() {
    for label in "${__lazyLoadLabels[@]}"; do unset -f $label; done
    unset -v __lazyLoadLabels

    __load_nvm
    unset -f __load_nvm __nvm_wrapper

    "$@"
}

for label in "${__lazyLoadLabels[@]}"; do
    eval "$label() { __nvm_wrapper $label \$@; }"
done

