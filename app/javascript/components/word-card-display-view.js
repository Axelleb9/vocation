const chevronIcon = document.querySelectorAll(".display-content");


const rotateMe = () => {
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


export { rotateMe }
