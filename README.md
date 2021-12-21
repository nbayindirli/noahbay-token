# noahbay-token (NOAHBAY) 🪙

The official `$NOAHBAY` token repository.

---

For those cloning...
* Prior to compiling, create an app instance on Alchemy, Infura, etc.
* Copy the generated API key from the console
* Export the API key as an env var from your `~/.zshrc` or `~/.bashrc`
  * e.g. `export ALCHEMY_NOAHBAY_TOKEN_API_TOKEN='<your-api-token-here>'`
* Update the `fork` URL in `brownie-config.yaml` accordingly
  * e.g. `fork: https://eth-mainnet.alchemyapi.io/v2/$ALCHEMY_NOAHBAY_TOKEN_API_TOKEN`

You should now be able to run `brownie compile && brownie console --network mainnet-fork`.