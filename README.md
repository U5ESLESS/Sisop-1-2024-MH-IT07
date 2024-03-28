# README

## Soal 1

### Langkah Pengerjaan

1. Pertama-tama saya mendownload link dari form penugasan menggunakan:

    ` curl -L -o sandbox.csv 'https://drive.google.com/uc?id=1cC6MYBI3wRwDgqlFQE1OQUN83JAreId0&export=download' | awk -F'/' '/filename/{print $NF}' RS='&'\n `

2. Kemudian terdapat soal a. Karena Cipung dan Abe baik hati, mereka ingin memberikan hadiah kepada customer yang telah belanja banyak. Tampilkan nama pembeli dengan total sales paling tinggi. berdasarkan soal tersebut saya membuat sandbox.sh dengan cara

    `nano sandbox.sh`

    kemudian saya mengisi file tersebut dengan `#! /bin/bash` lalu memberi command seperti berikut:

    `pembeli_dengan_sales_tertinggi() {
    local highest_sales
    highest_sales=$(awk -F',' 'NR>1 {sales[$6] += $17} END {for (customer in sales) print sales[customer], customer}' sandbox.csv | sort -nr | head -1)
    echo "Total Sales Tertinggi:"
    echo "$highest_sales"
    }`

    dengan fungsi berikut: 

    - local highest_sales = untuk mendeklarasikan variabel lokal yang digunakan untuk menyimpan output total penjualan tertinggi.

    - awk = untuk memproses file csv

    - -F',' = mengatur pemisah agar menjadi koma (,)

    - NR>1 = fungsi awk untuk memproses Number Of Record lebih dari 1 

    - sales[$6] += $17 = Membuat array sales dengan posisi kolom keenam ($6, yang berisi nama pelanggan) dan nilainya adalah total penjualan ($17)

    - END {for (customer in sales) print sales[customer], customer} = mencetak total penjualan untuk setiap pelanggan dan nama pelanggan.

    - sort -nr = Mengurutkan hasil berdasarkan total penjualan tertinggi berada di bagian atas.
    
    - head -1 = Mengambil satu baris paling atas
    
    - echo "Total Sales Tertinggi:" = print "Total Sales Tertinggi:" ke layar.
    
    - echo "$highest_sales" = Menampilkan nilai dari highest_sales ke layar

3. brikut nya terdapat soal seperti berikut b. Karena karena Cipung dan Abe ingin mengefisienkan penjualannya, mereka ingin    merencanakan strategi penjualan untuk customer segment yang memiliki profit paling kecil. Tampilkan customer segment yang memiliki profit paling kecil

    berdasarkan soal tersebut saya membuat command seperti soal pertam namun saya mengganti bagian tertentu seperti berikut

    `profit_terendah() {
    local lowest_profit
    lowest_profit=$(awk -F',' 'NR>1 {profit[$7] += $20} END {for (segment in profit) print profit[segment], segment}' sandbox.csv | sort -t',' -k1,1n | head -1)
    echo "Total Profit terendah:"
    echo "$lowest_profit"
    }`

    saya mengganti bagian kolom untuk meyesuaikan data yang diminta 
    kode yang saya ubah berikut berfungsi:
    
    sort -t',' -k1,1n:
    - -t',' = Mengatur pembatas menjadi koma (,).
    - -k1,1n =  Mengurutkan berdasarkan total profit terendah berada di bagian atas.

4. untuk soal selanjutnya adalah seperti berikut c. Cipung dan Abe hanya akan membeli stok barang yang menghasilkan profit paling tinggi agar efisien. Tampilkan 3 category yang memiliki total profit paling tinggi
    untuk soal ini saya mnggunakan command seperti berikut

    `kategori_profit_tertinggi() {
    local highest_profit
    highest_profit=$(awk -F',' 'NR>1 {profit[$14] += $20} END {for (category in profit) print profit[category], category}' sandbox.csv | sort -t',' -k1,1nr | head -3)
    echo "3 Kategori dengan Profit Paling Tinggi: "
    echo "$highest_profit"
    }`

    command tersebut hampir sama seperti command soal pertama dan kedua, namun saya mengubah head nya menjadi 3 karena pada soal tersebut di perintahkan untuk menampilkan 3 teratas

    - head -3 = Mengambil tiga baris teratas



