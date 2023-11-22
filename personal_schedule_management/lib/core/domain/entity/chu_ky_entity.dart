import 'package:personal_schedule_management/core/data/dto/chu_ky_dto.dart';

class ChuKy {
  String maCK;
  String tenCK;
  String? thoiDiemLap;

  ChuKy(this.maCK, this.tenCK, this.thoiDiemLap);

  ChuKyDTO toChuKyDTO() {
    return ChuKyDTO(maCK, tenCK, thoiDiemLap);
  }

  @override
  String toString() {
    return 'ChuKy{maCK: $maCK, tenCK: $tenCK, thoiDiemLap: $thoiDiemLap}';
  }
}
