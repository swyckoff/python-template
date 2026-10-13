# PROJECT SETUP

## Create a tar for a new proj

### Setup

1. Install `just` in order of preference:

   1. `brew install just`
   1. `curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to DEST`
      **Beware executing random internet scripts!**
   1. **Linux/Ubuntu** Needs0
      [Prebuilt-MPR](https://docs.makedeb.org/prebuilt-mpr/getting-started/#setting-up-the-repository)
      `sudo apt install just`

### Packaging

Create a copy of this locally with

```bash
just build
```

## Shipping a change

Work on a branch and open a PR against `main`. There is no CI: run `just check` (the justfile
convention via `check-justfile`, then pytest) before merging. Nothing is released or deployed;
`just build` makes the archive whenever a new project needs one.
