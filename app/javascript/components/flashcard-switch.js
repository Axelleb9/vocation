const wordQuestion = document.getElementById("flashcard-question");
const wordAnswer = document.getElementById("flashcard-answer");
const flashcardButton = document.getElementById("flashcard-button");
const goodAnswer = document.getElementById("good-answer");
const wrongAnswer = document.getElementById("wrong-answer");
const seeMeaning = document.getElementById("see-meaning");

const switchCard = () => {
  flashcardButton.addEventListener("click", (event) => {
    console.log(event.currentTarget);
    wordQuestion.classList.add("d-none");
    wordAnswer.classList.remove("d-none");
    wrongAnswer.classList.remove("d-none");
    goodAnswer.classList.remove("d-none");
    seeMeaning.classList.add("d-none");
  });
};
// si constante appelée à l'intérieur de la méthode => exécuter, sinon, ignorer
export { switchCard };
