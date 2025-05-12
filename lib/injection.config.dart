// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_bloc/flutter_bloc.dart' as _i3;
import 'package:geobase/src/domain/repositories/i_column_repository.dart'
    as _i62;
import 'package:geobase/src/domain/repositories/i_configuration_repository.dart'
    as _i72;
import 'package:geobase/src/domain/repositories/i_field_type_repository.dart'
    as _i25;
import 'package:geobase/src/domain/repositories/i_field_value_repository.dart'
    as _i35;
import 'package:geobase/src/domain/repositories/i_form_repository.dart' as _i14;
import 'package:geobase/src/domain/repositories/i_media_repository.dart'
    as _i20;
import 'package:geobase/src/domain/repositories/i_static_selection_repository.dart'
    as _i31;
import 'package:geobase/src/domain/repositories/repositories.dart' as _i8;
import 'package:geobase/src/domain/services/categories_service.dart' as _i61;
import 'package:geobase/src/domain/services/field_type_service.dart' as _i28;
import 'package:geobase/src/domain/services/form_service.dart' as _i17;
import 'package:geobase/src/domain/services/goedata_service.dart' as _i39;
import 'package:geobase/src/domain/services/interfaces/i_field_type.dart'
    as _i27;
import 'package:geobase/src/domain/services/interfaces/interfaces.dart' as _i16;
import 'package:geobase/src/domain/services/location_reader_service.dart'
    as _i68;
import 'package:geobase/src/domain/services/map_conf_reader_service.dart'
    as _i69;
import 'package:geobase/src/domain/services/map_conf_writter_service.dart'
    as _i70;
import 'package:geobase/src/domain/services/map_markers_service.dart' as _i45;
import 'package:geobase/src/domain/services/media_service.dart' as _i22;
import 'package:geobase/src/domain/services/services.dart' as _i52;
import 'package:geobase/src/domain/services/static_selection_service.dart'
    as _i33;
import 'package:geobase/src/domain/services/user_preferences_reader_service.dart'
    as _i71;
import 'package:geobase/src/domain/services/user_preferences_writter_service.dart'
    as _i73;
import 'package:geobase/src/infrastructure/core/registers/external_registers.dart'
    as _i88;
import 'package:geobase/src/infrastructure/providers/categories_provider.dart'
    as _i7;
import 'package:geobase/src/infrastructure/providers/columns_provider.dart'
    as _i12;
import 'package:geobase/src/infrastructure/providers/field_type_provider.dart'
    as _i24;
import 'package:geobase/src/infrastructure/providers/field_value_provider.dart'
    as _i34;
import 'package:geobase/src/infrastructure/providers/form_provider.dart'
    as _i13;
import 'package:geobase/src/infrastructure/providers/geodata_provider.dart'
    as _i37;
import 'package:geobase/src/infrastructure/providers/interfaces/i_columns_provider.dart'
    as _i11;
import 'package:geobase/src/infrastructure/providers/interfaces/i_field_type_provider.dart'
    as _i23;
import 'package:geobase/src/infrastructure/providers/interfaces/i_local_preferences_provider.dart'
    as _i40;
import 'package:geobase/src/infrastructure/providers/interfaces/i_location_provider.dart'
    as _i42;
import 'package:geobase/src/infrastructure/providers/interfaces/i_media_provider.dart'
    as _i18;
import 'package:geobase/src/infrastructure/providers/interfaces/i_static_selection_provider.dart'
    as _i29;
import 'package:geobase/src/infrastructure/providers/interfaces/interfaces.dart'
    as _i10;
import 'package:geobase/src/infrastructure/providers/local_preferences_provider.dart'
    as _i41;
import 'package:geobase/src/infrastructure/providers/location_provider.dart'
    as _i43;
import 'package:geobase/src/infrastructure/providers/media_provider.dart'
    as _i19;
import 'package:geobase/src/infrastructure/providers/providers.dart' as _i6;
import 'package:geobase/src/infrastructure/providers/static_selection_provider.dart'
    as _i30;
