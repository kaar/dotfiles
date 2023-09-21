# .config/shell.d
All scripts `(*.sh)` in this location is sources in `.bashrc`

```bash
# Load all scripts in shell.d
for file in ~/.config/shell.d/*.sh ; do
  [ -f "$file" ] && source $file
done
```
