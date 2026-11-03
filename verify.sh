#!/usr/bin/env bash
# Mini-cours Git - Jour 1 : vérifie l'exercice
cd "$HOME/mini-cours-git-exos/jour1/projet" 2>/dev/null || { echo "Dépôt introuvable : lance d'abord  bash jour1/setup.sh"; exit 1; }
ok=0; total=0
check() { total=$((total+1)); if eval "$2" >/dev/null 2>&1; then echo "  OK          $1"; ok=$((ok+1)); else echo "  PAS ENCORE  $1"; fi; }

echo "Vérification du jour 1"
check "Le dépôt contient 3 commits" '[ "$(git rev-list --count HEAD)" = 3 ]'
check "L'avant-dernier commit ne contient que index.html" '[ "$(git diff --name-only HEAD~2 HEAD~1)" = index.html ]'
check "Le dernier commit ne contient que style.css" '[ "$(git diff --name-only HEAD~1 HEAD)" = style.css ]'
check "notes.txt existe toujours, mais n'est pas suivi par Git" '[ -f notes.txt ] && ! git ls-files --error-unmatch notes.txt'
check "Il ne reste rien à commiter (à part notes.txt)" '[ "$(git status --porcelain)" = "?? notes.txt" ]'

echo
if [ "$ok" = "$total" ]; then echo "Bravo, exercice réussi ($ok/$total) !"; else echo "$ok/$total : encore un petit effort. Tu peux tout recommencer avec  bash jour1/setup.sh"; fi
