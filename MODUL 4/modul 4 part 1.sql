-- Nama     : Muhammad arbiyan saputra
-- NIM		: 23241041
-- Kelas	: B
-- Modul	: ORDER BY, FUNGSI AGREGASI, GROUP BY,HAVING

-- Membuat Database
USE pti_mart;

-- ORDER BY
-- Ambil nama produk dan qty dari tabel penjualan urutkan qty
SELECT nama_produk, qty FROM tr_penjualan ORDER BY qty;

-- Ambil
SELECT nama_produk, qty FROM tr_penjualan ORDER BY qty, nama_produk;

-- Latihan
-- tampilkan semua kolom dari tabel tr_penjualan dengan mengurutkan berdasarkan qty dan tgl transaksi
SELECT * FROM tr_penjualan ORDER BY qty, tgl_transaksi;

-- latihan
-- tampilkan semua kolom dari tabel ms pelanggan dengan mengurutkan berdasarkan nama pelanggan
SELECT * FROM ms_pelanggan ORDER BY nama_pelanggan;

-- latihan
-- tampilkan semua kolom dari tabel ms pelanggan dengan mengurutkan berdasarkan alamat
SELECT * FROM ms_pelanggan ORDER BY alamat;

-- ASC
-- Ambil
SELECT nama_produk, qty FROM tr_penjualan ORDER BY qty DESC;

-- Ambil nama produk, qty dari
SELECT nama_produk, qty FROM tr_penjualan ORDER BY qty DESC, nama_produk DESC;

-- LATIHAN 2 ASC DAN DSC
SELECT * FROM tr_penjualan ORDER BY tgl_transaksi DESC, qty ASC;
SELECT * FROM ms_pelanggan ORDER BY nama_pelanggan DESC;
SELECT * FROM ms_pelanggan ORDER BY alamat DESC;

-- ORDER BY dari hasil perhitungan
-- Ambil nama produk, qty , harga, harga*qty dari tb penjualan urutan harga*qty besar-kecil
SELECT nama_produk, harga, qty, harga*qty AS total 
FROM tr_penjualan
ORDER BY total DESC;
-- bisa pakai total atau harga*qty 

-- latihan 3
-- cobalah pengurutan dengan ekspresi total harga menggunakan rumusan jumlah barang dikali harga barang dikurangi diskon
SELECT nama_produk, harga, qty, diskon_persen, 
(harga * qty) AS total_harga, (harga * qty) - ((diskon_persen / 100) * (harga * qty)) AS total_bayar
FROM tr_penjualan
WHERE diskon_persen > 0
ORDER BY diskon_persen DESC,
  (harga * qty) * (1 - diskon_persen / 100) DESC;

-- order by menggunakan WHERE
-- ambil nama produk, qty dari tb penjualan yang nama produk bermasalah 'F' urut qty
SELECT nama_produk, qty
FROM tr_penjualan
WHERE nama_produk LIKE 'F'
ORDER BY qty DESC;

-- Tambahan dari Latihan Mandiri:
-- 1. Tampilkan semua kolom dari transaksi penjualan yang memiliki diskon dan diurutkan berdasarkan harga tertinggi
SELECT *
FROM tr_penjualan
WHERE diskon_persen IS NOT NULL
ORDER BY harga DESC;

-- 2. Tampilkan kolom nama produk, kuantitas pembelian dan harga dari transaksi penjualan 
--    yang memiliki harga minimal seratus ribu rupiah dan diurutkan berdasarkan harga tertinggi
SELECT nama_produk, qty AS kuantitas_pembelian, harga
FROM tr_penjualan
WHERE harga >= 100000
ORDER BY harga DESC;

-- 3. Tampilkan kolom nama produk, kuantitas pembelian dan harga dari transaksi penjualan 
--    yang memiliki harga minimal seratus ribu rupiah atau nama produk berawalan karakter 'T'
--    dan diurutkan berdasarkan diskon tertinggi
SELECT nama_produk, qty AS kuantitas_pembelian, harga
FROM tr_penjualan
WHERE harga >= 100000 OR nama_produk LIKE 'T%'
ORDER BY diskon_persen DESC;

