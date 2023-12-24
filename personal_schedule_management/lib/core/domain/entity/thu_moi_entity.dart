import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_schedule_management/core/data/dto/thu_moi_dto.dart';

class ThuMoi {
  String maTM; // invitation id
  String maCV; // WorkId
  String maNM; // UserId
  String emailNM;
  String maKM;
  String emailKM; // UserId
  DateTime ngayGui;
  int tinhTrang;

  ThuMoi(
      this.maTM,
      this.maCV,
      this.maNM,
      this.emailNM,
      this.maKM,
      this.emailKM,
      this.ngayGui,
      this.tinhTrang); // trang thai thu : dong y , tu toi , khong xac dinh , da xoa

  ThuMoiDTO toThuMoiDTO() {
    return ThuMoiDTO(maTM, maCV, maNM, emailNM, maKM, emailKM,
        Timestamp.fromDate(ngayGui), tinhTrang);
  }
}