import 'package:geobase/src/infrastructure/repositories/categories_repository.dart'
    as _i9;
import 'package:geobase/src/infrastructure/repositories/columns_repository.dart'
    as _i63;
import 'package:geobase/src/infrastructure/repositories/configuration_repository.dart'
    as _i64;
import 'package:geobase/src/infrastructure/repositories/field_type_repository.dart'
    as _i26;
import 'package:geobase/src/infrastructure/repositories/field_values_repository.dart'
    as _i36;
import 'package:geobase/src/infrastructure/repositories/form_repository.dart'
    as _i15;
import 'package:geobase/src/infrastructure/repositories/geodata_repository.dart'
    as _i38;
import 'package:geobase/src/infrastructure/repositories/location_repository.dart'
    as _i44;
import 'package:geobase/src/infrastructure/repositories/media_repository.dart'
    as _i21;
import 'package:geobase/src/infrastructure/repositories/static_selection_repository.dart'
    as _i32;
import 'package:geobase/src/presentation/core/utils/simple_bloc_observer.dart'
    as _i4;
import 'package:geobase/src/presentation/core/widgets/blocs/form_input_bloc/form_selector_bloc/form_selector_cubit.dart'
    as _i54;
import 'package:geobase/src/presentation/core/widgets/render_classes/reflect.dart'
    as _i5;
import 'package:geobase/src/presentation/pages/categories/blocs/categories_exporter/categories_exporter_cubit.dart'
    as _i79;
import 'package:geobase/src/presentation/pages/categories/blocs/category_form/category_create_form_bloc.dart'
    as _i82;
import 'package:geobase/src/presentation/pages/categories/blocs/category_form/category_edit_form_bloc.dart'
    as _i83;
import 'package:geobase/src/presentation/pages/categories/blocs/category_view/categoryview_cubit.dart'
    as _i85;
import 'package:geobase/src/presentation/pages/categories/blocs/categorylist/categorylist_bloc.dart'
    as _i84;
import 'package:geobase/src/presentation/pages/form/blocs/form_form/form_create_form_bloc.dart'
    as _i51;
import 'package:geobase/src/presentation/pages/form/blocs/form_list/form_list_cubit.dart'
    as _i53;
import 'package:geobase/src/presentation/pages/form/blocs/form_view/form_view_cubit.dart'
    as _i55;
import 'package:geobase/src/presentation/pages/geodata/blocs/blocs.dart'
    as _i66;
import 'package:geobase/src/presentation/pages/geodata/blocs/categories_shower/categoriesshower_cubit.dart'
    as _i81;
import 'package:geobase/src/presentation/pages/geodata/blocs/geodata_create/geodata_create_cubit.dart'
    as _i86;
import 'package:geobase/src/presentation/pages/geodata/blocs/geodata_edit/geodata_edit_cubit.dart'
    as _i56;
import 'package:geobase/src/presentation/pages/geodata/blocs/geodata_exporter/geodata_exporter_cubit.dart'
    as _i57;
import 'package:geobase/src/presentation/pages/geodata/blocs/geodata_form/create_form_bloc.dart'
    as _i65;
import 'package:geobase/src/presentation/pages/geodata/blocs/geodata_form/edit_form_bloc.dart'
    as _i67;
import 'package:geobase/src/presentation/pages/geodata/blocs/geodatalist/geodatalist_bloc.dart'
    as _i58;
import 'package:geobase/src/presentation/pages/geodata/blocs/geodataview/geodataview_cubit.dart'
    as _i60;
import 'package:geobase/src/presentation/pages/home/blocs/categories_map_selector/categoriesmapselector_cubit.dart'
    as _i80;
import 'package:geobase/src/presentation/pages/home/blocs/location/location_cubit.dart'
    as _i74;
import 'package:geobase/src/presentation/pages/home/blocs/map/map_cubit.dart'
    as _i76;
import 'package:geobase/src/presentation/pages/home/blocs/markers/marker_cubit.dart'
    as _i78;
import 'package:geobase/src/presentation/pages/home/blocs/panel_geodata_new/geodata_new_cubit.dart'
    as _i87;