-- Cek data pelanggan
SELECT * FROM ms_pelanggan;


-- Fungsi Agregesi
-- ambil untuk mengolah beberapa baris/row data untuk menghasilkan nilai baru
-- praktek 7
-- hitung atau jumlahkan seluruh nilai dari baris dari  qty pada tabel penjualan
SELECT qty FROM tr_penjualan;
SELECT SUM(qty) FROM tr_penjualan;

-- praktek 8
-- hitung seluruh baris pada tabel penjualan
SELECT * FROM tr_penjualan;
SELECT COUNT(*) FROM tr_penjualan;

-- praktek 9
-- mengambil 2 fungsi agregesi dalam satu query sql
SELECT SUM(qty), COUNT(*) FROM tr_penjualan;

-- praktek 10
-- hitung rata rata penjualan, penjualan tertinggi per transaksi, dan penjualan terendah per transaksi
SELECT AVG(qty), MAX(qty), MIN(qty)
FROM tr_penjualan;

-- praktek 11
-- mengkombinasikan fungsi agregesi dengan kolom tertentu (nama_produk, kolom tanggal transaksi
SELECT  tgl_transaksi, nama_produk, MAX(qty) FROM tr_penjualan;

-- COUNT(DISTINCT)
-- digunakan untuk menghitung nilai yang unik saja
-- menghitunng nilai unik yang ada pada nama produk di tabel penjualan 
-- tanpa distinct
-- praktek 12
SELECT COUNT(nama_produk) FROM tr_penjualan;

-- praktek 13
-- dengan distinct
SELECT COUNT(distinct nama_produk) FROM tr_penjualan;
SELECT COUNT(nama_produk), COUNT(distinct nama_produk) FROM tr_penjualan;

-- GROUP BY
-- mengelompokan isi data dari satu atau beberapa kolom, biasanya digabung dengan fungsi agregesi
-- GROUP BY 1 KOLOM
-- praktek 14
SELECT nama_produk FROM tr_penjualan GROUP BY nama_produk;
SELECT nama_produk FROM  tr_penjualan;

-- praktek 15
-- mengelompokan nilai nama produk dan qty pada tabel penjualan
SELECT nama_produk, qty from tr_penjualan
GROUP BY nama_produk, qty;

-- praktek 16
-- ambil qty dari nama produk bedsarakan hasil pengelompokan  nama produk
SELECT nama_produk, SUM(qty) FROM tr_penjualan GROUP BY nama_produk;

-- praktek 17
-- ambil qty dari nama produk bedasarkan hasil pengelompokan  nama produk urut dari besar terkecil
SELECT nama_produk, SUM(qty) FROM tr_penjualan GROUP BY nama_produk ORDER BY SUM(qty) DESC;

-- HAVING 
-- digunakan sebagai filtering untuk GROUP BY dan fungsi agregesi
-- praktek 18
-- ambil jumlah qty 
select nama_produk,SUM(qty)
FROM tr_penjualan
GROUP BY nama_produk
HAVING sum (qty) > 2
ORDER BY SUM(qty) DESC;

-- Tugas mandiri 1
-- meliahat daftar nama produk yang total jumlah produk terjual per kelompok nama produk adalah di atas nilai 4
SELECT nama_produk,SUM(qty) AS total_terjual
FROM tr_penjualan
GROUP BY nama_produk
 HAVING   SUM(qty) > 4;
 
-- Tugas mandiri 2
-- melihat daftar nama produk yang  total jumlah produk terjual perkelompok nama produk sama dengan 9
SELECT nama_produk,SUM(qty) AS total_terjual
FROM tr_penjualan
GROUP BY nama_produk
HAVING SUM(qty) = 9;

-- TUgas  mandiri 3
-- melihat daftar kelompok nama produk dan totoal nilai penjualan (harga dikalikan jumlah dikurangi diskon)
--  dengan dan urutan berdasarkan nilai penjualan terbesar
SELECT nama_produk,SUM(qty * harga-(diskon- persen / 100 * harga )) AS total_penjualan
FROM tr_penjualan
GROUP BY nama_produk
ORDER BY total_penjualan DESC;