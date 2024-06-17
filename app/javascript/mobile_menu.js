window.addEventListener('resize', function() {
  var mobileMenu = document.getElementById('mobile-menu');
  if (window.innerWidth >= 768 && !mobileMenu.classList.contains('hidden')) {
    mobileMenu.classList.add('hidden');
  }
});