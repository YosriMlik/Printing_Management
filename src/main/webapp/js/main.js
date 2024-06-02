console.log("Main.js works")
const hoverBox = document.querySelector('#profilee');

hoverBox.addEventListener('mouseenter', () => {
    hoverBox.focus();
});

hoverBox.addEventListener('mouseleave', () => {
    hoverBox.style.backgroundColor = 'lightblue';
});