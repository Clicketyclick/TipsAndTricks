## Support for PlantUML (puml) diagrams

Add an action that convert `.puml` files to `.svg`. 
The action will convert any committed `.puml` file and place the corresponding `.svg` ing the same directory.

You can after the generation of the `.svg` address the diagram like:

```md
![Database_ERD](puml/database_erd.svg)
```



Create the file `.github/workflows/plantuml.yml` in your repository with the content:
```yml
name: Generate PlantUML Diagrams
on:
  push:
    paths:
      - '**.puml'

# FIX 1: Explicitly grant the action permission to push code back to the repo
permissions:
  contents: write

# FIX 2: Force Node 24 to silence the deprecation warning
env:
  FORCE_JAVASCRIPT_ACTIONS_TO_NODE24: true

jobs:
  generate:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Install PlantUML and Graphviz
        run: |
          sudo apt-get update
          sudo apt-get install -y plantuml graphviz

      - name: Generate SVG Images
        run: |
          # Finds all .puml files and generates .svg versions
          find . -name "*.puml" -exec plantuml -tsvg {} \;

      - name: Commit Generated Images
        run: |
          # Use the official GitHub Actions bot account for a cleaner commit history
          git config --local user.email "41898282+github-actions[bot]@users.noreply.github.com"
          git config --local user.name "github-actions[bot]"
          
          git add "**/*.svg"
          
          # FIX 1 (Part B): A safer commit logic that won't crash if there are no changes
          if ! git diff --staged --quiet; then
            git commit -m "Auto-generated PlantUML SVGs"
            git push
          else
            echo "No diagram changes detected. Skipping commit."
          fi
```
