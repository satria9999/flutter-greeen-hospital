<?php
// Koneksi ke database
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "hospital";

// Buat koneksi
$conn = new mysqli($servername, $username, $password, $dbname);

// Periksa koneksi
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

// Query SQL untuk mengambil data
$sql = "SELECT nama_rumahsakit, lokasi FROM rumahsakit";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
  // Output data dari setiap baris
  while($row = $result->fetch_assoc()) {
    echo "Nama Rumah Sakit: " . $row["nama_rumahsakit"]. " - Lokasi: " . $row["lokasi"]. "<br>";
  }
} else {
  echo "0 results";
}
$conn->close();
?>
