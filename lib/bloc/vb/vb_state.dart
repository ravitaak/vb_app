part of 'vidya_box_cubit.dart';

enum ItemsLoading { loading, fetched, initial, error }
enum SlidesLoading { loading, fetched, initial, error }


class VbState extends Equatable {
  final ItemsLoading itemsLoading;
  final SlidesLoading slidesLoading;

  final List<VidyaBoxSlide>? vidyaboxSlides;


  VbState(
      {this.itemsLoading = ItemsLoading.initial,
        this.slidesLoading = SlidesLoading.initial,
        this.vidyaboxSlides,}
       );

  VbState copyWith({
    ItemsLoading? itemsLoading,
    SlidesLoading? slidesLoading,
    List<VidyaBoxSlide>? vidyaboxSlides,

  }) {
    return VbState(
      itemsLoading: itemsLoading ?? this.itemsLoading,
      slidesLoading: slidesLoading ?? this.slidesLoading,
      vidyaboxSlides: vidyaboxSlides ?? this.vidyaboxSlides,

    );
  }

  @override
  List<Object?> get props => [itemsLoading, slidesLoading, vidyaboxSlides];
}


