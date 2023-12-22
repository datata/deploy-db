#!/bin/bash

# Lista de nombres de usuarios a agregar
usernames=("user_fsd_val_1" "user_fsd_val_2" "user_fsd_val_3" "user_fsd_val_4" "user_fsd_val_5" "user_fsd_val_6" "user_fsd_val_7" "user_fsd_val_8" "user_fsd_val_9" "user_fsd_val_10" "user_fsd_val_11" "user_fsd_val_12" "user_fsd_val_13" "user_fsd_val_14" "user_fsd_val_15" "user_fsd_val_16" "user_fsd_val_17" "user_fsd_val_18" "user_fsd_val_19" "user_fsd_val_20")

# Iterar sobre la lista de nombres de usuarios y agregar cada uno
for username in "${usernames[@]}"; do
    # Verificar si el usuario ya existe
    if id "$username" &>/dev/null; then
        echo "El usuario $username ya existe. Saltando..."
    else
        # Agregar el usuario con el comando adduser
        adduser --disabled-password --gecos "" "$username"

        # Asignar manualmente la contraseña con el comando passwd
        # echo passwd -e password | sudo passwd "$username"
        echo "$username:password" | chpasswd

        # Imprimir mensaje de éxito
        echo "Usuario $username agregado exitosamente."
    fi
done