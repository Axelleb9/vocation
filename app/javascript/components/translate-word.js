const infos = ["example/?", "difficulty/?", "definition/?", "reference/?"]
const base = "https://twinword-word-graph-dictionary.p.rapidapi.com/"

const host = "twinword-word-graph-dictionary.p.rapidapi.com"

const headers = {
  "x-rapidapi-host": host,
  "twin_key": process.env.TWINKEY,
  "RapidAPIProject": process.env.PROJECTID
}


const myInit = {
  method: 'GET',
  headers: headers,
  mode: 'cors',
  cache: 'default'
};

const translate = () => {
  infos.forEach((info) => {
    var url = `${base + info}entry=mask`
    fetch(url, myInit)
      .then(response => response.json())
      .then((data) => {
        console.log(data)
    });
  });
};

export { translate }
