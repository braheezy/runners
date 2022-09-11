
https://dev.to/oysterd3/how-to-release-built-artifacts-from-one-to-another-repo-on-github-3oo5

release:
  steps:
    - name: Release
      uses: softprops/action-gh-release@v1
      with:
        repository: ${{ secrets.owner }}/${{ secrets.repo }}
        token: ${{ secrets.CUSTOM_TOKEN }}


prettybox-catppuccin
- source code for custom boxes
- docs
- release notes
- tags
- CI: linting Ansible and Packer

prettybox-catppuccin-builder (private)
- source code for workflows that build and upload to Vagrant cloud
- CD:
  - When tagged, run new build/deploy of prettybox-catppuccin
  - Keep tags in line with prettybox-catppuccin

runners
- source code for self-hosted build machines
