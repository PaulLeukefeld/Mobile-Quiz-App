///Store item model that holds all information associated with a store item
class StoreItem {
  final String name;
  final String description;
  final String hint;
  final List<dynamic> subName;
  final List<dynamic> subValue;

  StoreItem(
      {this.name, this.description, this.hint, this.subName, this.subValue});
}
