part of 'vidya_box_cubit.dart';

enum ItemsLoading { loading, fetched, initial, error }

enum SlidesLoading { loading, fetched, initial, error }

enum UrlLoading { loading, fetched, initial, error }

class VbState extends Equatable {
  final ItemsLoading itemsLoading;
  final SlidesLoading slidesLoading;
  final UrlLoading urlLoading;

  final List<VidyaBoxSlide>? vidyaboxSlides;
  final String url;

  VbState({
    this.itemsLoading = ItemsLoading.initial,
    this.slidesLoading = SlidesLoading.initial,
    this.urlLoading = UrlLoading.initial,
    this.vidyaboxSlides,
    this.url = "",
  });

  VbState copyWith({
    ItemsLoading? itemsLoading,
    SlidesLoading? slidesLoading,
    List<VidyaBoxSlide>? vidyaboxSlides,
    UrlLoading? urlLoading,
    String? url,
  }) {
    return VbState(
      itemsLoading: itemsLoading ?? this.itemsLoading,
      slidesLoading: slidesLoading ?? this.slidesLoading,
      vidyaboxSlides: vidyaboxSlides ?? this.vidyaboxSlides,
      urlLoading: urlLoading ?? this.urlLoading,
      url: url ?? this.url,
    );
  }

  @override
  List<Object?> get props => [itemsLoading, slidesLoading, vidyaboxSlides, urlLoading, url];
}
