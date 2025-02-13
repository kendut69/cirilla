// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProductsStore on ProductsStoreBase, Store {
  Computed<RequestHelper?>? _$requestHelperComputed;

  @override
  RequestHelper? get requestHelper => (_$requestHelperComputed ??=
          Computed<RequestHelper?>(() => super.requestHelper,
              name: 'ProductsStoreBase.requestHelper'))
      .value;
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(() => super.loading,
          name: 'ProductsStoreBase.loading'))
      .value;
  Computed<ObservableList<Product>>? _$productsComputed;

  @override
  ObservableList<Product> get products => (_$productsComputed ??=
          Computed<ObservableList<Product>>(() => super.products,
              name: 'ProductsStoreBase.products'))
      .value;
  Computed<bool>? _$canLoadMoreComputed;

  @override
  bool get canLoadMore =>
      (_$canLoadMoreComputed ??= Computed<bool>(() => super.canLoadMore,
              name: 'ProductsStoreBase.canLoadMore'))
          .value;
  Computed<Map<dynamic, dynamic>>? _$sortComputed;

  @override
  Map<dynamic, dynamic> get sort =>
      (_$sortComputed ??= Computed<Map<dynamic, dynamic>>(() => super.sort,
              name: 'ProductsStoreBase.sort'))
          .value;
  Computed<int>? _$perPageComputed;

  @override
  int get perPage => (_$perPageComputed ??=
          Computed<int>(() => super.perPage, name: 'ProductsStoreBase.perPage'))
      .value;
  Computed<FilterStore?>? _$filterComputed;

  @override
  FilterStore? get filter =>
      (_$filterComputed ??= Computed<FilterStore?>(() => super.filter,
              name: 'ProductsStoreBase.filter'))
          .value;
  Computed<String>? _$searchComputed;

  @override
  String get search =>
      (_$searchComputed ??= Computed<String>(() => super.search,
              name: 'ProductsStoreBase.search'))
          .value;

  late final _$_filterStoreAtom =
      Atom(name: 'ProductsStoreBase._filterStore', context: context);

  @override
  FilterStore? get _filterStore {
    _$_filterStoreAtom.reportRead();
    return super._filterStore;
  }

  @override
  set _filterStore(FilterStore? value) {
    _$_filterStoreAtom.reportWrite(value, super._filterStore, () {
      super._filterStore = value;
    });
  }

  late final _$fetchProductsFutureAtom =
      Atom(name: 'ProductsStoreBase.fetchProductsFuture', context: context);

  @override
  ObservableFuture<List<Product>?> get fetchProductsFuture {
    _$fetchProductsFutureAtom.reportRead();
    return super.fetchProductsFuture;
  }

  @override
  set fetchProductsFuture(ObservableFuture<List<Product>?> value) {
    _$fetchProductsFutureAtom.reportWrite(value, super.fetchProductsFuture, () {
      super.fetchProductsFuture = value;
    });
  }

  late final _$_productsAtom =
      Atom(name: 'ProductsStoreBase._products', context: context);

  @override
  ObservableList<Product> get _products {
    _$_productsAtom.reportRead();
    return super._products;
  }

  @override
  set _products(ObservableList<Product> value) {
    _$_productsAtom.reportWrite(value, super._products, () {
      super._products = value;
    });
  }

  late final _$_brandAtom =
      Atom(name: 'ProductsStoreBase._brand', context: context);

  @override
  Brand? get _brand {
    _$_brandAtom.reportRead();
    return super._brand;
  }

  @override
  set _brand(Brand? value) {
    _$_brandAtom.reportWrite(value, super._brand, () {
      super._brand = value;
    });
  }

  late final _$pendingAtom =
      Atom(name: 'ProductsStoreBase.pending', context: context);

  @override
  bool get pending {
    _$pendingAtom.reportRead();
    return super.pending;
  }

  @override
  set pending(bool value) {
    _$pendingAtom.reportWrite(value, super.pending, () {
      super.pending = value;
    });
  }

  late final _$_nextPageAtom =
      Atom(name: 'ProductsStoreBase._nextPage', context: context);

  @override
  int get _nextPage {
    _$_nextPageAtom.reportRead();
    return super._nextPage;
  }

  @override
  set _nextPage(int value) {
    _$_nextPageAtom.reportWrite(value, super._nextPage, () {
      super._nextPage = value;
    });
  }

  late final _$_perPageAtom =
      Atom(name: 'ProductsStoreBase._perPage', context: context);

  @override
  int get _perPage {
    _$_perPageAtom.reportRead();
    return super._perPage;
  }

  @override
  set _perPage(int value) {
    _$_perPageAtom.reportWrite(value, super._perPage, () {
      super._perPage = value;
    });
  }

  late final _$_includeAtom =
      Atom(name: 'ProductsStoreBase._include', context: context);

  @override
  ObservableList<Product> get _include {
    _$_includeAtom.reportRead();
    return super._include;
  }

  @override
  set _include(ObservableList<Product> value) {
    _$_includeAtom.reportWrite(value, super._include, () {
      super._include = value;
    });
  }

  late final _$_excludeAtom =
      Atom(name: 'ProductsStoreBase._exclude', context: context);

  @override
  ObservableList<Product> get _exclude {
    _$_excludeAtom.reportRead();
    return super._exclude;
  }

  @override
  set _exclude(ObservableList<Product> value) {
    _$_excludeAtom.reportWrite(value, super._exclude, () {
      super._exclude = value;
    });
  }

  late final _$_tagAtom =
      Atom(name: 'ProductsStoreBase._tag', context: context);

  @override
  ObservableList<int> get _tag {
    _$_tagAtom.reportRead();
    return super._tag;
  }

  @override
  set _tag(ObservableList<int> value) {
    _$_tagAtom.reportWrite(value, super._tag, () {
      super._tag = value;
    });
  }

  late final _$_canLoadMoreAtom =
      Atom(name: 'ProductsStoreBase._canLoadMore', context: context);

  @override
  bool get _canLoadMore {
    _$_canLoadMoreAtom.reportRead();
    return super._canLoadMore;
  }

  @override
  set _canLoadMore(bool value) {
    _$_canLoadMoreAtom.reportWrite(value, super._canLoadMore, () {
      super._canLoadMore = value;
    });
  }

  late final _$_searchAtom =
      Atom(name: 'ProductsStoreBase._search', context: context);

  @override
  String get _search {
    _$_searchAtom.reportRead();
    return super._search;
  }

  @override
  set _search(String value) {
    _$_searchAtom.reportWrite(value, super._search, () {
      super._search = value;
    });
  }

  late final _$_currencyAtom =
      Atom(name: 'ProductsStoreBase._currency', context: context);

  @override
  String get _currency {
    _$_currencyAtom.reportRead();
    return super._currency;
  }

  @override
  set _currency(String value) {
    _$_currencyAtom.reportWrite(value, super._currency, () {
      super._currency = value;
    });
  }

  late final _$_languageAtom =
      Atom(name: 'ProductsStoreBase._language', context: context);

  @override
  String get _language {
    _$_languageAtom.reportRead();
    return super._language;
  }

  @override
  set _language(String value) {
    _$_languageAtom.reportWrite(value, super._language, () {
      super._language = value;
    });
  }

  late final _$_sortAtom =
      Atom(name: 'ProductsStoreBase._sort', context: context);

  @override
  Map<String, dynamic> get _sort {
    _$_sortAtom.reportRead();
    return super._sort;
  }

  @override
  set _sort(Map<String, dynamic> value) {
    _$_sortAtom.reportWrite(value, super._sort, () {
      super._sort = value;
    });
  }

  late final _$_vendorAtom =
      Atom(name: 'ProductsStoreBase._vendor', context: context);

  @override
  Vendor? get _vendor {
    _$_vendorAtom.reportRead();
    return super._vendor;
  }

  @override
  set _vendor(Vendor? value) {
    _$_vendorAtom.reportWrite(value, super._vendor, () {
      super._vendor = value;
    });
  }

  late final _$nextPageAsyncAction =
      AsyncAction('ProductsStoreBase.nextPage', context: context);

  @override
  Future<void> nextPage({Map<String, dynamic>? customQuery}) {
    return _$nextPageAsyncAction
        .run(() => super.nextPage(customQuery: customQuery));
  }

  late final _$getProductsAsyncAction =
      AsyncAction('ProductsStoreBase.getProducts', context: context);

  @override
  Future<List<Product>> getProducts(
      {CancelToken? token, Map<String, dynamic>? customQuery}) {
    return _$getProductsAsyncAction
        .run(() => super.getProducts(token: token, customQuery: customQuery));
  }

  late final _$ProductsStoreBaseActionController =
      ActionController(name: 'ProductsStoreBase', context: context);

  @override
  Future<List<Product>> refresh({CancelToken? token}) {
    final _$actionInfo = _$ProductsStoreBaseActionController.startAction(
        name: 'ProductsStoreBase.refresh');
    try {
      return super.refresh(token: token);
    } finally {
      _$ProductsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onChanged(
      {Map<dynamic, dynamic>? sort,
      String? search,
      int? perPage,
      FilterStore? filterStore}) {
    final _$actionInfo = _$ProductsStoreBaseActionController.startAction(
        name: 'ProductsStoreBase.onChanged');
    try {
      return super.onChanged(
          sort: sort,
          search: search,
          perPage: perPage,
          filterStore: filterStore);
    } finally {
      _$ProductsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchProductsFuture: ${fetchProductsFuture},
pending: ${pending},
requestHelper: ${requestHelper},
loading: ${loading},
products: ${products},
canLoadMore: ${canLoadMore},
sort: ${sort},
perPage: ${perPage},
filter: ${filter},
search: ${search}
    ''';
  }
}
