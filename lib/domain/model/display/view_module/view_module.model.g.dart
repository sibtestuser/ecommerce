// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view_module.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ViewModuleImpl _$$ViewModuleImplFromJson(Map<String, dynamic> json) =>
    _$ViewModuleImpl(
      type: json['type'] as String,
      title: json['title'] as String,
      subTitle: json['subTitle'] as String,
      imageUrl: json['imageUrl'] as String,
      time: (json['time'] as num).toInt(),
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      tabs: (json['tabs'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$ViewModuleImplToJson(_$ViewModuleImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'title': instance.title,
      'subTitle': instance.subTitle,
      'imageUrl': instance.imageUrl,
      'time': instance.time,
      'products': instance.products,
      'tabs': instance.tabs,
    };
