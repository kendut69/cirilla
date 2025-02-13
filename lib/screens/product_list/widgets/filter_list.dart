import 'package:cirilla/constants/styles.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/store/product/filter_store.dart';
import 'package:cirilla/store/store.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:ui/tab/sticky_tab_bar_delegate.dart';

class FilterList extends StatelessWidget {
  final FilterStore? filter;
  final ProductsStore? productsStore;
  final ProductCategory? category;
  final Brand? brand;

  const FilterList({
    Key? key,
    required this.productsStore,
    required this.filter,
    this.category,
    this.brand,
  }) : super(key: key);

  List<Map<String, dynamic>> getFilter(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    FilterStore filterStore = productsStore!.filter!;

    List<Map<String, dynamic>> filters = [
      {
        'text': translate('product_list_clear_all'),
        'onDeleted': () {
          filterStore.clearAll(categories: category != null ? [category!] : null);
          filter!.clearAll(categories: category != null ? [category!] : null);
        },
      }
    ];

    if (filterStore.inStock) {
      filters.add({
        'text': translate('product_list_in_stock'),
        'onDeleted': () {
          filterStore.onChange(inStock: false);
          filter!.onChange(inStock: false);
        },
      });
    }

    if (filterStore.onSale) {
      filters.add({
        'text': translate('product_list_on_sale'),
        'onDeleted': () {
          filterStore.onChange(onSale: false);
          filter!.onChange(onSale: false);
        },
      });
    }

    if (filterStore.featured) {
      filters.add({
        'text': translate('product_list_featured'),
        'onDeleted': () {
          filterStore.onChange(featured: false);
          filter!.onChange(featured: false);
        },
      });
    }

    ProductCategory? valueFilterCategory = filterStore.categories.isNotEmpty ? filterStore.categories[0] : null;
    if (valueFilterCategory != null && (category == null || valueFilterCategory.id != category!.id)) {
      filters.add({
        'text': valueFilterCategory.name,
        'onDeleted': () {
          filterStore.clearCategory(categories: category != null ? [category!] : null);
          filter!.clearCategory(categories: category != null ? [category!] : null);
        },
      });
    }

    if (filterStore.brand != null && (brand == null || filterStore.brand?.id != brand?.id)) {
      filters.add({
        'text': filterStore.brand?.name ?? "",
        'onDeleted': () {
          filterStore.clearBrand(brand: brand);
          filter!.clearBrand(brand: brand);
        },
      });
    }

    if (filterStore.attributeSelected.isNotEmpty) {
      for (int i = 0; i < filterStore.attributeSelected.length; i++) {
        filters.add({
          'text': filterStore.attributeSelected[i].title,
          'onDeleted': () {
            filterStore.selectAttribute(filterStore.attributeSelected[i]);
            filterStore.onChange(attributeSelected: filterStore.attributeSelected);
            filter!.selectAttribute(filterStore.attributeSelected[i]);
            filter!.onChange(attributeSelected: filterStore.attributeSelected);
          },
        });
      }
    }
    if (filterStore.rangePricesSelected.start > filter!.productPrices.minPrice!) {
      filters.add({
        'text': translate(
          'product_list_min_price',
          {
            'price': formatCurrency(context, price: '${filterStore.rangePricesSelected.start}'),
          },
        ),
        'onDeleted': () {
          RangeValues rangePrices = RangeValues(
            filter!.productPrices.minPrice!,
            filterStore.rangePricesSelected.end,
          );
          filterStore.onChange(rangePricesSelected: rangePrices);
          filter!.onChange(rangePricesSelected: rangePrices);
        },
      });
    }

    if (filterStore.rangePricesSelected.end < filter!.productPrices.maxPrice! &&
        filterStore.rangePricesSelected.end > 0) {
      filters.add({
        'text': translate(
          'product_list_max_price',
          {
            'price': formatCurrency(context, price: '${filterStore.rangePricesSelected.end}'),
          },
        ),
        'onDeleted': () {
          RangeValues rangePrices = RangeValues(
            filterStore.rangePricesSelected.start,
            filter!.productPrices.maxPrice!,
          );
          filterStore.onChange(rangePricesSelected: rangePrices);
          filter!.onChange(rangePricesSelected: rangePrices);
        },
      });
    }

    return filters;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    List<Map<String, dynamic>> filters = getFilter(context);
    if (filters.length > 1) {
      return SliverPadding(
        padding: const EdgeInsets.only(top: itemPaddingLarge),
        sliver: SliverPersistentHeader(
          pinned: false,
          floating: true,
          delegate: StickyTabBarDelegate(
            child: Container(
              alignment: Alignment.center,
              child: ListView(
                padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
                scrollDirection: Axis.horizontal,
                children: [
                  ...List.generate(filters.length, (index) {
                    return Padding(
                      padding: EdgeInsetsDirectional.only(end: index < filters.length - 1 ? 8 : 0),
                      child: SizedBox(
                        height: 34,
                        child: InputChip(
                          label: Row(
                            children: [
                              Text(filters[index]['text']),
                              if (index > 0) ...[
                                const SizedBox(width: 8),
                                const Icon(Icons.clear, size: 14),
                              ]
                            ],
                          ),
                          labelPadding: EdgeInsets.zero,
                          padding: paddingHorizontalMedium,
                          backgroundColor: index > 0 ? theme.colorScheme.surface : Colors.transparent,
                          labelStyle: theme.textTheme.bodySmall
                              ?.copyWith(fontWeight: FontWeight.w500, color: theme.textTheme.titleMedium?.color),
                          side: BorderSide(width: 2, color: theme.dividerColor),
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          onPressed: filters[index]['onDeleted'],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            height: 34,
          ),
        ),
      );
    }
    return SliverPersistentHeader(
      pinned: false,
      floating: true,
      delegate: StickyTabBarDelegate(
        height: 1,
        child: Container(),
      ),
    );
  }
}
