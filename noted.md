
https://dev.to/oysterd3/how-to-release-built-artifacts-from-one-to-another-repo-on-github-3oo5

release:
  steps:
    - name: Release
      uses: softprops/action-gh-release@v1
      with:
        repository: ${{ secrets.owner }}/${{ secrets.repo }}
        token: ${{ secrets.CUSTOM_TOKEN }}
