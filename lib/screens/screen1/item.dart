class Item {
  final String name;
  final int calo;
  final int price;

  Item(this.name, this.calo, this.price);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'calo': calo,
      'price': price,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      map['name'],
      map['calo'],
      map['price'],
    );
  }
}