5. untuk soal treakhir adalah seperti berikut d. Karena ada seseorang yang lapor kepada Cipung dan Abe bahwa pesanannya tidak kunjung sampai, maka mereka ingin mengecek apakah pesanan itu ada. Cari purchase date dan amount (quantity) dari nama adriaens

    untuk soal terakhir, saya menggunakan command berikut:

    `mencari_orderan() {
    local order
    order=$(awk -F',' 'NR>1 && $6=="adriaens" {print $2 "," $18}' sandbox.csv)
    echo "Detail Pesanan Adriaens:"
    echo "$order"
    }`

    dengan beberapa perbedaan dan fungsi nya sebagai berikut: 

    - $6=="adriaens" = Memeriksa nilai pada kolom keenam ada nama "adriaens".
    - {print $2 "," $18} = Jika kolom keenam terdapat nama "adriaens" awk akan mencetak kolom kedua yang berisi kolom 2 dan 18 pada nama "adriaens"

6. untuk script terakhir saya membuat 4 line script seperti berikut: 

    `pembeli_dengan_sales_tertinggi`

    `profit_terendah`

    `kategori_profit_tertinggi`

    `mencari_orderan`

    script tersebut berfungsi untuk menjalankan program sesuai dengan variabel local yang disebutkan

Selesai


### README
## Soal 2
Oppie merupakan seorang peneliti bom atom, ia ingin merekrut banyak peneliti lain untuk mengerjakan proyek bom atom nya, Oppie memiliki racikan bom atom rahasia yang hanya bisa diakses penelitinya yang akan diidentifikasi sebagai user, Oppie juga memiliki admin yang bertugas untuk memanajemen peneliti, bantulah oppie untuk membuat program yang akan memudahkan tugasnya Buatlah 2 program yaitu login.sh dan register.sh Setiap admin maupun user harus melakukan register terlebih dahulu menggunakan email, username, pertanyaan keamanan dan jawaban, dan password

Username yang dibuat bebas, namun email bersifat unique. setiap email yang mengandung kata admin akan dikategorikan menjadi admin Karena resep bom atom ini sangat rahasia Oppie ingin password nya memuat keamanan tingkat tinggi Password tersebut harus di encrypt menggunakan base64 Password yang dibuat harus lebih dari 8 karakter Harus terdapat paling sedikit 1 huruf kapital dan 1 huruf kecil Harus terdapat paling sedikit 1 angka Karena Oppie akan memiliki banyak peneliti dan admin ia berniat untuk menyimpan seluruh data register yang ia lakukan ke dalam folder users file users.txt. Di dalam file tersebut, terdapat catatan seluruh email, username, pertanyaan keamanan dan jawaban, dan password hash yang telah ia buat. Setelah melakukan register, program harus bisa melakukan login. Login hanya perlu dilakukan menggunakan email dan password. Karena peneliti yang di rekrut oleh Oppie banyak yang sudah tua dan pelupa maka Oppie ingin ketika login akan ada pilihan lupa password dan akan keluar pertanyaan keamanan dan ketika dijawab dengan benar bisa memunculkan password

Setelah user melakukan login akan keluar pesan sukses, namun setelah seorang admin melakukan login Oppie ingin agar admin bisa menambah, mengedit (username, pertanyaan keamanan dan jawaban, dan password), dan menghapus user untuk memudahkan kerjanya sebagai admin.

