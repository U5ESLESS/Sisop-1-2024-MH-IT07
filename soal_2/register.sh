#!/bin/bash

echo "Selamat datang di database penelitian atom"

# Input data dari user
read -p "Masukkan email: " email
read -p "Masukkan username: " username
read -p "Masukkan pertanyaan keamanan: " security_question
read -p "Masukkan jawaban pertanyaan keamanan: " security_answer

# Cek apakah email mengandung kata 'admin'
if [[ $email == *"admin"* ]]; then
    role="admin"
else
    role="user"
fi

# Validasi password
while true; do
    read -s -p "Masukkan password (minimal 8 karakter, mengandung 1 huruf kapital, dan 1 angka): " password
    echo

    # Validasi panjang password
    if [ ${#password} -lt 8 ]; then
        echo "Password harus lebih dari 8 karakter."
        continue
    fi

    # Validasi huruf kapital dan kecil
    if ! [[ "$password" =~ [A-Z] ]] || ! [[ "$password" =~ [a-z] ]]; then
        echo "Password harus mengandung minimal 1 huruf kapital dan 1 huruf kecil."
        continue
    fi

#revisi ----------------------------------------------------
    # Validasi angka
    if ! [[ "$password" =~ [0-9] ]]; then
	echo "Password harus mengandung minimal 1 angka."
	continue
    fi

    # Encrypt password menggunakan base64
    encrypted_password=$(echo -n "$password" | base64)

    break
done

#revisi --------------------------------------------------------------------------------------------------
# Simpan data ke file
echo "Registrasi: $email:$username:$security_question:$security_answer:$encrypted_password:$role" >> user

echo "Registrasi sukses"
