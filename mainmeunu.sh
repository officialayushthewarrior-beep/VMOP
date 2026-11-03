#!/bin/bash

# ─────────────────────────────────────────────────────────────
#  AYUSHTHEWARRIOR · MAIN MENU
# ─────────────────────────────────────────────────────────────

set +e

R='\033[0m'
B='\033[1m'
D='\033[2m'

RED='\033[38;5;196m'
GRN='\033[38;5;46m'
YEL='\033[38;5;226m'
CYN='\033[38;5;51m'
MAG='\033[38;5;201m'
WHT='\033[38;5;255m'
GRY='\033[38;5;245m'
BLU='\033[38;5;39m'

trap 'echo -e "\n  ${B}${YEL}⚠${R} Interrupted. Returning to menu..."; sleep 0.7' SIGINT

# ─────────────────────────────────────────────────────────────
#  ANIMATIONS
# ─────────────────────────────────────────────────────────────

spinner() {
    local msg="$1"
    local duration=${2:-2}          # only whole numbers
    local frames=('⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏')
    local i=0
    local end=$((SECONDS + duration))

    tput civis 2>/dev/null || true
    while [ $SECONDS -lt $end ]; do
        printf "\r  ${B}${MAG}${frames[i]}${R}  ${msg}   "
        i=$(( (i + 1) % 10 ))
        sleep 0.1
    done
    printf "\r  ${B}${GRN}✔${R}  ${msg}          \n"
    tput cnorm 2>/dev/null || true
}

# ─────────────────────────────────────────────────────────────

header() {
    clear
    echo -e "${B}${CYN}"
    cat << "EOF"
    ╔══════════════════════════════════════════════════════════════════╗
    ║                                                                  ║
    ║     █████╗ ██╗   ██╗██╗   ██╗███████╗██╗  ██╗                    ║
    ║    ██╔══██╗╚██╗ ██╔╝██║   ██║██╔════╝██║  ██║                    ║
    ║    ███████║ ╚████╔╝ ██║   ██║███████╗███████║                    ║
    ║    ██╔══██║  ╚██╔╝  ██║   ██║╚════██║██╔══██║                    ║
    ║    ██║  ██║   ██║   ╚██████╔╝███████║██║  ██║                    ║
    ║    ╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚══════╝╚═╝  ╚═╝                    ║
    ║                                                                  ║
    ║              T H E   W A R R I O R   M A I N   M E N U           ║
    ║                                                                  ║
    ╚══════════════════════════════════════════════════════════════════╝
EOF
    echo -e "${R}"
    echo -e "  ${D}${GRY}────────────────────────────────────────────────────────────────${R}"
    echo -e "  ${B}${MAG}▸${R} ${WHT}System ready${R}  ${D}|${R}  ${GRN}●${R} Online  ${D}|${R}  ${YEL}v3.0${R}"
    echo -e "  ${D}${GRY}────────────────────────────────────────────────────────────────${R}"
    echo
}

status() {
    local t=$1
    local m=$2
    case $t in
        INFO)  echo -e "  ${B}${BLU}◆${R} ${m}" ;;
        OK)    echo -e "  ${B}${GRN}✔${R} ${m}" ;;
        WARN)  echo -e "  ${B}${YEL}⚠${R} ${m}" ;;
        ERR)   echo -e "  ${B}${RED}✖${R} ${m}" ;;
        RUN)   echo -e "  ${B}${MAG}▶${R} ${m}" ;;
        *)     echo -e "  ${m}" ;;
    esac
}

# ─────────────────────────────────────────────────────────────
#  ACTIONS
# ─────────────────────────────────────────────────────────────

install_rdp() {
    spinner "Preparing RDP installation..." 2
    echo
    status RUN "Installing RDP (xrdp)..."
    sudo apt update -y >/dev/null 2>&1
    sudo apt install -y xrdp >/dev/null 2>&1
    sudo systemctl enable --now xrdp >/dev/null 2>&1
    echo
    status OK "RDP is ready — connect on port 3389"
}

install_vscode() {
    spinner "Preparing VS Code installation..." 2
    echo
    status RUN "Installing Visual Studio Code..."
    sudo apt update -y >/dev/null 2>&1
    sudo apt install -y wget gpg >/dev/null 2>&1
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg 2>/dev/null
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
    echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | \
        sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
    rm -f packages.microsoft.gpg
    sudo apt update -y >/dev/null 2>&1
    sudo apt install -y code >/dev/null 2>&1
    echo
    status OK "VS Code installed"
}

run_vm() {
    spinner "Loading VM Creation module..." 2
    echo
    status RUN "Opening VM Creation..."
    bash <(curl -fsSL https://raw.githubusercontent.com/officialayushthewarrior-beep/VMOP/refs/heads/main/vms)
}

run_vps() {
    spinner "Loading VPS Panel..." 2
    echo
    status RUN "Opening VPS Panel..."
    bash <(curl -fsSL https://raw.githubusercontent.com/officialayushthewarrior-beep/VMOP/refs/heads/main/vps)
}

run_settings() {
    spinner "Loading Settings..." 2
    echo
    status RUN "Opening Settings..."
    bash <(curl -fsSL https://raw.githubusercontent.com/officialayushthewarrior-beep/VMOP/refs/heads/main/settings)
}

# ─────────────────────────────────────────────────────────────

main() {
    clear
    echo
    spinner "Booting AYUSHTHEWARRIOR system..." 3
    sleep 0.4

    while true; do
        header

        echo -e "  ${B}${WHT}┌─ SELECT OPTION ─────────────────────────────────────────────┐${R}"
        sleep 0.08
        echo -e "  ${B}${WHT}│${R}                                                             ${B}${WHT}│${R}"
        sleep 0.06
        echo -e "  ${B}${WHT}│${R}   ${B}${GRN}[1]${R}  RDP Installation                                   ${B}${WHT}│${R}"
        sleep 0.06
        echo -e "  ${B}${WHT}│${R}   ${B}${CYN}[2]${R}  VS Code Installation                               ${B}${WHT}│${R}"
        sleep 0.06
        echo -e "  ${B}${WHT}│${R}   ${B}${YEL}[3]${R}  VM Creation                                        ${B}${WHT}│${R}"
        sleep 0.06
        echo -e "  ${B}${WHT}│${R}   ${B}${MAG}[4]${R}  VPS Panel                                          ${B}${WHT}│${R}"
        sleep 0.06
        echo -e "  ${B}${WHT}│${R}   ${B}${RED}[5]${R}  Settings                                           ${B}${WHT}│${R}"
        sleep 0.06
        echo -e "  ${B}${WHT}│${R}   ${B}${GRY}[0]${R}  Exit                                               ${B}${WHT}│${R}"
        sleep 0.06
        echo -e "  ${B}${WHT}│${R}                                                             ${B}${WHT}│${R}"
        sleep 0.06
        echo -e "  ${B}${WHT}└─────────────────────────────────────────────────────────────┘${R}"
        echo

        echo -ne "  ${B}${CYN}➤${R} Choice: "
        read -r choice

        case $choice in
            1) echo; install_rdp ;;
            2) echo; install_vscode ;;
            3) echo; run_vm ;;
            4) echo; run_vps ;;
            5) echo; run_settings ;;
            0)
                echo
                status INFO "Goodbye, warrior."
                echo
                exit 0
                ;;
            *)
                echo
                status ERR "Invalid option"
                sleep 0.9
                continue
                ;;
        esac

        echo
        echo -ne "  ${B}${CYN}➤${R} Press Enter to return..."
        read -r
    done
}

main
