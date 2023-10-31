import 'package:cloud_firestore/cloud_firestore.dart';

class ThongKeDTO {
  Timestamp thangNam;
  int SLCV_ChuaLam;
  int SLCV_DaLam;
  int SLCV_Tre;

  ThongKeDTO(this.thangNam, this.SLCV_ChuaLam, this.SLCV_DaLam, this.SLCV_Tre);
}
