## Template `.gitnore` for PHP projects

```gitnore
# Composer dependencies
/vendor/

# Environment files
.env
.env.*
!.env.example

# Cache and temp files
cache/
tmp/
tmp/*
!tmp/.gitkeep

# Logs
*.log
logs/
var/log/

# IDE and editor files
.idea/
.vscode/
*.swp
*.swo
*~
.project
.classpath
.settings/

# OS generated files
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
Thumbs.db
ehthumbs.db

# Build and test output
coverage/
phpunit.xml.backup
build/
dist/
tests/_output/

# Autoload files
autoload.php

# Framework-specific (add as needed)
# Laravel
/storage/*.key
storage/logs/*.log
bootstrap/cache/*.php

# Symfony
/var/
/var/log/*.log
/var/cache/*
!/var/cache/.gitkeep
!/var/log/.gitkeep
```
