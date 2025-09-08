fetch('config.json')
  .then(res => res.json())
  .then(config => {
    const container = document.getElementById('container');
    container.style.gridTemplateRows = config.layout.rows.join(' ');
    container.style.gridTemplateColumns = config.layout.columns.join(' ');
  });

// Load panel HTML content
const panels = {
  'top-left': 'panels/top-left/top-left.html',
  'top-right': 'panels/top-right/top-right.html',
  'middle-left': 'panels/middle-left/middle-left.html',
  'middle-right': 'panels/middle-right/middle-right.html',
  'bottom-panel': 'panels/bottom/bottom.html'
};

for (let id in panels) {
  fetch(panels[id])
    .then(res => res.text())
    .then(html => {
      document.getElementById(id).innerHTML = html;
    });
}