Ketika admin ingin melakukan edit atau hapus user, maka akan keluar input email untuk identifikasi user yang akan di hapus atau di edit Oppie ingin programnya tercatat dengan baik, maka buatlah agar program bisa mencatat seluruh log ke dalam folder users file auth.log, baik login ataupun register. Format: [date] [type] [message] Type: REGISTER SUCCESS, REGISTER FAILED, LOGIN SUCCESS, LOGIN FAILED Ex: [23/09/17 13:18:02] [REGISTER SUCCESS] user [username] registered successfully [23/09/17 13:22:41] [LOGIN FAILED] ERROR Failed login attempt on user with email [email]

# Membuat Registrasi Database Penelitian Atom

## Berikut adalah script nya

    `#!/bin/bash

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
`

## Deskripsi
Script ini adalah sebuah program shell yang berfungsi untuk mendaftarkan pengguna ke dalam database penelitian atom. Program ini akan meminta pengguna untuk memasukkan informasi seperti email, username, pertanyaan keamanan, dan jawaban keamanan. Selain itu, program juga akan memvalidasi password yang dimasukkan oleh pengguna sesuai dengan kriteria yang telah ditentukan.

## Cara Penggunaan

1. **Selamat Datang**
    - Program akan menampilkan pesan "Selamat datang di database penelitian atom" saat pertama kali dijalankan.

2. **Input Data Pengguna**
    - Program akan meminta pengguna untuk memasukkan data sebagai berikut:
        - Email
        - Username
        - Pertanyaan keamanan
        - Jawaban pertanyaan keamanan

3. **Validasi Role**
    - Jika email pengguna mengandung kata 'admin', maka peran (role) pengguna akan diatur sebagai 'admin', jika tidak maka peran akan diatur sebagai 'user'.

4. **Validasi Password**
    - Pengguna akan diminta untuk memasukkan password yang memenuhi kriteria berikut:
        - Minimal 8 karakter
        - Mengandung minimal 1 huruf kapital dan 1 huruf kecil

5. **Enkripsi Password**
    - Password yang dimasukkan oleh pengguna akan dienkripsi menggunakan base64 sebelum disimpan.

6. **Simpan Data**
    - Semua informasi yang dimasukkan oleh pengguna akan disimpan ke dalam file `users.txt` dalam format `email:username:pertanyaan_keamanan:jawaban_keamanan:password_terenkripsi:role`.

7. **Pesan Registrasi**
    - Setelah berhasil mendaftarkan pengguna, program akan menampilkan pesan "Registrasi sukses".

## Catatan

- Data pengguna yang sudah terdaftar akan disimpan dalam file `users.txt`.
- Password pengguna disimpan dalam bentuk terenkripsi menggunakan base64.
- Program ini memiliki validasi password untuk memastikan keamanan data pengguna.

# Membuat Login Database Penelitian Atom

## Berikut adalah script yang saya gunakan

`#!/bin/bash

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
`

## Deskripsi
Script ini adalah sebuah program shell yang berfungsi sebagai sistem login untuk database penelitian atom. Program ini menyediakan tiga opsi utama: Login, Lupa Password, dan Keluar. Selain itu, untuk pengguna dengan peran 'admin', ada menu tambahan yang memungkinkan untuk menambah, mengedit, dan menghapus pengguna, serta melihat daftar email yang terdaftar.

## Fitur dan Cara Penggunaan

### 1. Login

- **Deskripsi**: Opsi ini memungkinkan pengguna untuk login ke sistem menggunakan email dan password.
- **Cara Penggunaan**: 
    1. Pilih opsi `Login`.
    2. Masukkan email pengguna.
    3. Masukkan password pengguna.
    4. Jika berhasil login, Anda akan diberikan akses sesuai dengan peran pengguna (user atau admin).

### 2. Lupa Password

- **Deskripsi**: Opsi ini digunakan untuk memulihkan password yang lupa dengan menjawab pertanyaan keamanan.
- **Cara Penggunaan**: 
    1. Pilih opsi `Lupa Password`.
    2. Masukkan email pengguna.
    3. Jawab pertanyaan keamanan untuk memulihkan password.

### 3. Admin Menu

