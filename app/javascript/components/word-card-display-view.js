const chevronIcon = document.querySelectorAll(".display-content");
const chevrons = document.querySelectorAll('.chevron-selector');

const rotateMe = () => {
  if (chevronIcon) {
    chevronIcon.forEach(function(element) {
      element.addEventListener("click", (event) => {
        if (event.currentTarget.firstElementChild.id === "test") {
          event.currentTarget.firstElementChild.id = "rotate-me";
        } else if (event.currentTarget.firstElementChild.id === "rotate-me") {
          event.currentTarget.firstElementChild.id = "";
          event.currentTarget.firstElementChild.id = "unrotate-me";
        } else {
          event.currentTarget.firstElementChild.id = "rotate-me";
        }
      });
    });

  };
};

const displayDetails = () => {
  chevrons.forEach((chevron) => {
    chevron.addEventListener('click', (event) => {
      const details = event.currentTarget.parentElement.nextSibling.nextElementSibling
      console.log(details)
      details.classList.toggle('details-show');
    });
  });
};

export { rotateMe, displayDetails }
