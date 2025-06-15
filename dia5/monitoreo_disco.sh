#!/bin/bash

ADMIN="obarbozaa@gmail.com"
LOGFILE="/var/log/monitoreo_disco.log"

echo "$(date '+%Y-%m-%d %H:%M:%S') - Inicio de log"  >> "$LOGFILE"

USO_RAIZ=$(df / | grep / | awk '{print $5}' | sed 's/%//g')
TAMANO_HOME=$(du -sh /home | awk '{print $1}' | sed 's/G//g')

if [ "$USO_RAIZ" -ge 90 ]; then
    echo "¡Alerta: Partición / al ${USO_RAIZ}%!" \
	   | tee -a "$LOGFILE" \
	   | mail -s "Alerta Partición /" $ADMIN
fi

if (( $(echo "$TAMANO_HOME > 2" | bc -l) )); then
    echo "¡Alerta: /home ocupa ${TAMANO_HOME}GB!" \
	   | tee -a "$LOGFILE" \
	   | mail -s "Alerta Directorio /home" $ADMIN
fi

echo "Fin de log" >> "$LOGFILE"
echo  >> "$LOGFILE"
