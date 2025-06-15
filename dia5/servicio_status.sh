#!/bin/bash

# Configuración
SERVICIOS=(nginx mysql docker)
ADMIN="obarbozaa@gmail.com"
LOGFILE="/var/log/servicios_monitor.log"

check_service() {
  local svc="$1"
  if systemctl is-active --quiet "$svc"; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $svc: activo" >> "$LOGFILE"
  else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - ALERTA: $svc está caído" | tee -a "$LOGFILE" | mail -s "ALERTA Servicio $svc caído" "$ADMIN"
  fi
}

echo "===== Verificación de servicios =====" >> "$LOGFILE"

for svc in "${SERVICIOS[@]}"; do
  check_service "$svc"
done

echo "===== Fin de verificación =====" >> "$LOGFILE"
echo >> "$LOGFILE"
