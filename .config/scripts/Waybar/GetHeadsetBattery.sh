#!/usr/bin/env bash
set -Eeuo pipefail

# Pedimos también chatmix (-m)
OUT="$(headsetcontrol -m -b 2>/dev/null || true)"

emit() {
  # $1 text, $2 tooltip, $3 class_json_array, $4 percentage, $5 alt
  printf '{"text":"%s","tooltip":"%s","class":%s,"percentage":%d,"alt":"%s"}\n' \
    "$1" "$2" "$3" "$4" "$5"
}

json_array_from() {
  local first=1 out="["
  for x in "$@"; do
    if (( first )); then first=0; else out+=", "; fi
    out+="\"$x\""
  done
  out+="]"
  printf '%s' "$out"
}

if [[ -z "$OUT" ]]; then
  emit " --" "No headset detected" "$(json_array_from hb disconnected)" 0 "disconnected"
  exit 0
fi

LEVEL="$(grep -Eo '[0-9]{1,3}%' <<<"$OUT" | head -n1 | tr -d '%')"
LEVEL="${LEVEL:-0}"
STATUS="$(awk -F': *' '/[Ss]tatus/ {print $2; exit}' <<<"$OUT" | tr -d '\r' || true)"
STATUS="${STATUS:-UNKNOWN}"

# Extraer Chatmix (entero 0..128)
CHATMIX_RAW="$(awk -F': *' '/^Chatmix/ {print $2; exit}' <<<"$OUT" | tr -d '\r' || true)"
# Validar que sea número
if [[ "$CHATMIX_RAW" =~ ^[0-9]+$ ]]; then
  CHATMIX="$CHATMIX_RAW"
else
  CHATMIX=""
fi

# Calcular Game% y Chat% con el modelo por tramos
GAME_PCT="" CHATT_PCT=""
if [[ -n "$CHATMIX" ]]; then
  # Constantes
  MAX=128
  HALF=64

  if (( CHATMIX <= HALF )); then
    GAME_PCT=100
    # redondeo: (x*100 + HALF/2) / HALF
    CHATT_PCT=$(( (CHATMIX*100 + (HALF/2)) / HALF ))
  else
    CHATT_PCT=100
    GAME_PCT=$(( ((MAX-CHATMIX)*100 + (HALF/2)) / HALF ))
  fi

  # Limitar por seguridad
  (( GAME_PCT < 0 )) && GAME_PCT=0
  (( GAME_PCT > 100 )) && GAME_PCT=100
  (( CHATT_PCT < 0 )) && CHATT_PCT=0
  (( CHATT_PCT > 100 )) && CHATT_PCT=100
fi

ICON_HEADSET=""
ICON_BOLT=""
ICON_LOW=""

classes=(hb)
alt="normal"
text="$ICON_HEADSET ${LEVEL}%"

lowstat="$(tr '[:upper:]' '[:lower:]' <<<"$STATUS")"
if [[ "$lowstat" == *charg* ]]; then
  text="$ICON_HEADSET $ICON_BOLT ${LEVEL}%"
  classes+=(charging)
  alt="charging"
fi
if (( LEVEL <= 25 )); then
  text="$ICON_LOW ${LEVEL}%"
  classes+=(low)
  alt="low"
fi

# Tooltip
if [[ -n "$CHATMIX" ]]; then
  tooltip="State: ${STATUS}\\nLevel: ${LEVEL}%\\nGame: ${GAME_PCT}%\\nChat: ${CHATT_PCT}%"
else
  tooltip="State: ${STATUS}\\nLevel: ${LEVEL}%\\nGame: N/A\\nChat: N/A"
fi

class_json="$(json_array_from "${classes[@]}")"
emit "$text" "$tooltip" "$class_json" "$LEVEL" "$alt"
