const answers = document.querySelectorAll('.possible-answer');

const quizzTransition = () => {
  answers.forEach((answer) => {
    answer.addEventListener('click', (event) => {
      setTimeout(quizzTransition, 2000);
      event.currentTarget.style.backgroundColor = "#007AB3"
    });
  });
}
