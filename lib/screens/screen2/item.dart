class ItemScreen2 {
  final String namebaitap;
  final int calotieuhao;
  final int sophut;

  ItemScreen2(this.namebaitap, this.calotieuhao, this.sophut);

  Map<String, dynamic> toMap() {
    return {
      'namebaitap': namebaitap,
      'calotieuhao': calotieuhao,
      'sophut': sophut,
    };
  }

  factory ItemScreen2.fromMap(Map<String, dynamic> map) {
    return ItemScreen2(
      map['namebaitap'],
      map['calotieuhao'],
      map['sophut'],
    );
  }
}