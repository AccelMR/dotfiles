#!/bin/bash
# Script para copiar usando wl-copy

# Captura el contenido seleccionado y lo copia con wl-copy
xclip -selection clipboard -o | wl-copy
