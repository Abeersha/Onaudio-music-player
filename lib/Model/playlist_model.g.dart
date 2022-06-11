// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModelPlaylistAdapter extends TypeAdapter<ModelPlaylist> {
  @override
  final int typeId = 0;

  @override
  ModelPlaylist read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModelPlaylist(
      playlistSongs: (fields[1] as List).cast<Songsdb>(),
      playlistName: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ModelPlaylist obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.playlistName)
      ..writeByte(1)
      ..write(obj.playlistSongs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelPlaylistAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
