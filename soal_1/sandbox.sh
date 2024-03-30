#!/bin/bash

pembeli_dengan_sales_tertinggi() {
    local highest_sales
    highest_sales=$(awk -F',' 'NR>1 {sales[$6] += $17} END {for (customer in sales) print sales[customer], customer}' sandbox.csv | sort -nr | head -1)
    echo "Total Sales Tertinggi:"
    echo "$highest_sales"
}

profit_terendah() {
    local lowest_profit
    lowest_profit=$(awk -F',' 'NR>1 {profit[$7] += $20} END {for (segment in profit) print profit[segment], segment}' sandbox.csv | sort -t',' -k1,1n | head -1)
    echo "Total Profit terendah:"
    echo "$lowest_profit"
}

kategori_profit_tertinggi() {
    local highest_profit
    highest_profit=$(awk -F',' 'NR>1 {profit[$14] += $20} END {for (category in profit) print profit[category], category}' sandbox.csv | sort -t',' -k1,1nr | head -3)
    echo "3 Kategori dengan Profit Paling Tinggi: "
    echo "$highest_profit"
}

mencari_orderan() {
    local order
    order=$(awk -F',' 'NR>1 && $6=="adriaens" {print $2 "," $18}' sandbox.csv)

    echo "Orderan atas nama Adriaens:"

    if [[ -z "$order" ]]; then
        echo "Orderan tidak tersedia"
    else
        echo "Detail Pesanan Adriaens:"
        echo "$order"
    fi
}

 pembeli_dengan_sales_tertinggi
 profit_terendah
 kategori_profit_tertinggi
 mencari_orderan
