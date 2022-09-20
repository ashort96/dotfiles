#!/bin/bash
set -e

LIGHT_GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

function level_1_print() {
  printf "+ ${1}\n"
}

function level_2_print() {
  printf "  + ${1}\n"
}

files=( 
  '.zshrc'
  '.zsh.aliases'
  '.zsh.path'
  '.oh-my-zsh/custom/themes/zeta.zsh-theme'
)

level_1_print "Checking for zsh"

if ! command -v zsh &> /dev/null
then
  level_2_print "${RED}zsh not found -- please install zsh${NC}"
  exit -1
else
  level_2_print "${LIGHT_GREEN}zsh found, continuing...${NC}"
fi

level_1_print "Checking for oh-my-zsh"
if [ ! -d "${HOME}/.oh-my-zsh" ] ; then
    level_2_print "${YELLOW}oh-my-zsh not found -- installing${NC}"
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" > /dev/null 2>&1
    if [[ $? -eq 0 ]]; then
      level_2_print "${LIGHT_GREEN}oh-my-zsh installed, continuing...${NC}"
    else
      level_2_print "${RED}oh-my-zsh failed to nistall${NC}"
      exit -1
    fi
else
  level_2_print "${LIGHT_GREEN}oh-my-zsh found, continuing...${NC}"
fi

repo_path=$(dirname "$0")

level_1_print "Moving files to home directory"
for file in ${files[@]}
do
  if [ -e "${HOME}/${file}" ] ; then
    level_2_print "Moving ${HOME}/${file} to ${HOME}/${file}.old"
    mv "${HOME}/${file}" "${HOME}/${file}.old"
  fi
  level_2_print "Copying ${repo_path}/${file} to ${HOME}/${file}"
  cp "${repo_path}/${file}" "${HOME}/${file}"
done

level_1_print "${LIGHT_GREEN}Install finished${NC} - please run \`omz reload\`"