function loadContent(section) {
  fetch(`content/${section}.html`)
    .then(res => res.text())
    .then(html => {
      document.getElementById('bottom-panel').innerHTML = html;
    })
    .catch(err => {
      console.error(`Error loading ${section}:`, err);
    });
}