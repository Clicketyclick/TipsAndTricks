## Markdown auto-generated image index

> How can I make a markdown page on Github that automatically displays all images in a subdirectory?

Creating a Markdown page on GitHub that automatically lists every image in a subdirectory is not 
natively supported by GitHub's Markdown renderer. 
GitHub Flavored Markdown (GFM) does not have loops, variables, or directory listing capabilities. 
You cannot simply write `![images](./subdir/*)` and expect it to expand.
However, you can achieve this result using one of three approaches, depending on whether you want 
a static list generated once or a dynamic list that updates automatically.

### Option 1: The "GitHub Actions" Approach (Fully Automatic)

This is the best method if you want the list to update automatically whenever you add or remove images. 
You use a GitHub Action workflow to generate the Markdown file containing the image links every time you push new files.

How it works:

1. You create a workflow file (.github/workflows/generate-images.yml).
2. The workflow runs on every push to your repository.
3. It scans your image directory, generates a Markdown file with the image links, and commits that file back to the repo.

Step-by-Step Implementation:

Create a file named `.github/workflows/generate-images.yml` in your repository.
Add the following content (adjust the image-dir variable to match your folder):

```yml
name: Generate Image Gallery

on:
  push:
    paths:
      - 'images/**' # Triggers when anything in the 'images' folder changes
  workflow_dispatch: # Allows manual triggering

jobs:
  generate-gallery:
    runs-on: ubuntu-latest
    permissions:
      contents: write # Permission to commit changes back to the repo

    steps:
      - name: Checkout Repository
        uses: actions/checkout@v3

      - name: Generate Markdown List
        run: |
          IMAGE_DIR="images" # Change this to your subdirectory path
          OUTPUT_FILE="gallery.md"
          
          echo "# Image Gallery" > $OUTPUT_FILE
          echo "" >> $OUTPUT_FILE
          
          # Find all image files and append them to the markdown file
          find "$IMAGE_DIR" -type f $$ -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.gif" -o -iname "*.webp" $$ | sort | while read -r file; do
            # Extract just the filename for the alt text
            filename=$(basename "$file")
            # Append markdown image syntax
            echo "![$filename]($file)" >> $OUTPUT_FILE
            echo "" >> $OUTPUT_FILE
          done

      - name: Commit and Push Changes
        uses: stefanzweifel/git-auto-commit-action@v4
        with:
          commit_message: "Auto-update image gallery"
          file_pattern: ${{ env.OUTPUT_FILE }}
```

Commit this file. The next time you push an image to the images folder 
(or manually trigger the workflow), GitHub will create/update gallery.md with the list of all images.

### Option 2: The "Static HTML" Approach (Dynamic via Browser)

If you don't want to clutter your repository with auto-generated Markdown files, you can create an HTML file that uses JavaScript to scan the directory. Note: This only works if you are viewing the page via a web server (like GitHub Pages) and the browser allows directory listing, which GitHub Pages usually disables for security.

Correction: GitHub Pages does not serve directory listings by default for security reasons. Therefore, a pure client-side JavaScript solution that scans a folder will not work on standard GitHub Pages unless you enable directory indexing (which is generally not recommended or possible without custom server configuration).

Alternative Static HTML: You can use a script that fetches the GitHub API to list files, but this requires an API token or public repo access and is complex to set up for a simple gallery.

### Option 3: The Manual/Semi-Automated Approach (Recommended for Small Projects)

If you don't want to set up GitHub Actions, the most reliable way is to manually generate the list or use a local script.

#### Using a Local Script (Python):

Run this script on your computer in the root of your project. It will print the Markdown code you can copy-paste into your README or a page.

```py
import os

directory = 'images' # Your subdirectory
output_file = 'gallery.md'

with open(output_file, 'w') as f:
    f.write("# Image Gallery\n\n")
    for filename in sorted(os.listdir(directory)):
        if filename.lower().endswith(('.png', '.jpg', '.jpeg', '.gif', '.webp')):
            filepath = os.path.join(directory, filename)
            f.write(f"![]({filepath})\n\n")

print(f"Generated {output_file}")
Summary of Limitations
```

No Native Loops: You cannot write for image in dir inside a .md file on GitHub.

Directory Listing Disabled: You cannot link to a folder URL (e.g., https://github.com/user/repo/tree/main/images) and have it display the images inline; it will just show the file list interface.

Best Practice: Use Option 1 (GitHub Actions) if you want a "set it and forget it" solution where the gallery.md file stays perfectly synced with your folder.