- **Deskripsi**: Opsi tambahan untuk pengguna dengan peran 'admin'.
- **Fitur**:
    - **Tambah User**: Menambahkan pengguna baru ke dalam database.
    - **Edit User**: Mengedit informasi pengguna yang sudah terdaftar.
    - **Hapus User**: Menghapus pengguna dari database.
    - **List Email**: Menampilkan daftar email yang terdaftar dalam database.
- **Cara Penggunaan**: 
    - Pilih opsi `Login`.
    - Masukkan email dan password admin.
    - Pilih opsi `Menu Admin`.
    - Pilih salah satu opsi tambahan yang tersedia untuk admin.

## Catatan

- Data pengguna disimpan dalam file `users.txt` dengan format `email:username:security_question:security_answer:encrypted_password:role`.
- Password disimpan dalam bentuk terenkripsi menggunakan base64.
- Aktivitas login yang gagal akan dicatat dalam file `auth.log` beserta timestamp dan detail kesalahan.

Selesai

### Readme
## Soal No.3
Alyss adalah seorang gamer yang sangat menyukai bermain game Genshin Impact. Karena hobinya, dia ingin mengoleksi foto-foto karakter Genshin Impact. Suatu saat Yanuar memberikannya sebuah Link yang berisi koleksi kumpulan foto karakter dan sebuah clue yang mengarah ke penemuan gambar rahasia. Ternyata setiap nama file telah dienkripsi dengan menggunakan hexadecimal. Karena penasaran dengan apa yang dikatakan Yanuar, Alyss tidak menyerah dan mencoba untuk mengembalikan nama file tersebut kembali seperti semula.

## Langkah Pengerjaan
- Buat script `awal.sh` menggunakan command `nano awal.sh`
- Isi dari script `awal.sh`
  ```
  #!/bin/bash
  
      wget --no-check-certificate "https://drive.google.com/uc?export=download&id=1oGHdTf4_76_RacfmQIV4i7os4sGwa9vN" -O genshin.zip
      unzip genshin.zip -d genshin_character

      cd genshin_character
        for file in *; do
           filename_wo_ext="${file%.*}"
           decrypted_filename=$(echo $filename_wo_ext | iconv -f latin1 -t ascii)
           decrypted_filename="$decrypted_filename.${file##*.}"
         mv "$file" "$decrypted_filename"
    done

      while IFS=, read -r nama region elemen senjata; do
            original_filename=$(grep -il "$nama" *)
          mkdir -p "$region"
          mv "$original_filename" "$region/$region - $nama - $elemen - $senjata.jpg"
    done < list_character.csv



### Readme
## Soal no 4

## langkah Pengerjaan
 Pertama saya membuat sebuah direktory bernama log untuk menyimpan semua file log

 Kemudian di dalam direktori /home/kyfaiyya/log saya membuat sebuah file log bernama minute_log.sh dengan command `sudo nano minute_log.sh` yang akan di jadikan tempat script di eksekusi.


 Di dalam soal pada poin (a) kita diminta untuk membuat program monitoring resource pada PC kita. Program tersebut harus dapat melakukan hal-hal berikut :
- Memonitor penggunaan RAM menggunakan perintah `free -m`.
- Memonitor ukuran direktori tertentu dengan menggunakan perintah `du -sh <target_path>`.
- Mencatat semua metrik yang didapatkan dari hasil `free -m` dan ukuran direktori dari hasil `du -sh <target_path>`.
- Memasukkan semua metrik tersebut ke dalam file log dengan nama `metrics_{YmdHms}.log`, di mana `{YmdHms}` adalah timestamp saat script dijalankan.
- Script harus dapat berjalan secara otomatis setiap menit.


Untuk menyelesaikan soal ini, kita akan membuat sebuah script Bash yang memenuhi semua persyaratan yang diminta. Script ini akan mengambil metrik penggunaan RAM dan ukuran direktori, kemudian menyimpannya dalam file log dengan nama yang diberi timestamp.

Berikut adalah langkah-langkah yang dilakukan oleh script:

- Mengambil timestamp saat ini dalam format `YYYYMMDDHHmmss` untuk digunakan sebagai nama file log.
- Mengambil informasi penggunaan RAM menggunakan perintah `free -m` dan memproses hasilnya dengan `awk` untuk mendapatkan metrik yang diinginkan.
- Mengambil informasi ukuran direktori `/home/kyfaiyya/` menggunakan perintah `du -sh /home/kyfaiyya/` dan memproses hasilnya dengan awk untuk mendapatkan ukuran direktori.
- Membuat direktori log jika belum ada.
- Menulis semua metrik ke dalam file log dengan nama `metrics_{YmdHms}.log`.

Kemudian pada poin (b) script harus berjalan otomatis setiap menit, maka saya menggunakan crontab untuk melakukan eksekusi terjadwal caranya adalah dengan `crontab -e` untuk menulis crontab baru, lalu mengisi dengan `* * * * * /home/kyfaiyya/log/minute_log.sh`. ini akan mengeksekusi file `minute_log.sh` setiap menit.

## Berikut adalah scriptnya :

`#!/bin/bash`

