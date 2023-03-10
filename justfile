# list recipes
help:
  just --list

now := `date +"%Y-%m-%d_%H.%M.%S"`
hostname := `uname -n`

# echo hostname (uname -n)
echo:
  @echo "{{ hostname }}"

# Checkout main && pull
main: 
  git checkout main && git pull origin main && git branch
