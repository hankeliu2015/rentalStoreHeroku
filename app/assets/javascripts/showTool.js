$(document).ready(function(){
  showToolClickHandlers()
})

const showToolClickHandlers = function(){
  $("a#show-tool").on("click", function(e){
    e.preventDefault();
    let id = parseInt(this.dataset["toolId"])
    fetch(`tools/${id}.json`)
    .then(function(res) {
      return res.json()
    })
    .then(function(tool){
      console.log(tool)
      $("#tool-container").html("")
      
      let newTool = new Tool(tool)
      let toolHTML = newTool.formatTool()
      $("#tool-container").html(toolHTML)
    })
  })
}

function Tool (tool) {
  this.id = tool.id
  this.name = tool.name
  this.brand = tool.Brand
  this.description = tool.description
  this.condition = tool.condition
  this.rental_price = tool.rental_price
  this.image = tool.image
}

Tool.prototype.formatTool = function() {
  let val = `
    <h4> ${this.name} </h4>
    <ul>
      <li>${this.description} </li>
      <li>${this.brand} </li>
      <li>${this.rental_price} </li>

    </ul>
  `
  return val
}
