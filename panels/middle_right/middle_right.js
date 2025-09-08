document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('.carousel-item').forEach(item => {
    item.addEventListener('click', () => {
      const section = item.getAttribute('data-section');
      loadContent(section);
    });
  });
});
