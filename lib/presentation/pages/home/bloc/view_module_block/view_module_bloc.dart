import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:e_commerce_app/domain/model/display/view_module/view_module.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../../../core/utils/constant.dart';
import '../../../../../core/utils/error/error_response.dart';
import '../../../../../core/utils/exception/common_exception.dart';
import '../../../../../core/utils/logger.dart';
import '../../../../../domain/model/common/result.dart';
import '../../../../../domain/usecase/display/display.usecase.dart';
import '../../../../../domain/usecase/display/view_module/get_view_modules.usecase.dart';
import '../../component/view_module_list/view_module_factory/view_module_factory.dart';

part 'view_module_event.dart';
part 'view_modue_state.dart';
part 'view_module_bloc.freezed.dart';

EventTransformer<E> _throttleDroppable<E>(Duration duration) {
  return ((events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  });
}

@injectable
class ViewModuleBloc extends Bloc<ViewModuleEvent, ViewModuleState> {
  final DisplayUsecase _displayUsecase;
  ViewModuleBloc(this._displayUsecase) : super(ViewModuleState()) {
    on<ViewModuleInitialized>(_onViewModuleInitialized);
    on<ViewModuleFetched>(_onViewModuleFetched, transformer: _throttleDroppable(Duration(seconds: 1)));
  }
  Future<void> _onViewModuleInitialized(ViewModuleInitialized event, Emitter<ViewModuleState> emit) async {
    try {
      if (event.isRefresh) {
        emit(state.copyWith(status: Status.initial, currentPage: 1, isEndofPage: false, viewModules: []));
      }
      emit(state.copyWith(status: Status.loading));

      final response = await _fetch(
        tabId: event.tabId,
      );

      //이벤트가 발생하면 tabid 가 바뀌니까
      response.when(
        succes: (data) {
          ViewModuleFactory viewModuleFactory = ViewModuleFactory();
          final List<Widget> viewModules = data.map((e) => viewModuleFactory.textToWidget(e)).toList();
          emit(state.copyWith(status: Status.success, tabId: event.tabId, viewModules: viewModules));
        },
        failure: (error) {
          emit(state.copyWith(status: Status.error, error: error));
        },
      );
    } catch (error) {
      CustomLogger.logger.e(error);
      emit(
        state.copyWith(
          status: Status.error,
          error: CommonException.setError(error),
        ),
      );
    }
  }

  Future<Result<List<ViewModule>>> _fetch({required int tabId, int page = 1}) async {
    return await _displayUsecase.excute(usecase: GetViewModulesUsecase(tabId: tabId, page: page));
  }

  Future<void> _onViewModuleFetched(ViewModuleFetched event, Emitter<ViewModuleState> emit) async {
    if (state.isEndofPage) return;
    final nextPage = state.currentPage + 1;
    final tabId = state.tabId;
    emit(state.copyWith(status: Status.loading));
    await Future.delayed(Duration(seconds: 2));
    try {
      //마ㄴ약 끝페이지 도달 시 리턴
      print('[test] fetched called');
      final response = await _fetch(tabId: tabId, page: nextPage);

      //이벤트가 발생하면 tabid 가 바뀌니까
      response.when(
        succes: (data) {
          if (data.isEmpty) {
            //마지막 페이지 빈 리스트 리턴
            emit(
              state.copyWith(status: Status.success, currentPage: nextPage, isEndofPage: true),
            );
            return;
          }
          final List<Widget> viewModules = [...state.viewModules];
          ViewModuleFactory viewModuleFactory = ViewModuleFactory();
          viewModules.addAll(List.generate(data.length, (index) => viewModuleFactory.textToWidget(data[index])));
          // viewModules = data.map((e) => viewModuleFactory.textToWidget(e)).toList();
          emit(state.copyWith(status: Status.success, tabId: tabId, viewModules: viewModules, currentPage: nextPage));
        },
        failure: (error) {
          emit(state.copyWith(status: Status.error, error: error));
        },
      );
    } catch (error) {
      CustomLogger.logger.e(error);
      emit(
        state.copyWith(
          status: Status.error,
          error: CommonException.setError(error),
        ),
      );
    }
  }
}
