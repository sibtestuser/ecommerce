import '../../../domain/model/display/menu/menu.model.dart';
import '../../../domain/model/display/view_module/view_module.model.dart';
import '../display/menu/menu.dto.dart';
import '../display/view_module/view_module.dto.dart';

//dto 를 extension 으로 해서 만드는 구나..

extension MenuX on MenuDto {
  Menu toModel() {
    return Menu(tabId: tabId ?? -1, title: title ?? '');
  }
}

extension ViewModuleX on ViewModuleDto {
  ViewModule toModel() {
    return ViewModule(type: type ?? '', title: title ?? '', subTitle: subtitle ?? '', imageUrl: imgUrl ?? '');
  }
}
