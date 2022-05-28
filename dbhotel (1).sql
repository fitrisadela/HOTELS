-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 28 Bulan Mei 2022 pada 03.29
-- Versi server: 10.4.13-MariaDB
-- Versi PHP: 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbhotel`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `fasilitas_hotel`
--

CREATE TABLE `fasilitas_hotel` (
  `id_fasilitas_hotel` int(10) NOT NULL,
  `nama_fasilitas` varchar(50) NOT NULL,
  `deskripsi` varchar(500) NOT NULL,
  `foto` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `fasilitas_hotel`
--

INSERT INTO `fasilitas_hotel` (`id_fasilitas_hotel`, `nama_fasilitas`, `deskripsi`, `foto`) VALUES
(22, 'PARKIRAN', 'Tersedia parkiran gratis bagi pengunjung hotel & bisa menampung 100 mobil', 'Parkiran.jpg'),
(23, 'GYM', 'BIsa gym untuk privat ', 'fasilitas-gym..jpg'),
(24, 'KAMAR MANDI', 'Bathroom dengan fasilitas handuk baru termasuk juga free sabun mandi & sampo .', '4-kamar-mandi.jpg'),
(25, 'KOLAM RENANG', 'kolam renang untuk dewasa dan anak anak, free handuk .', 'kolamrenang.jpg');

-- --------------------------------------------------------

--
-- Struktur dari tabel `petugas`
--

CREATE TABLE `petugas` (
  `id_petugas` int(11) NOT NULL,
  `username` varchar(25) NOT NULL,
  `password` char(32) NOT NULL,
  `nama_petugas` varchar(35) NOT NULL,
  `level` enum('admin','resepsionis') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `petugas`
--

INSERT INTO `petugas` (`id_petugas`, `username`, `password`, `nama_petugas`, `level`) VALUES
(123, 'admin', '202cb962ac59075b964b07152d234b70', 'fitri', 'admin'),
(1234, 'resepsionis', '202cb962ac59075b964b07152d234b70', 'fitri', 'resepsionis');

-- --------------------------------------------------------

--
-- Struktur dari tabel `reservasi`
--

CREATE TABLE `reservasi` (
  `id_reservasi` int(10) NOT NULL,
  `tipe_kamar` varchar(200) NOT NULL,
  `nik` varchar(25) NOT NULL,
  `nama_pemesan` varchar(30) NOT NULL,
  `email_pemesan` varchar(50) NOT NULL,
  `nama_tamu` varchar(50) NOT NULL,
  `no_telp` int(15) NOT NULL,
  `cek-in` date NOT NULL,
  `cek-out` date NOT NULL,
  `jumlah_kamar` int(10) NOT NULL,
  `harga_kamar` int(11) NOT NULL,
  `total` int(11) NOT NULL,
  `status` tinytext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `reservasi`
--

INSERT INTO `reservasi` (`id_reservasi`, `tipe_kamar`, `nik`, `nama_pemesan`, `email_pemesan`, `nama_tamu`, `no_telp`, `cek-in`, `cek-out`, `jumlah_kamar`, `harga_kamar`, `total`, `status`) VALUES
(34, 'Superior Room', '1234', 'sasa', 'fitrisadela.11@gmail.com', 'fitri', 892342434, '2022-05-24', '2022-05-25', 1, 5000000, 0, 'cek-in'),
(35, 'Superior Room', '1234', 'sasa', 'fitrisadela.11@gmail.com', 'fitri', 892342434, '2022-05-24', '2022-05-25', 1, 5000000, 0, 'cek-in'),
(36, 'Superior Room', '1234', 'sasa', 'fitrisadela.11@gmail.com', 'fitri', 892312311, '2022-05-24', '2022-05-25', 1, 5000000, 0, 'cek-in'),
(37, 'Deluxe Room', '12', 'sasa', 'fitri@gmail.com', 'sasa', 89, '2022-05-24', '2022-05-25', 1, 1000000, 0, 'cek-in'),
(39, 'Standar Room', '12', 'sasa', 'fitri@gmail.com', 'sasa', 89, '2022-05-24', '2022-05-25', 1, 3000000, 0, ''),
(40, 'Superior Room', '12', 'sasa', 'fitri@gmail.com', 'sasa', 89, '2022-05-24', '2022-05-26', 1, 5000000, 0, ''),
(42, 'Presidential Suite', '123', 'Sadela', 'fitri@gmail.com', 'Sadela', 2147483647, '2022-05-25', '2022-05-27', 2, 350000, 1400000, '');

--
-- Trigger `reservasi`
--
DELIMITER $$
CREATE TRIGGER `triger_hotel` AFTER UPDATE ON `reservasi` FOR EACH ROW BEGIN
if new.status='cek-in' THEN UPDATE tbl_kamar set jumlahkamar=jumlahkamar-old.jumlah_kamar
WHERE no_kamar = old.id_reservasi;
END IF;
if new.status='cek-out' THEN UPDATE tbl_kamar set jumlahkamar=jumlahkamar-old.jumlah_kamar
WHERE no_kamar = old.id_reservasi;
END IF;
if new.status='selesai' THEN UPDATE tbl_kamar set jumlahkamar=jumlahkamar-old.jumlah_kamar
WHERE no_kamar = old.id_reservasi;
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tamu`
--

