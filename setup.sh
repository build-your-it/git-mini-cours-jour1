#!/usr/bin/env bash
# Mini-cours « 5 jours pour ne plus avoir peur de Git »
# Jour 1 : les 3 zones de Git
# Crée (ou recrée) le dépôt d'exercice dans ~/mini-cours-git-exos/jour1/projet
# Relançable à volonté : chaque exécution remet le dépôt à l'état de départ.
set -e
SCRIPTS="$(cd "$(dirname "$0")" && pwd)"
JOUR=jour1
BASE="$HOME/mini-cours-git-exos/$JOUR"

export GIT_AUTHOR_NAME="Dev Démo" GIT_AUTHOR_EMAIL="dev@demo.local"
export GIT_COMMITTER_NAME="Dev Démo" GIT_COMMITTER_EMAIL="dev@demo.local"
T=1762678800
commit() { T=$((T+3600)); GIT_AUTHOR_DATE="$T +0100" GIT_COMMITTER_DATE="$T +0100" git commit -q "$@"; }

rm -rf "$BASE" && mkdir -p "$BASE" && cd "$BASE"
cp "$SCRIPTS/verifier.sh" "$BASE/verifier.sh"
git init -q projet && cd projet
git symbolic-ref HEAD refs/heads/main
git config user.name "$GIT_AUTHOR_NAME"
git config user.email "$GIT_AUTHOR_EMAIL"
git config core.autocrlf false

# --- Historique de départ ---
printf '<html>\n  <head><title>Mon site</title></head>\n  <body>Bienvenue !</body>\n</html>\n' > index.html
printf 'body {\n  color: black;\n}\n' > style.css
git add index.html style.css
commit -m "Création du site"

# --- Situation de l'exercice ---
# 1. index.html modifié ET ajouté à l'index
printf '<html>\n  <head><title>Mon super site</title></head>\n  <body>Bienvenue !</body>\n</html>\n' > index.html
git add index.html
# 2. style.css modifié, mais PAS ajouté à l'index
printf 'body {\n  color: darkblue;\n}\n' > style.css
# 3. notes.txt : un nouveau fichier que Git ne suit pas
printf 'Idées en vrac (à ne pas commiter)\n- changer la police\n- ajouter une page contact\n' > notes.txt

echo
echo "Dépôt du jour 1 prêt. Pour commencer :"
echo "  cd ~/mini-cours-git-exos/$JOUR/projet"
echo "  git status"
echo
echo "Quand tu as terminé, vérifie ton travail (depuis le dossier projet) :"
echo "  bash ../verifier.sh"
