document.addEventListener('DOMContentLoaded', () => {
    document.querySelectorAll('.read-more').forEach(button => {
      button.addEventListener('click', (event) => {
        event.preventDefault();
        const description = button.previousElementSibling;
        const fullText = description.getAttribute('data-full-text');
        description.textContent = fullText;
        description.classList.remove('truncate');
        button.style.display = 'none';
      });
    });
  });
  