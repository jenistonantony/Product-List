class Product {
  String name;
  int stock;
  int sold;
  int transferred;

  Product({required this.name, required this.stock})
      : sold = 0,
        transferred = 0;
}