import 'package:geobase/src/presentation/pages/home/blocs/panel_geodata_preview/geodata_preview_cubit.dart'
    as _i59;
import 'package:geobase/src/presentation/pages/home/blocs/sliding_up_panel/sliding_up_panel_cubit.dart'
    as _i47;
import 'package:geobase/src/presentation/pages/options/blocs/map_configuration_forms/map_configuration_form_bloc.dart'
    as _i75;
import 'package:geobase/src/presentation/pages/staticselection/blocs/static_selection_form/static_selection_create_form_bloc.dart'
    as _i48;
import 'package:geobase/src/presentation/pages/staticselection/blocs/static_selection_list/static_selection_list_cubit.dart'
    as _i49;
import 'package:geobase/src/presentation/pages/staticselection/blocs/static_selection_view/static_selection_view_cubit.dart'
    as _i50;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:latlong2/latlong.dart' as _i77;
import 'package:shared_preferences/shared_preferences.dart'
    as _i46; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i3.BlocObserver>(() => _i4.SimpleBlocObserver());
    gh.lazySingleton<_i5.FieldRenderResolver>(() => _i5.FieldRenderResolver());
    gh.lazySingleton<_i6.ICategoriesProvider>(
        () => _i7.CategoriesSQLiteProvider());
    gh.factory<_i8.ICategoriesRepository>(() =>
        _i9.CategoriesRepository(provider: gh<_i10.ICategoriesProvider>()));
    gh.lazySingleton<_i11.IColumnsProvider>(() => _i12.ColumnsSQLiteProvider());
    gh.lazySingleton<_i6.IFieldTypeFormProvider>(
        () => _i13.FormSQLiteProvider());
    gh.lazySingleton<_i14.IFieldTypeFormRepository>(() =>
        _i15.FieldTypeFormRepository(
            provider: gh<_i10.IFieldTypeFormProvider>()));
    gh.factory<_i16.IFieldTypeFormService>(() => _i17.FieldTypeFormService(
        repository: gh<_i14.IFieldTypeFormRepository>()));
    gh.lazySingleton<_i18.IFieldTypeMediaProvider>(
        () => _i19.MediaSQLiteProvider());
    gh.lazySingleton<_i20.IFieldTypeMediaRepository>(() =>
        _i21.FieldTypeMediaRepository(
            provider: gh<_i10.IFieldTypeMediaProvider>()));
    gh.factory<_i16.IFieldTypeMediaService>(() => _i22.FieldTypeMediaService(
        repository: gh<_i20.IFieldTypeMediaRepository>()));
    gh.lazySingleton<_i23.IFieldTypeProvider>(
        () => _i24.FieldTypeSQLiteProvider());
    gh.lazySingleton<_i25.IFieldTypeRepository>(() =>
        _i26.FieldTypeRepository(provider: gh<_i10.IFieldTypeProvider>()));
    gh.lazySingleton<_i27.IFieldTypeService>(() =>
        _i28.FieldTypeService(repository: gh<_i25.IFieldTypeRepository>()));
    gh.lazySingleton<_i29.IFieldTypeStaticSelectionProvider>(
        () => _i30.StaticSelectionSQLiteProvider());
    gh.lazySingleton<_i31.IFieldTypeStaticSelectionRepository>(() =>
        _i32.FieldTypeStaticSelectionRepository(
            provider: gh<_i10.IFieldTypeStaticSelectionProvider>()));
    gh.factory<_i16.IFieldTypeStaticSelectionService>(() =>
        _i33.FieldTypeStaticSelectionService(
            repository: gh<_i31.IFieldTypeStaticSelectionRepository>()));
    gh.lazySingleton<_i10.IFieldValueProvider>(
        () => _i34.FieldValueSQLiteProvider());
    gh.lazySingleton<_i35.IFieldValueRepository>(() =>
        _i36.FieldValueRepository(provider: gh<_i10.IFieldValueProvider>()));
    gh.lazySingleton<_i10.IGeodataProvider>(() => _i37.GeodataSQLiteProvider());
    gh.factory<_i8.IGeodataRepository>(
        () => _i38.GeodataRepository(provider: gh<_i10.IGeodataProvider>()));
    gh.lazySingleton<_i16.IGeodataService>(
        () => _i39.GeodataService(gh<_i8.IGeodataRepository>()));
    gh.lazySingleton<_i40.ILocalPreferencesProvider>(
        () => _i41.LocalPreferencesProvider());
    gh.lazySingleton<_i42.ILocationProvider>(() => _i43.LocationProvider());
    gh.lazySingleton<_i8.ILocationRepository>(
        () => _i44.LocationRepository(gh<_i10.ILocationProvider>()));
    gh.lazySingleton<_i16.IMarkerGetterService>(
        () => _i45.GetMarkers(gh<_i8.IGeodataRepository>()));
    await gh.factoryAsync<_i46.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.factory<_i47.SlidingUpPanelCubit>(() => _i47.SlidingUpPanelCubit());
    gh.factory<_i48.StaticSelectionCreateFormBloc>(
        () => _i48.StaticSelectionCreateFormBloc(
              service: gh<_i16.IFieldTypeStaticSelectionService>(),
              fieldTypeService: gh<_i16.IFieldTypeService>(),
            ));
    gh.factory<_i49.StaticSelectionListCubit>(() =>
        _i49.StaticSelectionListCubit(
            gh<_i16.IFieldTypeStaticSelectionService>()));
    gh.factory<_i50.StaticSelectionViewCubit>(() =>
        _i50.StaticSelectionViewCubit(
            gh<_i16.IFieldTypeStaticSelectionService>()));
    gh.factory<_i51.FormCreateFormBloc>(() => _i51.FormCreateFormBloc(
          formService: gh<_i52.IFieldTypeFormService>(),
          fieldTypeService: gh<_i52.IFieldTypeService>(),
        ));
    gh.factory<_i53.FormListCubit>(
        () => _i53.FormListCubit(gh<_i16.IFieldTypeFormService>()));
    gh.factory<_i54.FormSelectorCubit>(
        () => _i54.FormSelectorCubit(gh<_i8.IFieldTypeFormRepository>()));
    gh.factory<_i55.FormViewCubit>(
        () => _i55.FormViewCubit(gh<_i52.IFieldTypeFormService>()));
    gh.factory<_i56.GeodataEditCubit>(
        () => _i56.GeodataEditCubit(gh<_i52.IGeodataService>()));
    gh.factory<_i57.GeodataExporterCubit>(
        () => _i57.GeodataExporterCubit(gh<_i16.IGeodataService>()));
    gh.factory<_i58.GeodataListBloc>(
        () => _i58.GeodataListBloc(gh<_i52.IGeodataService>()));
    gh.factory<_i59.GeodataPreviewCubit>(
        () => _i59.GeodataPreviewCubit(gh<_i16.IGeodataService>()));
    gh.factory<_i60.GeodataViewCubit>(
        () => _i60.GeodataViewCubit(gh<_i52.IGeodataService>()));
    gh.lazySingleton<_i16.ICategoryService>(() => _i61.CategoriesService(
          gh<_i8.ICategoriesRepository>(),
          gh<_i8.IGeodataRepository>(),
        ));
    gh.lazySingleton<_i62.IColumnRepository>(
        () => _i63.ColumnRepository(provider: gh<_i10.IColumnsProvider>()));
    gh.factory<_i8.IConfigurationRepository>(() =>
        _i64.ConfigurationRepository(gh<_i40.ILocalPreferencesProvider>()));
    gh.factoryParam<_i65.IGeodataCreateFormBloc, _i66.GeodataCreateInitialData?,
        dynamic>((
      createInitialData,
      _,
    ) =>
        _i65.GeodataCreateFormBloc(
          geodataService: gh<_i52.IGeodataService>(),
          createInitialData: createInitialData,
        ));
    gh.factoryParam<_i67.IGeodataEditFormBloc, _i66.GeodataEditInitialData?,
        dynamic>((
      editInitialData,
      _,
    ) =>
        _i67.GeodataEditFormBloc(
          geodataService: gh<_i52.IGeodataService>(),
          editInitialData: editInitialData,
        ));
    gh.lazySingleton<_i52.ILocationReaderService>(
        () => _i68.LocationReaderService(gh<_i8.ILocationRepository>()));
    gh.lazySingleton<_i16.IMapConfigurationReaderService>(() =>
        _i69.MapConfigurationReaderService(gh<_i8.IConfigurationRepository>()));
    gh.lazySingleton<_i16.IMapConfigurationWritterService>(() =>
        _i70.MapConfigurationWritterService(
            gh<_i8.IConfigurationRepository>()));
    gh.lazySingleton<_i16.IUserPreferencesReaderService>(() =>
        _i71.UserPreferencesReaderService(gh<_i72.IConfigurationRepository>()));
    gh.lazySingleton<_i16.IUserPreferencesWritterService>(() =>
        _i73.UserPreferencesWritterService(
            gh<_i72.IConfigurationRepository>()));
    gh.factory<_i74.LocationCubit>(() =>
        _i74.LocationCubit(locationService: gh<_i52.ILocationReaderService>()));
    gh.factory<_i75.MapConfigurationFormBloc>(
        () => _i75.MapConfigurationFormBloc(
              readerService: gh<_i16.IMapConfigurationReaderService>(),
              writterService: gh<_i16.IMapConfigurationWritterService>(),
            ));
    gh.factoryParam<_i76.MapCubit, _i77.LatLng?, dynamic>((
      initialLocation,
      _,
    ) =>
        _i76.MapCubit(
          initialLocation: initialLocation,
          confReader: gh<_i52.IMapConfigurationReaderService>(),
          usPrefsReader: gh<_i52.IUserPreferencesReaderService>(),
          usPrefsWritter: gh<_i52.IUserPreferencesWritterService>(),
        ));
    gh.factory<_i78.MarkerCubit>(() => _i78.MarkerCubit(
          markerGetterService: gh<_i16.IMarkerGetterService>(),
          uPrefsReader: gh<_i16.IUserPreferencesReaderService>(),
        ));
    gh.factory<_i79.CategoriesExporterCubit>(
        () => _i79.CategoriesExporterCubit(gh<_i16.ICategoryService>()));
    gh.factory<_i80.CategoriesMapSelectorCubit>(
        () => _i80.CategoriesMapSelectorCubit(
              gh<_i16.ICategoryService>(),
              gh<_i16.IUserPreferencesReaderService>(),
            ));
    gh.factory<_i81.CategoriesShowerCubit>(
        () => _i81.CategoriesShowerCubit(gh<_i16.ICategoryService>()));
    gh.factory<_i82.CategoryCreateFormBloc>(() => _i82.CategoryCreateFormBloc(
          categoryService: gh<_i52.ICategoryService>(),
          fieldTypeService: gh<_i52.IFieldTypeService>(),
        ));
    gh.factoryParam<_i83.CategoryEditFormBloc, int?, dynamic>((
      categoryId,
      _,
    ) =>
        _i83.CategoryEditFormBloc(
          categoryId: categoryId,
          categoryService: gh<_i52.ICategoryService>(),
          fieldTypeService: gh<_i52.IFieldTypeService>(),
        ));
    gh.factory<_i84.CategoryListBloc>(
        () => _i84.CategoryListBloc(gh<_i52.ICategoryService>()));
    gh.factory<_i85.CategoryViewCubit>(
        () => _i85.CategoryViewCubit(gh<_i52.ICategoryService>()));
    gh.factory<_i86.GeodataCreateCubit>(() => _i86.GeodataCreateCubit(
          gh<_i52.ICategoryService>(),
          gh<_i52.ILocationReaderService>(),
        ));
    gh.factory<_i87.GeodataNewCubit>(
        () => _i87.GeodataNewCubit(gh<_i16.ICategoryService>()));
    return this;
  }
}

class _$RegisterModule extends _i88.RegisterModule {}
