$(document).ready(function(){
  showToolClickHandlers()
})

const showToolClickHandlers = function(){
  $("a#show-tool").on("click", function(e){
    e.preventDefault();
    let id = parseInt(this.dataset["toolId"])
    fetch(`tools/${id}.json`)
    .then(function(res) {
      debugger
      return res.json()
    })
    .then(function(tool){
      console.log(tool)
    })
  })
}
