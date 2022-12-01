class InventoryItem {
  InventoryItem({
    required this.id,
    required this.category,
    required this.quantityPerCrate,
    required this.suffix,
    required this.pricePerCrate,
    required this.itemName,
    required this.imageUrl,
  });

  final int id;
  final ItemCategory category;
  final int quantityPerCrate;
  final double pricePerCrate;
  final Suffix suffix;
  final String itemName;
  final String imageUrl;

  factory InventoryItem.fromJson(Map<String, dynamic> data) {
    return InventoryItem(
      id: data["id"],
      category: _getCategory(data["category"] as String?),
      quantityPerCrate: data["quantity_per_crate"],
      suffix: Suffix.kilogram,
      pricePerCrate: data["price_per_crate"],
      itemName: data["item_name"],
      imageUrl: data["image_url"]
    );
  }


}

ItemCategory _getCategory (String? data) {
  return ItemCategory.vegetable;
}

enum ItemCategory {
  vegetable,
  fruit,
}

enum Suffix {
  kilogram,
  gram,
  bundle,
  packet,
  pieces,
}
