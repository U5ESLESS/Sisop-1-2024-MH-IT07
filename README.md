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

### REVISI

    untuk revisi soal terakhir saya menggunakan command berikut:

    `mencari_orderan() {
    local order
    order=$(awk -F',' 'NR>1 && $6=="adriaens" {print $2 "," $18}' sandbox.csv)

    echo "Orderan atas nama Adriaens:"

    if [[ -z "$order" ]]; then
        echo "Orderan tidak tersedia"
    else
        echo "Detail Pesanan Adriaens:"
        echo "$order"
    fi
    }`

    dengan fungsi if else untuk memunculkan output 'orderan tidak terserdia' jika orderan nya tidak di temukan, tapi jika ada maka akan menampilkan orderan dari adriaens.

6. untuk script terakhir saya membuat 4 line script seperti berikut: 

    `pembeli_dengan_sales_tertinggi`

    `profit_terendah`

    `kategori_profit_tertinggi`

    `mencari_orderan`

    script tersebut berfungsi untuk menjalankan program sesuai dengan variabel local yang disebutkan

Selesai


# README
## Soal 2

### Langkah Pengerjaan

1. Pertama-tama saya membuat file register.sh:

    pertama saya menggunakan command berikut untuk membuat dan mengedit file register.sh

    `nano register.sh`