`conf crontab`

` * * * * * /home/kyfaiyya/log/minute_log.sh`

`TIMESTAMP=$(date +"%Y%m%d%H%M%S")`

`MEM_INFO=$(free -m | awk 'NR==2{print $2","$3","$4","$5","$6","$7}')`

`SWAP_INFO=$(awk '/SwapTotal/{total=$2}/SwapFree/{free=$2}END{print total","(total-free)","free}' /proc/meminfo)`

`DEFAULT_PATH="/home/kyfaiyya"`

`PATH_SIZE=$(/usr/bin/du -sh "$DEFAULT_PATH" | /usr/bin/awk '{print $1}')`

`LOG_DIR="/home/kyfaiyya/log/"`

`mkdir -p "$LOG_DIR"`

`echo "mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size $MEM_INFO,$SWAP_INFO,$DEFAULT_PATH,$PATH_SIZE" > "${LOG_DIR}metrics_${TIMESTAMP}.log"`

## Penjelasan Script :

`TIMESTAMP=$(date +"%Y%m%d%H%M%S")` Mengambil timestamp saat ini dalam format `YYYYMMDDHHmmss` untuk digunakan sebagai nama file log.

`MEM_INFO=$(free -m | awk 'NR==2{print $2","$3","$4","$5","$6","$7}')`  Mengambil informasi memori menggunakan perintah free -m, kemudian menggunakan awk untuk mencetak baris kedua yang berisi informasi memori dalam format yang dipisahkan dengan koma.

`SWAP_INFO=$(awk '/SwapTotal/{total=$2}/SwapFree/{free=$2}END{print total","(total-free)","free}' /proc/meminfo)`  Mengambil informasi swap menggunakan awk untuk memproses file /proc/meminfo dan mencetak total swap, swap yang digunakan, dan swap yang tersedia dalam format yang dipisahkan dengan koma.
`DEFAULT_PATH="/home/kyfaiyya"` - Menetapkan path default yang akan dimonitor ukuran direktorinya.

`PATH_SIZE=$(/usr/bin/du -sh "$DEFAULT_PATH" | /usr/bin/awk '{print $1}')` Menggunakan perintah du untuk mendapatkan ukuran direktori yang telah ditetapkan, dan awk untuk mencetak ukuran tersebut.

`LOG_DIR="/home/kyfaiyya/log"`  Menetapkan direktori tempat menyimpan file log.

`mkdir -p "$LOG_DIR"`  Membuat direktori log jika belum ada.

`echo "mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size $MEM_INFO,$SWAP_INFO,$DEFAULT_PATH,$PATH_SIZE" > "${LOG_DIR}metrics_${TIMESTAMP}.log"`
Menuliskan semua informasi metrik ke dalam file log baru dengan nama yang berisi timestamp.
