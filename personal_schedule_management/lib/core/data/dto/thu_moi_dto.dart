import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_schedule_management/core/domain/entity/thu_moi_entity.dart';

class ThuMoiDTO {
  String maTM; // invitation id
  String maCV; // WorkId
  String maNM; // UserId
  String emailNM;
  String maKM;
  String emailKM; // UserId
  Timestamp ngayGui;
  int tinhTrang;

  ThuMoiDTO(this.maTM, this.maCV, this.maNM, this.emailNM, this.maKM,
      this.emailKM, this.ngayGui, this.tinhTrang);

  factory ThuMoiDTO.fromJson(Map<String, dynamic> data, String invitationId) {
    return ThuMoiDTO(invitationId, data['maCV'], data['maNM'], data['emailNM'],
        data['maKM'], data['emailKM'], data['ngayGui'], data['tinhTrang']);
  }
  Map<String, dynamic> toJson() {
    return {
      'maCV': maCV,
      'maNM': maNM,
      'emailNM': emailNM,
      'maKM': maKM,
      'emailKM': emailKM,
      'ngayGui': ngayGui,
      'tinhTrang': tinhTrang
    };
  }

  ThuMoi toThuMoi() {
    return ThuMoi(
        maTM, maCV, maNM, emailNM, maKM, emailKM, ngayGui.toDate(), tinhTrang);
  }
}
