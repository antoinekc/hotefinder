document.addEventListener('DOMContentLoaded', function () {
  var swiper = new Swiper('.swiper-container', {
      direction: 'horizontal',
      loop: true,
      pagination: {
          el: '.swiper-pagination',
          clickable: true,
      },
      navigation: {
          nextEl: '[data-carousel-next]',
          prevEl: '[data-carousel-prev]',
      },
  });
});