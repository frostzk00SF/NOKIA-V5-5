cat << 'EOF' > nokia.sh
#!/data/data/com.termux/files/usr/bin/bash

RED='\033[1;31m'; GREEN='\033[1;32m'; YELLOW='\033[1;33m'; CYAN='\033[1;36m'; PURPLE='\033[1;35m'; WHITE='\033[1;37m'; RESET='\033[0m'; BOLD='\033[1m'

# Segurança
DEVICE_ID=$(getprop ro.serialno 2>/dev/null || uname -a | md5sum | awk '{print $1}')
DB_DIR="$HOME/.nokia_security"; mkdir -p "$DB_DIR"

clear
echo -e "${CYAN}╔═════════════════════════════════════════════════════════╗"
echo -e "║${WHITE}            NOKIA V5 - EXTREME GAMING EDITION           ${CYAN}║"
echo -e "║${PURPLE}           FPS BOOST & SYSTEM OPTIMIZATION             ${CYAN}║"
echo -e "╚═════════════════════════════════════════════════════════╝${RESET}"

echo -e "${YELLOW}1.${RESET} [FPS] Liberar 120 FPS & GPU Turbo"
echo -e "${YELLOW}2.${RESET} [GAME] Otimizar Free Fire (Compile speed)"
echo -e "${YELLOW}3.${RESET} [SYS] Limpeza de Lixo & Cache"
echo -e "${YELLOW}4.${RESET} [VIP] Acesso Premium (Keys)"
echo -e "${YELLOW}5.${RESET} [NET] Otimização de Rede (Anti-Lag)"
echo -e "${YELLOW}6.${RESET} Sair"
echo -e "${CYAN}───────────────────────────────────────────────────────────${RESET}"
read -p "Escolha uma opção: " opt

case $opt in
    1)
        echo -e "${GREEN}[+] Aplicando 120 FPS & GPU Turbo...${RESET}"
        setprop debug.egl.hw 1
        setprop debug.gr.numframebuffers 3
        setprop persist.sys.NV_FPSLIMIT 120
        setprop ro.vendor.display.default_fps 120
        setprop debug.performance.tuning 1
        setprop video.accelerate.hw 1
        echo -e "${GREEN}[OK] 120 FPS Liberado. Reinicie o jogo para aplicar.${RESET}" ;;
    2)
        echo -e "${CYAN}Selecionar Jogo:${RESET}"
        echo -e "${GREEN}[A]${RESET} FF Normal | ${GREEN}[B]${RESET} FF MAX"
        read -p "Opção: " game
        GAME_PKG=$([ "$game" = "a" ] && echo "com.dts.freefireth" || echo "com.dts.freefiremax")
        echo -e "${GREEN}[+] Otimizando $GAME_PKG (Compile speed)...${RESET}"
        cmd package compile -m speed -a $GAME_PKG > /dev/null 2>&1
        echo -e "${GREEN}[OK] Otimização finalizada.${RESET}" ;;
    3)
        echo -e "${GREEN}[+] Iniciando Limpeza...${RESET}"
        rm -rf /sdcard/Android/data/com.dts.freefire*/files/cache/*
        rm -rf /sdcard/Android/data/com.dts.freefire*/files/contentcache/*
        echo -e "${GREEN}[OK] Limpeza concluída.${RESET}" ;;
    4)
        echo -ne "${YELLOW}Digite sua chave VIP: ${RESET}"; read -s chave; echo ""
        NUM=$(echo "$chave" | cut -d'-' -f3)
        if [[ "$chave" =~ ^TZK-(1DIA|7DIAS|30DIAS)-[0-9]{4}$ ]] && [ "$NUM" -ge 1000 ] && [ "$NUM" -le 1999 ]; then
            HASH=$(echo -n "$chave" | md5sum | awk '{print $1}'); REG="$DB_DIR/reg_$HASH"
            if [ -f "$REG" ] && [ "$(cat "$REG")" != "$DEVICE_ID" ]; then echo -e "${RED}[!] Chave em uso!${RESET}"; exit 1; fi
            echo "$DEVICE_ID" > "$REG"
            echo -e "${GREEN}✨ OTIMIZAÇÃO VIP ATIVA: Modo High-Performance Liberado! ✨${RESET}"
        else echo -e "${RED}[!] Chave Inválida.${RESET}"; fi ;;
    5)
        echo -e "${GREEN}[+] Ajustando Buffers de Rede...${RESET}"
        setprop net.tcp.buffersize.default 4096,87380,1102080,4096,16384,1102080
        setprop net.tcp.buffersize.wifi 4096,87380,1102080,4096,16384,1102080
        echo -e "${GREEN}[OK] Redução de ping aplicada.${RESET}" ;;
    6) exit 0 ;;
esac
EOF
chmod +x nokia.sh && ./nokia.sh