CREATE TABLE `tamu` (
  `nik` int(32) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` char(32) NOT NULL,
  `alamat` text NOT NULL,
  `no_tlp` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tamu`
--

INSERT INTO `tamu` (`nik`, `nama`, `email`, `password`, `alamat`, `no_tlp`) VALUES
(3209999, 'alvia', 'alvia@gmail.com', '', 'kuningan', 896),
(819218387, 'nayla', 'nayla@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', 'kuningan', 89767);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_kamar`
--

CREATE TABLE `tbl_kamar` (
  `no_kamar` char(11) NOT NULL,
  `tipe_kamar` varchar(50) NOT NULL,
  `deskripsi` varchar(500) NOT NULL,
  `harga_kamar` int(100) NOT NULL,
  `jumlahkamar` int(10) NOT NULL,
  `fasilitas_kamar` varchar(50) NOT NULL,
  `status_kamar` enum('tersedia','dipesan','ditempat') NOT NULL,
  `foto` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tbl_kamar`
--

INSERT INTO `tbl_kamar` (`no_kamar`, `tipe_kamar`, `deskripsi`, `harga_kamar`, `jumlahkamar`, `fasilitas_kamar`, `status_kamar`, `foto`) VALUES
('101', 'Spesial Room', 'terdapat satu single bed dengan fasilitas standar, seperti televisi, AC, telepon, dan view kota dari lantai 3.', 700000, 8, 'Wifi', 'tersedia', 'hotel_35.jpg'),
('102', 'Standar Room', 'Kamar dengan tempat tidur ukuran Twin yang sedang, cocok bermalam dikamar hotel scada dengan rekan atau teman anda karena menyediakan kasur twins.', 300000, 5, 'Televisi', 'tersedia', 'hotel_39.jpg'),
('104', 'Presidential Suite', 'Kamar dengan pilihan tempat tidur berukuran King Size yang besar , kamar mandi dengan rain shower ,dengan view sunset & sunrise.', 350000, 6, 'Lemari', 'tersedia', 'hotel_40.jpg'),
('105', 'Deluxe Room', 'Kamar spesial dengan fasilitas yg komplit, cocok menginap untuk keluarga kecil.semoga bermalam di hotel dengan fasilitas kamar yang anda inginkan terimakasih.', 400000, 7, 'Kursi Santai', 'tersedia', 'hotel_3.jpeg');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `fasilitas_hotel`
--
ALTER TABLE `fasilitas_hotel`
  ADD PRIMARY KEY (`id_fasilitas_hotel`);

--
-- Indeks untuk tabel `petugas`
--
ALTER TABLE `petugas`
  ADD PRIMARY KEY (`id_petugas`);

--
-- Indeks untuk tabel `reservasi`
--
ALTER TABLE `reservasi`
  ADD PRIMARY KEY (`id_reservasi`),
  ADD KEY `id_kamar` (`tipe_kamar`);

--
-- Indeks untuk tabel `tamu`
--
ALTER TABLE `tamu`
  ADD PRIMARY KEY (`nik`);

--
-- Indeks untuk tabel `tbl_kamar`
--
ALTER TABLE `tbl_kamar`
  ADD PRIMARY KEY (`no_kamar`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `fasilitas_hotel`
--
ALTER TABLE `fasilitas_hotel`
  MODIFY `id_fasilitas_hotel` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT untuk tabel `petugas`
--
ALTER TABLE `petugas`
  MODIFY `id_petugas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1234568;

--
-- AUTO_INCREMENT untuk tabel `reservasi`
--
ALTER TABLE `reservasi`
  MODIFY `id_reservasi` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
