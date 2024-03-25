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
    read -s -p "Masukkan password (minimal 8 karakter, minimal mengandung 1 huruf kapital): " password
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

    # Encrypt password menggunakan base64
    encrypted_password=$(echo -n "$password" | base64)

    break
done

# Simpan data ke file
echo "$email:$username:$security_question:$security_answer:$encrypted_password:$role" >> users.txt

echo "Registrasi sukses"
