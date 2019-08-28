const displayDiv = document.querySelector(".display-div");
const chevronIcon = document.querySelectorAll(".chevron-icon");



const rotateMe = () => {
  chevronIcon.forEach(function(element) {
    element.addEventListener("click", (event) => {
      if (event.currentTarget.id === "test") {
        event.currentTarget.id = "rotate-me";
      } else if (event.currentTarget.id === "rotate-me") {
        event.currentTarget.id = "";
        event.currentTarget.id = "unrotate-me";
      } else {
        event.currentTarget.id = "rotate-me";
      }

    });
  });

}


export { rotateMe }
