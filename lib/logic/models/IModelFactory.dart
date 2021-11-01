abstract class IJsonSerializable {
  Map<String, dynamic> toJson();
}

abstract class IModelFactory<T extends IJsonSerializable> {
  T fromJson(Map<String, dynamic> jsonMap);
}
