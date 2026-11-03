#!/bin/bash

# ===========================================
# Secure SSH Setup + Custom MOTD - AYUSHTHEWARRIOR
# ===========================================

clear

echo -e "\033[1;36m🔐 AYUSHTHEWARRIOR - Secure SSH Configuration\033[0m"
echo -e "\033[1;37m--------------------------------------\033[0m"

sleep 1

echo -e "\033[1;34m▶ Updating SSH settings...\033[0m"

# Backup old config (important safety)
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak 2>/dev/null

# Apply SSH config
sudo bash -c 'cat <<EOF > /etc/ssh/sshd_config
# =========================
# AYUSHTHEWARRIOR SSH Config
# =========================

# LOGIN SETTINGS
PasswordAuthentication yes
PermitRootLogin yes
PubkeyAuthentication no
ChallengeResponseAuthentication no
UsePAM yes

# SECURITY SETTINGS
X11Forwarding no
AllowTcpForwarding yes
ClientAliveInterval 300
ClientAliveCountMax 2
LoginGraceTime 30

# SFTP
Subsystem sftp /usr/lib/openssh/sftp-server
EOF'

if [ $? -eq 0 ]; then
    echo -e "\033[1;32m✔ SSH configuration applied successfully!\033[0m"
else
    echo -e "\033[1;31m✘ Failed to update SSH config!\033[0m"
fi

echo -e "\033[1;34m▶ Restarting SSH service...\033[0m"
sudo systemctl restart ssh || sudo service ssh restart

echo -e "\033[1;32m✔ SSH service restarted successfully!\033[0m"
sleep 1

# ================================
# Install AYUSHTHEWARRIOR MOTD
# ================================
echo -e "\033[1;34m▶ Installing AYUSHTHEWARRIOR MOTD...\033[0m"

bash <(curl -fsSL https://raw.githubusercontent.com/officialayushthewarrior-beep/VMOP/refs/heads/main/motd.sh)

if [ $? -eq 0 ]; then
    echo -e "\033[1;32m✔ AYUSHTHEWARRIOR MOTD Installed!\033[0m"
else
    echo -e "\033[1;31m✘ MOTD Installation Failed!\033[0m"
fi

sleep 1
clear

# ================================
# AYUSHTHEWARRIOR Banner
# ================================
cat << "EOF"

       __     ___    _  _____ _    _ _______ _    _ ________          __     _____  _____  _____ ____  _____  
     /\\ \   / / |  | |/ ____| |  | |__   __| |  | |  ____\ \        / /\   |  __ \|  __ \|_   _/ __ \|  __ \ 
    /  \\ \_/ /| |  | | (___ | |__| |  | |  | |__| | |__   \ \  /\  / /  \  | |__) | |__) | | || |  | | |__) |
   / /\ \\   / | |  | |\___ \|  __  |  | |  |  __  |  __|   \ \/  \/ / /\ \ |  _  /|  _  /  | || |  | |  _  / 
  / ____ \| |  | |__| |____) | |  | |  | |  | |  | | |____   \  /\  / ____ \| | \ \| | \ \ _| || |__| | | \ \ 
 /_/    \_\_|   \____/|_____/|_|  |_|  |_|  |_|  |_|______|   \/  \/_/    \_\_|  \_\_|  \_\_____\____/|_|  \_\
                                                                                                              
                                                                                                                                           
                   

EOF

echo -e "\033[1;32m🎉 AYUSHTHEWARRIOR Setup Completed Successfully!\033[0m"
echo -e "\033[1;37m📌 Your VPS is now configured with secure SSH + premium MOTD.\033[0m"

echo -e "\n\033[1;33m🔑 Please set your ROOT password below 👇\033[0m"
sudo passwd root

echo -e "\n\033[1;36m✨ All done! Welcome to AYUSHTHEWARRIOR 🚀\033[0m"
