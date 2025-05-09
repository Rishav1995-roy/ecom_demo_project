// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartDataAdapter extends TypeAdapter<CartData> {
  @override
  final int typeId = 1;

  @override
  CartData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartData(
      id: fields[0] as String,
      name: fields[1] as String,
      price: fields[2] as double,
      imageUrl: (fields[3] as List).cast<String>(),
      quantity: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CartData obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.imageUrl)
      ..writeByte(4)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