2. langkah berikutnya saya mengisi file tersebut dengan `#!/bin/bash` dan script seperti berikut:

    ### fungsi script berikut untuk Input data dan memasukan ke file user
        read -p "Masukkan email: " email
        read -p "Masukkan username: " username
        read -p "Masukkan pertanyaan keamanan: " security_question
        read -p "Masukkan jawaban pertanyaan keamanan: " security_answer

    ### fungsi script berikut untuk mengecek apakah email mengandung kata 'admin'
        if [[ $email == *"admin"* ]]; then
            role="admin"
        else
            role="user"
        fi

    ### fungsi script berikut untuk memvalidasi password
        while true; do
            read -s -p "Masukkan password (minimal 8 karakter, mengandung 1 huruf kapital, dan 1 angka): " password
            echo

    ### fungsi script berikut untuk memvalidasi panjang password
        if [ ${#password} -lt 8 ]; then
            echo "Password harus lebih dari 8 karakter."
            continue
        fi

    ### fungsi script berikut untuk memvalidasi huruf kapital dan kecil
        if ! [[ "$password" =~ [A-Z] ]] || ! [[ "$password" =~ [a-z] ]]; then
            echo "Password harus mengandung minimal 1 huruf kapital dan 1 huruf kecil."
            continue
        fi  

    ### REVISI
    ### fungsi script berikut untuk memvalidasi angka
        if ! [[ "$password" =~ [0-9] ]]; then
            echo "Password harus mengandung minimal 1 angka."
            continue
        fi

    ### fungsi script berikut untuk encrypt password menggunakan base64
            encrypted_password=$(echo -n "$password" | base64)

            break
        done

    ### fungsi script berikut untuk menyimpan data ke file
        echo "Registrasi: $email:$username:$security_question:$security_answer:$encrypted_password:$role" >> user

        echo "Registrasi sukses"

3. berikutnya saya membuat file login.sh 

    berikut adalah isi script saya: 

    ### fungsi script berikut untuk menampilkan dan memberi opsi
        while true; do
            echo "Login Database Penelitian Atom"

            PS3="Menu (masukkan angka): "
            options=("Login" "Lupa Password" "Keluar")
            select opt in "${options[@]}"; do
                case $REPLY in

    ### fungsi script berikut untuk bagian script menu login
    1. login
        read -p "Masukkan Email: " email

    ### fungsi script berikut untuk cek user dalam list
        user_data=$(grep "$email" user)

    ### fungsi script berikut untuk memvalidasi email
        if [[ -z "$user_data" ]]; then
            echo "loggin attempt: [`date +'%d/%m/%y %H:%M:%S'`] [LOGIN FAILED] ERROR Failed login attempt on user with email $email" >> user
            echo "Email Tidak Terdaftar"
            break
        fi

    ### fungsi script berikut untuk menekstrak data user
        username=$(echo "$user_data" | cut -d':' -f2)
        security_question=$(echo "$user_data" | cut -d':' -f3)
        security_answer=$(echo "$user_data" | cut -d':' -f4)
        encrypted_password=$(echo "$user_data" | cut -d':' -f5)
        role=$(echo "$user_data" | cut -d':' -f6)

    ### fungsi script berikut untuk menginput password
        read -s -p "Masukkan Password: " password
        echo

    ### fungsi script berikut untuk encrypt password menggunakan base64
        encrypted_input_password=$(echo -n "$password" | base64)

    ### fungsi script berikut untuk memvalidasi login
        if [[ "$encrypted_input_password" == "$encrypted_password" ]]; then
            echo "loggin attempt: [`date +'%d/%m/%y %H:%M:%S'`] [LOGIN SUCCESS] user $username logged in successfully" >> user
            echo "Selamat Datang $username."

            if [[ "$role" == "admin" ]]; then

    ### fungsi script berikut untuk menampilkan menu Admin
        PS3="Menu Admin (masukkan angka): "
        admin_options=("Tambah User" "Edit User" "Hapus User" "List Email" "Keluar")
        select admin_opt in "${admin_options[@]}"; do
            case $REPLY in

         
    1. Tambah User
    ### fungsi script berikut untuk menu menambahkan user
        ./register.sh
        break
        ;;

    2. Edit User
    ### Note: edit user tidak bisa mengubah password
    ### fungsi script berikut untuk menu edit user
        read -p "Masukkan email user yang ingin diedit: " edit_email

    ### fungsi script berikut untuk cek user dalam list
        user_data=$(grep "$edit_email" user)

    ### fungsi script berikut untuk memvalidasi email
        if [[ -z "$user_data" ]]; then
            echo "login attempt: [`date +'%d/%m/%y %H:%M:%S'`] [LOGIN FAILED] ERROR Failed login attempt on user with email $edit_email" >> user
            echo "Email Tidak Terdaftar."
            break
        fi

    ### fungsi script berikut untuk mengekstrak data user untuk verifikasi
        username=$(echo "$user_data" | cut -d':' -f2)
        security_question=$(echo "$user_data" | cut -d':' -f3)
        security_answer=$(echo "$user_data" | cut -d':' -f4)

    ### fungsi script berikut untuk memverifikasi keamanan
        read -p "$security_question: " answer

        if [[ "$answer" != "$security_answer" ]]; then
            echo "loggin attempt: [`date +'%d/%m/%y %H:%M:%S'`] [LOGIN FAILED] ERROR Failed login attempt on user with email $edit_email" >> user
            echo "Jawaban tidak valid."
            break
        fi

    ### fungsi script berikut untuk menginput data baru
        read -p "Masukkan username baru: " new_username
        read -p "Masukkan pertanyaan keamanan baru: " new_security_question
        read -p "Masukkan jawaban baru: " new_security_answer

    ### fungsi script berikut untuk update data dalam file
        sed -i "edit attempt: s/$edit_email:.*/$edit_email:$new_username:$new_security_question:$new_security_answer:$encrypted_password#" user

        echo "Data user berhasil diupdate."
        break
        ;;
    3. Hapus User
    ### fungsi script berikut untuk menampilkan menu hapus user
        read -p "Masukkan email user yang ingin dihapus: " delete_email

    ### fungsi script berikut untuk cek user dalam list
        user_data=$(grep "$delete_email" user)

    ### fungsi script berikut untuk memvalidasi email
        if [[ -z "$user_data" ]]; then
            echo "login attempt: [`date +'%d/%m/%y %H:%M:%S'`] [LOGIN FAILED] ERROR Failed login attempt on user with email $delete_email" >> user
            echo "Email Tidak Terdaftar."
            break
        fi

    ### fungsi script berikut untuk mengekstrak data user untuk verifikasi
        username=$(echo "$user_data" | cut -d':' -f2)
        security_question=$(echo "$user_data" | cut -d':' -f3)
        security_answer=$(echo "$user_data" | cut -d':' -f4)

    ### fungsi script berikut untuk memverifikasi keamanan
        read -p "$security_question: " answer

        if [[ "$answer" != "$security_answer" ]]; then
            echo "loggin attempt: [`date +'%d/%m/%y %H:%M:%S'`] [LOGIN FAILED] ERROR Failed login attempt on user with email $delete_email" >> user
            echo "Jawaban tidak valid."
            break
        fi

    ### fungsi script berikut untuk menghapus user dari file
        sed -i "/$delete_email/d" user

        echo "User berhasil dihapus."
        break
        ;;

    4. List Email
    ### fungsi script berikut untuk menampilkan menu list email
        echo "Daftar Email Terdaftar:"
        awk -F':' '{print $1}' user
        ;;

    5. Keluar
    ### fungsi script berikut untuk keluar dari program
        exit 0
        ;;

    6. Pilihan invalid
    ### fungsi script berikut muncul saat menu yang dipilih tidak valid
        echo "Tidak Valid."
        ;;
    
    ### fungsi script berikut untuk mencatat percobaan login
        echo "[loggin attempt: `date +'%d/%m/%y %H:%M:%S'`] [LOGIN FAILED] ERROR Failed login attempt on user with email $email" >> user
        echo "Password Salah."
        break
        fi
        ;;

    ### REVISI

    2. Lupa Password
    ### fungsi script berikut untuk menu Lupa Password
        read -p "Masukkan Email: " email

    ### fungsi script berikut untuk cek user dalam list
        user_data=$(grep "$email" user)

    ### fungsi script berikut untuk memvalidasi email
        if [[ -z "$user_data" ]]; then
            echo "loggin attempt: [`date +'%d/%m/%y %H:%M:%S'`] [FORGOT PASSWORD FAILED] ERROR Failed password reset attempt on user with email $email" >> user
            echo "Email Tidak Terdaftar"
            break
        fi

    ### fungsi script berikut untuk mengekstrak data user
        username=$(echo "$user_data" | cut -d':' -f2)
        security_question=$(echo "$user_data" | cut -d':' -f3)
        security_answer=$(echo "$user_data" | cut -d':' -f4)

    ### fungsi script berikut untuk memverifikasi keamanan
        read -p "$security_question: " answer

        if [[ "$answer" != "$security_answer" ]]; then
            echo "loggin attempt: [`date +'%d/%m/%y %H:%M:%S'`] [FORGOT PASSWORD FAILED] ERROR Failed password reset attempt on user with email $email" >> user
            echo "Jawaban tidak valid."
            break
        fi

    ### fungsi script berikut untuk mereset password
        read -s -p "Masukkan Password Baru: " new_password
        echo

    ### fungsi script berikut untuk encrypt password menggunakan base64
        encrypted_new_password=$(echo -n "$new_password" | base64)

    ### fungsi script berikut untuk update password dalam file
        sed -i "edit attempt: s/$email:.*:$security_question:$security_answer:$encrypted_password/$email:$username:$security_question:$security_answer:$encrypted_new_password#" user

        echo "Password berhasil direset."
        break
        ;;

    3. Keluar
    ### fungsi script berikut untuk keluar dari program
        exit 0
        ;;

    4. Pilihan invalid
    ### fungsi script berikut akan berjalan saat user memilih menu yang tidak valid
        echo "Tidak Valid."
        ;;

# Readme
## Soal No.3
Alyss adalah seorang gamer yang sangat menyukai bermain game Genshin Impact. Karena hobinya, dia ingin mengoleksi foto-foto karakter Genshin Impact. Suatu saat Yanuar memberikannya sebuah Link yang berisi koleksi kumpulan foto karakter dan sebuah clue yang mengarah ke penemuan gambar rahasia. Ternyata setiap nama file telah dienkripsi dengan menggunakan hexadecimal. Karena penasaran dengan apa yang dikatakan Yanuar, Alyss tidak menyerah dan mencoba untuk mengembalikan nama file tersebut kembali seperti semula.

### Langkah Pengerjaan
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

### Penjelasan Script
1. Unduh

        `wget --no-check-certificate "https://drive.google.com/uc?export=download&id=1oGHdTf4_76_RacfmQIV4i7os4sGwa9vN" -O genshin.zip`
   - `wget` perintah untuk mengunduh
   - `"https://drive.google.com/uc?export=download&id=1oGHdTf4_76_RacfmQIV4i7os4sGwa9vN"` URL file yang akan diunduh
   - `-O genshin.zip` file yang diunduh akan disimpan dengan nama `genshin.zip`
2. Unzip

       `unzip genshin.zip -d genshin_character`
   - `unzip` perintah untuk unzip/ekstrak
   - `genshin.zip` file yang akan diunzip
   - `-d genshin_character` hasil dari ekstrak akan disimpan kedalam direktori `genshin_character`
  
3. Decode file hexadecimal

       `cd genshin_character
            for file in *; do
               filename_wo_ext="${file%.*}"
               decrypted_filename=$(echo $filename_wo_ext | iconv -f latin1 -t ascii)
               decrypted_filename="$decrypted_filename.${file##*.}"
             mv "$file" "$decrypted_filename"
        done
   - `cd genshin_character` berpindah direktori ke `genshin_character`
   - `for file in *; do` melakukan perulangan setiap file
   - `filename_wo_ext="${file%.*}"` menghapus ekstensi
   - `decrypted_filename=$(echo $filename_wo_ext | iconv -f latin1 -t ascii)` file yang dihapus ekstensinya diubah formatnya dari hexadecimal ke ASCII menggunakan `iconv`, `-f latin1`, `-t ascii` untuk menunjukkan outputnya harus dalam ASCII
   - `decrypted_filename="$decrypted_filename.${file##*.}"` menambahkan kembali ekstensi yang sebelumnya dihapus untuk memastikan informasi dari file yang dideskripsi tidak berkurang
  
4. Mengganti dan mengatur ulang format

        `while IFS=, read -r nama region elemen senjata; do
                original_filename=$(grep -il "$nama" *)
              mkdir -p "$region"
              mv "$original_filename" "$region/$region - $nama - $elemen - $senjata.jpg"
        done < list_character.csv`
   - `while IFS=, read -r nama region elemen senjata; do`, `while` perulangan, `IFS=,` memisahkan menggunakan koma (,), `read -r nama region elemen senjata` membaca dan menetapkan nilai yang dipisahkan oleh koma(,)
   - `original_filename=$(grep -il "$nama" *)` mencari nama file yang berisi nama karakter
   - `mkdir -p "$region"` membuat direktori `region`
   - `mv "$original_filename" "$region/$region - $nama - $elemen - $senjata.jpg"` memindahkan
   - `done` mengakhiri perulangan
   - `< list_character.csv` membaca perintah dalam file `list_character.csv`
  
- Jalankan menggunakan command `chmod +x awal.sh`
- Eksekusi/run menggunakan command `./awal.sh`

# Readme
## Soal no 4

### langkah Pengerjaan
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

### Berikut adalah scriptnya :

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

### Penjelasan Script :

`TIMESTAMP=$(date +"%Y%m%d%H%M%S")` Mengambil timestamp saat ini dalam format `YYYYMMDDHHmmss` untuk digunakan sebagai nama file log.

`MEM_INFO=$(free -m | awk 'NR==2{print $2","$3","$4","$5","$6","$7}')`  Mengambil informasi memori menggunakan perintah free -m, kemudian menggunakan awk untuk mencetak baris kedua yang berisi informasi memori dalam format yang dipisahkan dengan koma.

`SWAP_INFO=$(awk '/SwapTotal/{total=$2}/SwapFree/{free=$2}END{print total","(total-free)","free}' /proc/meminfo)`  Mengambil informasi swap menggunakan awk untuk memproses file /proc/meminfo dan mencetak total swap, swap yang digunakan, dan swap yang tersedia dalam format yang dipisahkan dengan koma.
`DEFAULT_PATH="/home/kyfaiyya"` - Menetapkan path default yang akan dimonitor ukuran direktorinya.

`PATH_SIZE=$(/usr/bin/du -sh "$DEFAULT_PATH" | /usr/bin/awk '{print $1}')` Menggunakan perintah du untuk mendapatkan ukuran direktori yang telah ditetapkan, dan awk untuk mencetak ukuran tersebut.

`LOG_DIR="/home/kyfaiyya/log"`  Menetapkan direktori tempat menyimpan file log.

`mkdir -p "$LOG_DIR"`  Membuat direktori log jika belum ada.

`echo "mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size $MEM_INFO,$SWAP_INFO,$DEFAULT_PATH,$PATH_SIZE" > "${LOG_DIR}metrics_${TIMESTAMP}.log"`
Menuliskan semua informasi metrik ke dalam file log baru dengan nama yang berisi timestamp.
                                                                                                  
