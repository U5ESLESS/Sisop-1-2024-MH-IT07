#!/bin/bash
# Download
  wget --no-check-certificate "https://drive.google.com/uc?export=download&id=1oGHdTf4_76_RacfmQIV4i7os4sGwa9vN" -O genshin.zip

# Unzip
  unzip genshin.zip -d genshin_character

# Dekrip encrypted hexa
  cd genshin_character
    for file in *; do
     # Delete ext
       filename_wo_ext="${file%.*}"
     # Dekrip hex -> ascii
       decrypted_filename=$(echo $filename_wo_ext | iconv -f latin1 -t ascii)
     # Add ext 
       decrypted_filename="$decrypted_filename.${file##*.}"
     # Rename decrypted
     mv "$file" "$decrypted_filename"
done

# Rename list_char.csv
  while IFS=, read -r nama region elemen senjata; do
      # Cari nama
        original_filename=$(grep -il "$nama" *)
      mkdir -p "$region"
      # Rename & move
      mv "$original_filename" "$region/$region - $nama - $elemen - $senjata.jpg"
done < list_character.csv

