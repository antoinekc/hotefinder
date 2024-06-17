document.getElementById('burger-menu').addEventListener('click', function() {
  var mobileMenu = document.getElementById('mobile-menu');
  if (mobileMenu.classList.contains('hidden')) {
    mobileMenu.classList.remove('hidden');
  } else {
    mobileMenu.classList.add('hidden');
  }
});

window.addEventListener('resize', function() {
  var mobileMenu = document.getElementById('mobile-menu');
  if (window.innerWidth >= 768 && !mobileMenu.classList.contains('hidden')) {
    mobileMenu.classList.add('hidden');
  }
});