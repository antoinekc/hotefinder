document.addEventListener('DOMContentLoaded', function () {
  let currentIndex = 0;
  const items = document.querySelectorAll('[data-carousel-item]');
  const totalItems = items.length;
  const indicators = document.querySelectorAll('[data-carousel-slide-to]');

  function showItem(index) {
    items.forEach((item, i) => {
      item.classList.toggle('hidden', i !== index);
      item.classList.toggle('duration-700', i === index);
      indicators[i].classList.toggle('bg-gray-800', i === index);
      indicators[i].classList.toggle('bg-gray-400', i !== index);
    });
  }

  document.querySelector('[data-carousel-prev]').addEventListener('click', () => {
    currentIndex = (currentIndex === 0) ? totalItems - 1 : currentIndex - 1;
    showItem(currentIndex);
  });

  document.querySelector('[data-carousel-next]').addEventListener('click', () => {
    currentIndex = (currentIndex === totalItems - 1) ? 0 : currentIndex + 1;
    showItem(currentIndex);
  });

  indicators.forEach((indicator, i) => {
    indicator.addEventListener('click', () => {
      currentIndex = i;
      showItem(currentIndex);
    });
  });

  // Initialize the first item
  showItem(currentIndex);
});
