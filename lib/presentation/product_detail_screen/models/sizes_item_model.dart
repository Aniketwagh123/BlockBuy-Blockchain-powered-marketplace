/// This class is used in the sizes_item_widget screen.
class SizesItemModel {
  SizesItemModel({
    this.size,
    this.six,
    this.id,
    this.selected = false, // Added selected property with default value
  });

  String? size;
  String? id;
  String? six;
  bool? selected = false; // Indicates whether the size item is selected or not

  // Copy constructor to create a new instance with updated selected status
  SizesItemModel copyWith({String? size, String? id, String? six, bool? selected}) {
    return SizesItemModel(
      size: size ?? this.size,
      id: id ?? this.id,
      six: six ?? this.six,
      selected: selected ?? false,
    );
  }
}
