import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  Future<void> createTable(Database database) async {
    //Chu ky : tenCK --> hang ngay , hang thang , hang nam
    await database.execute("""
       Create table if not exists CHUKY (
        "MaCK" int not null,
        "TenCK" text,           
        "ThoiDiemLap" text,
        "ThoiDiemKetThuc" text,
        PRIMARY KEY("MaCK")) 
    """);
    await database.execute("""
       Create table if not exists LOAICONGVIEC (
        "MaLCV" int not null,
        "TenLCV" text not null,
        PRIMARY KEY("MaLCV")) 
    """);
    await database.execute("""
       Create table if not exists CONGVIEC (
        "MaCV" int not null,
        "MaLCV" int not null,
        "MaCK" int not null,
        "TieuDe" text,
        "NoiDung" text,
        "NgayBatDau" text,
        "NgayKetThuc" text,
        "ThoiGianBatDau" text,
        "ThoiGianKetThuc" text,
        "isCaNgay" int,
        "TrangThai" int,
        "DoUuTien" int,
        "MauSac" text,
        "DiaDiem" text,
        "isKhachMoi" int
        PRIMARY KEY("MaCV")) 
        FOREIGN KEY("MaLCV") REFERENCES "LOAICONGVIEC"("MaLCV")  
        FOREIGN KEY("MaCK") REFERENCES "CHUKY"("MaCK")  
    """);
    await database.execute("""
       Create table if not exists THONGBAO (
        "MaTB" int not null,
        "MaCV" int not null,
        "LoaiTB" text not null,
        "ThoiGian" text,
        PRIMARY KEY("MaTB"))
        FOREIGN KEY("MaCV") REFERENCES "CONGVIEC"("MaCV") 
    """);
    await database.execute("""
       Create table if not exists THONGKE (
        "ThangNam" text not null,
        "SLCVChuaLam" int,
        "SLCVDaLam" int,
        "SLCVTre" int,
        PRIMARY KEY("ThangNam")) 
    """);
    await database.execute("""
       Create table if not exists KHACHMOI (
        "MaCV" text not null,
        "Email" text unique,
        "Quyen" int,
        "TinhTrang" int,
        PRIMARY KEY("MaCV" , "Email")) 
        FOREIGN KEY("MaCV") REFERENCES "CONGVIEC"("MaCV")
    """);
  }
}
