#!/bin/bash

while true; do
    echo "Login Database Penelitian Atom"

    PS3="Menu (masukkan angka): "
    options=("Login" "Lupa Password" "Keluar")
    select opt in "${options[@]}"; do
        case $REPLY in
            1) # Login
                read -p "Masukkan Email: " email

                # Cek user dalam list
                user_data=$(grep "$email" users.txt)

                # Validasi email
                if [[ -z "$user_data" ]]; then
                    echo "[`date +'%d/%m/%y %H:%M:%S'`] [LOGIN FAILED] ERROR Failed login attempt on user with email $email" >> auth.log
                    echo "Email Tidak Terdaftar"
                    break
                fi

                # Ekstrak data user
                username=$(echo "$user_data" | cut -d':' -f2)
                security_question=$(echo "$user_data" | cut -d':' -f3)
                security_answer=$(echo "$user_data" | cut -d':' -f4)
                encrypted_password=$(echo "$user_data" | cut -d':' -f5)
                role=$(echo "$user_data" | cut -d':' -f6)

                # input  password
                read -s -p "Masukkan Password: " password
                echo

                # Encrypt password menggunakan base64
                encrypted_input_password=$(echo -n "$password" | base64)

                # Validasi login
                if [[ "$encrypted_input_password" == "$encrypted_password" ]]; then
                    echo "[`date +'%d/%m/%y %H:%M:%S'`] [LOGIN SUCCESS] user $username logged in successfully" >> auth.log
                    echo "Selamat Datang $username."

                    if [[ "$role" == "admin" ]]; then
                        # Menu Admin
                        PS3="Menu Admin (masukkan angka): "
                        admin_options=("Tambah User" "Edit User" "Hapus User" "List Email" "Keluar")
                        select admin_opt in "${admin_options[@]}"; do
                            case $REPLY in
                                1) # Tambah User
                                    ./register.sh
                                    break
                                    ;;
                                2) # Edit User
                                    read -p "Masukkan email user yang ingin diedit: " edit_email

                                    # Cek user dalam list
                                    user_data=$(grep "$edit_email" users.txt)

                                    # Validasi email
                                    if [[ -z "$user_data" ]]; then
                                        echo "[`date +'%d/%m/%y %H:%M:%S'`] [LOGIN FAILED] ERROR Failed login attempt on user with email $edit_email" >> auth.log
                                        echo "Email Tidak Terdaftar."
                                        break
                                    fi

                                    # Ekstrak data user untuk verifikasi
                                    username=$(echo "$user_data" | cut -d':' -f2)
                                    security_question=$(echo "$user_data" | cut -d':' -f3)
                                    security_answer=$(echo "$user_data" | cut -d':' -f4)

                                    # Verifikasi keamanan
                                    read -p "$security_question: " answer

                                    if [[ "$answer" != "$security_answer" ]]; then
                                        echo "[`date +'%d/%m/%y %H:%M:%S'`] [LOGIN FAILED] ERROR Failed login attempt on user with email $edit_email" >> auth.log
                                        echo "Jawaban tidak valid."
                                        break
                                    fi

                                    # Input data baru
                                    read -p "Masukkan username baru: " new_username
                                    read -p "Masukkan pertanyaan keamanan baru: " new_security_question
                                    read -p "Masukkan jawaban baru: " new_security_answer

                                    # Update data dalam file
                                    sed -i "s/$edit_email:.*/$edit_email:$new_username:$new_security_question:$new_security_answer:$encrypted_password/" users.txt

                                    echo "Data user berhasil diupdate."
                                    break
                                    ;;
                                3) # Hapus User
                                    read -p "Masukkan email user yang ingin dihapus: " delete_email

                                    # Cek user dalam list
                                    user_data=$(grep "$delete_email" users.txt)

                                    # Validasi email
                                    if [[ -z "$user_data" ]]; then
                                        echo "[`date +'%d/%m/%y %H:%M:%S'`] [LOGIN FAILED] ERROR Failed login attempt on user with email $delete_email" >> auth.log
                                        echo "Email Tidak Terdaftar."
                                        break
                                    fi

                                    # Ekstrak data user untuk verifikasi
                                    username=$(echo "$user_data" | cut -d':' -f2)
                                    security_question=$(echo "$user_data" | cut -d':' -f3)
                                    security_answer=$(echo "$user_data" | cut -d':' -f4)

                                    # Verifikasi keamanan
                                    read -p "$security_question: " answer

                                    if [[ "$answer" != "$security_answer" ]]; then
                                        echo "[`date +'%d/%m/%y %H:%M:%S'`] [LOGIN FAILED] ERROR Failed login attempt on user with email $delete_email" >> auth.log
                                        echo "Jawaban tidak valid."
                                        break
                                    fi

                                    # Hapus user dari file
                                    sed -i "/$delete_email/d" users.txt

                                    echo "User berhasil dihapus."
                                    break
                                    ;;
                                4) # List Email
                                    echo "Daftar Email Terdaftar:"
                                    awk -F':' '{print $1}' users.txt
                                    ;;
                                5) # Keluar
                                    exit 0
                                    ;;
                                *) # Pilihan invalid
                                    echo "Tidak Valid."
                                    ;;
                            esac
                        done
                    else
                        exit 0
                    fi
                else
                    echo "[`date +'%d/%m/%y %H:%M:%S'`] [LOGIN FAILED] ERROR Failed login attempt on user with email $email" >> auth.log
                    echo "Password Salah."
                    break
                fi
                ;;
            2) # Lupa Password
                # ... (Tidak ada perubahan di sini)
                ;;
            3) # Keluar
                exit 0
                ;;
            *) # Pilihan invalid
                echo "Tidak Valid."
                ;;
        esac
    done
done
